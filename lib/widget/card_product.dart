import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/theme.dart';

class CardProduct extends StatelessWidget {
  final String imageProduct;
  final String nameProduct;
  final String price;

  CardProduct({
    required this.imageProduct,
    required this.nameProduct,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0", "EN_US");

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, // Adjusts widget height to content
        children: [
          Flexible(
            flex: 2, // Adjusts image height relative to text
            child: Image.network(
              imageProduct,
              fit: BoxFit.contain, // Ensures image fits within container
            ),
          ),
          SizedBox(height: 8),
          Flexible(
            flex: 1, // Adjusts text height relative to image
            child: Text(
              nameProduct,
              style: regularTextStyle,
              textAlign: TextAlign.center,
              maxLines: 2, // Limits to 2 lines
              overflow: TextOverflow.ellipsis, // Handles overflow
            ),
          ),
          SizedBox(height: 4),
          Flexible(
            flex: 1, // Adjusts text height relative to image
            child: Text(
              price,
              style: boldTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
