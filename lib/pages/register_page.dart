import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/pages/network/api/url_api.dart';
import 'package:medical_app/pages/login_page.dart';
import 'package:medical_app/theme.dart';
import 'package:medical_app/widget/button_primary.dart';
import 'package:medical_app/widget/general_logo_space.dart';
import 'package:http/http.dart' as http;
class RegisterPages extends StatefulWidget
{
  const RegisterPages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages>
{
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  showHide()
  {
    setState((){
      _secureText = !_secureText;
    });
  }

  registerSubmit() async
  {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      "fullname" : fullNameController.text,
      "email" : emailController.text,
      "phone" : phoneController.text,
      "address": addressController.text,
      "password": passwordController.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if(value == 1)
      {
        // ignore: use_build_context_synchronously
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context)=>AlertDialog(
              title: const Text("Information"),
              content: Text(message),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(
                      builder: (context)=>LoginPages()),
                          (route) => false);
                },
                    child: const Text("ok"))
              ],
        ));
      }
    else
      {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context)=>AlertDialog(
              title: const Text("Information"),
              content: Text(message),
              actions: [TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("ok"))],
            ));
      }
    setState(() {});
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: ListView(
        children: [
          GeneralLogoSpace(),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("REGISTER", style: regularTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("Register your new account", style: regularTextStyle.copyWith(fontSize: 15, color: greyLightColor)
                ),

                // NOTE :: TEXT FIELD:: Full name
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
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor)),
                  ),
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
                // NOTE :: TEXT FIELD :: Phone
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
                    controller: phoneController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                // NOTE :: TEXT FIELD:: Address
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
                    controller: addressController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address',
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
                      text: "REGISTER",
                      onTap: () {
                        if (fullNameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty || addressController.text.isEmpty || passwordController.text.isEmpty)
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
                            registerSubmit();
                          }
                      },
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Already have an account? ",
                    style: lightTextStyle.copyWith(color: greyLightColor, fontSize: 15),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context)=>LoginPages()),
                              (route) => false);
                    },
                    child: Text(
                      "Login Now!",
                        style: boldTextStyle.copyWith(
                            color: greenColor,
                            fontSize: 15),
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