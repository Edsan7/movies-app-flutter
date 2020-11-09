import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;
  final double horizontalPadding;
  final Color color;
  
  const CustomDivider({
    this.thickness = 0.5,
    this.horizontalPadding = 0,
    this.color = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Divider(
        thickness: thickness,
        color: color,
      ),
    );
  }
}