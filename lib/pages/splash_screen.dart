import 'package:flutter/material.dart';
import 'package:medical_app/pages/login_page.dart';
import 'package:medical_app/pages/register_page.dart';
import 'package:medical_app/widget/button_primary.dart';
import 'package:medical_app/widget/general_logo_space.dart';
import 'package:medical_app/widget/widget_illustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_page.dart';
import 'network/module/pref_profile_modell.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer)!;
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
        context as BuildContext, MaterialPageRoute(builder: (context) => MainPages()));
  }

  @override
  void initState() {

    super.initState();
    getPref();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: GeneralLogoSpace(child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          WidgetIllustration(
            image: "assets/splash_ilustration.png",
            title: "Find your medical\nsolution",
            subtitle1: "Consult with a doctor",
            subtitle2: "where ever & when ever you want",
            child: ButtonPrimary(
            text: "GET STARTED",
            onTap: () {
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPages()));
            },
          ),
          ),
        ],
      ),),
    );
  }
}
