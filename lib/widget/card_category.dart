import 'package:flutter/material.dart';
import 'package:medical_app/theme.dart';

class CardCategory extends StatelessWidget {
  final String imageCategory;
  final String nameCategory;

  CardCategory({
    required this.imageCategory,
    required this.nameCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts widget height to content
        children: [
          Image.asset(
            imageCategory,
            width: 30,
            height: 30, // Adjust image height as needed
            fit: BoxFit.contain, // Ensures image fits within container
          ),
          SizedBox(height: 6),
          Text(
            nameCategory,
            style: mediumTextStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
