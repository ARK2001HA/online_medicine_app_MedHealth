import 'package:flutter/material.dart';
import 'package:medical_app/pages/historypage.dart';
import 'package:medical_app/pages/homepage.dart';
import 'package:medical_app/pages/profilepage.dart';
import 'package:medical_app/theme.dart';

class MainPages extends StatefulWidget
{
  @override
  _MainPagesState createState() => _MainPagesState();
}
class _MainPagesState extends State<MainPages>
{
  int _selectIndex = 0;

  final _pageList = [
    HomePages(),
    HistoryPages(),
    ProfilePages(),
  ];
  
  onTappedItem(int index)
  {
    setState(() {
      _selectIndex = index;
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "History"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "Profile"
          ),
        ],
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
      ),
    );
  }
}