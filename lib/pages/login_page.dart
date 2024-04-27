import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_app/pages/register_page.dart';
import 'package:medical_app/theme.dart';
import 'package:medical_app/widget/button_primary.dart';
import 'package:medical_app/widget/general_logo_space.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main_page.dart';
import 'network/api/url_api.dart';
import 'network/module/pref_profile_modell.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide()
  {
    setState((){
      _secureText = !_secureText;
    });
  }

  // Move submitLogin outside of showHide
  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      "email": emailController.text,
      "password": passwordController.text
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String idUser = data['user_id'];
    String name = data['name'];
    String email = data['email'];
    String phone = data['phone'];
    String address = data['address'];
    String createdAt = data['created_at'];
    if (value == 1) {
      savePref(idUser, name, email, phone, address, createdAt);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPages()),
                      (route) => false,
                );
              },
              child: const Text("ok"),
            )
          ],
        ),
      );
      setState(() {});
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("ok"))
          ],
        ));
      setState(() {});
    }
  }

  savePref(String idUser, String name, String email, String phone,
      String address, String createdAt) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString(PrefProfile.idUSer, idUser);
      sharedPreferences.setString(PrefProfile.name, name);
      sharedPreferences.setString(PrefProfile.email, email);
      sharedPreferences.setString(PrefProfile.phone, phone);
      sharedPreferences.setString(PrefProfile.address, address);
      sharedPreferences.setString(PrefProfile.cretedAt, createdAt);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GeneralLogoSpace(),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text("LOGIN", style: regularTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("Login into your account!", style: regularTextStyle.copyWith(fontSize: 15, color: greyLightColor)
                ),
                // NOTE :: TEXT FIELD:: Email
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.only(left:16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x40000000),
                            offset: offset(0,1) ?? Offset.zero,
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Address',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                // NOTE :: TEXT FIELD:: Password
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.only(left:16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x40000000),
                            offset: offset(0,1) ?? Offset.zero,
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: _secureText
                              ? const Icon(Icons.visibility_off,
                            size: 20,
                          )
                              : const Icon(Icons.visibility_off,
                            size: 20,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "LOGIN",
                    onTap: () {
                      if (emailController.text.isEmpty || passwordController.text.isEmpty)
                      {
                        showDialog(
                            context: context,
                            builder: (context)=>AlertDialog(
                              title: const Text("Warning !!"),
                              content: const Text("Please, enter the fields"),
                              actions: [TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("ok"))],
                            ));
                      }
                      else
                      {
                        submitLogin();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                      style: lightTextStyle.copyWith(color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context)=>RegisterPages()),
                                (route) => false);
                      },
                      child: Text("Register Now!",
                        style: boldTextStyle.copyWith(color: greenColor, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Offset? offset(int i, int j) {
    //logic
    return Offset(i.toDouble(), j.toDouble());
  }
}
