import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:medical_app/pages/search_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import '../widget/card_category.dart';
import '../widget/card_product.dart';
import 'cart_pages.dart';
import 'detail_product.dart';
import 'network/api/url_api.dart';
import 'network/module/pref_profile_modell.dart';
import 'network/module/product_model.dart';


class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  late int index;
  bool filter = false;
  List<CategoryWithProduct> listCategory = [];

  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      getProduct();
      totalCart();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer)!;
    });
  }

  var amountCart = "0";
  totalCart() async {
    var urlGetTotalCart = Uri.parse(BASEURL.getTotalCart + userID);
    final response = await http.get(urlGetTotalCart);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      String amount = data['amount'];
      setState(() {
        amountCart = amount;
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 155,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Find a medicine or\nvitamins with MEDHEALTH!",
                          style: regularTextStyle.copyWith(
                              fontSize: 15, color: greyBoldColor),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPages(totalCart)));
                          },
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: greenColor,
                          ),
                        ),
                        amountCart == "0"
                            ? SizedBox()
                            : Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(
                                  amountCart,
                                  style: regularTextStyle.copyWith(
                                      color: whiteColor, fontSize: 12),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchProduct()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffe4faf0)),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xffb1d8b2),
                          ),
                          hintText: "Search medicine ...",
                          hintStyle:
                          regularTextStyle.copyWith(color: Color(0xffb0d8b2))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Text(
                  "Medicine & Vitamins by Category",
                  style: regularTextStyle.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listCategory.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, i) {
                      final x = listCategory[i];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            index = i;
                            filter = true;
                            print("$index, $filter");
                          });
                        },
                        child: CardCategory(
                          imageCategory: x.image,
                          nameCategory: x.category,
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                filter
                    ? index == 7
                    ? Text("Feature on Progress")
                    : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listCategory[index].product.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, i) {
                      final y = listCategory[index].product[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                          nameProduct: y.nameProduct,
                          imageProduct: y.imageProduct,
                          price: y.price,
                        ),
                      );
                    })
                    : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listProduct.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, i) {
                      final y = listProduct[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                          nameProduct: y.nameProduct,
                          imageProduct: y.imageProduct,
                          price: "Rs. "+y.price,
                        ),
                      );
                    }),
              ],
            )));
  }
}