import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/widget/card_history.dart';
import 'package:medical_app/widget/widget_illustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../theme.dart';
import 'network/api/url_api.dart';
import 'network/module/history_model.dart';
import 'network/module/pref_profile_modell.dart';
import '../widget/widget_illustration.dart';

class HistoryPages extends StatefulWidget {
  @override
  _HistoryPagesState createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> {
  List<HistoryOrdelModel> list = [];
  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer)!;
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder + userID);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          list.add(HistoryOrdelModel.fromJson(item));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Text(
                "History Order",
                style: regularTextStyle.copyWith(fontSize: 25),
              )),
          SizedBox(
            height: (list.length == 0) ? 80 : 20,
          ),
          list.length == 0
              ? Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: WidgetIllustration(
                child: Container(),
                image: "assets/no_history_ilustration.png",
                subtitle1: "You don't have history order",
                subtitle2: "let's shopping now",
                title: "Oops, there are no history order",
              ),
            ),
          )
              : ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: CardHistory(
                    model: x,
                  ),
                );
              }),
        ]),
      ),
    );
  }
}