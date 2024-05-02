
import 'package:flutter/material.dart';

import '../constants/my_colors.dart';


// ignore: must_be_immutable
class RichTextCustomWidget extends StatelessWidget {
  String firstText;
  String secondText;
  String thirdText;
  double? firstTextFontSize;
  double? secondTextFontSize;
  double? thirdTextFontSize;
  double? height;
  Color? firstTextColor;
  Color? secondTextColor;
  Color? thirdTextColor;
  FontWeight? firstTextFontweight;
  String? firstTextFontFamily;
  String? secondTextFontFamily;
  String? thirdTextFontFamily;
  FontWeight? secondTextFontweight;
  FontWeight? thirdTextFontweight;
  TextDecoration? firstTextDecoration;
  TextDecoration? secondTextDecoration;
  TextDecoration? thirdTextDecoration;

  RichTextCustomWidget({
    super.key,
    required this.firstText,
    required this.secondText,
     this.thirdText='',
     this.height,
    this.firstTextFontFamily='Raleway-Regular',
    this.secondTextFontFamily='Raleway-Regular',
    this.thirdTextFontFamily='Raleway-Regular',
    this.firstTextFontSize = 18.0,
    this.secondTextFontSize = 18.0,
    this.thirdTextFontSize = 18.0,
    this.firstTextColor = MyColors.blackColor,
    this.secondTextColor = MyColors.blackColor,
    this.thirdTextColor = MyColors.blackColor,
    this.firstTextFontweight = FontWeight.w400,
    this.secondTextFontweight = FontWeight.w600,
    this.thirdTextFontweight = FontWeight.w400,
    this.firstTextDecoration,
    this.secondTextDecoration,
    this.thirdTextDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: firstText,

        style: TextStyle(
          height:height?? 1.3,
            fontFamily: firstTextFontFamily??"Poppins-Regular" ,
            fontSize: firstTextFontSize,
            color: firstTextColor,
            fontWeight: firstTextFontweight,
            decoration: firstTextDecoration),
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: TextStyle(
                fontFamily: secondTextFontFamily??"Poppins-Regular",
                fontSize: secondTextFontSize,
                color: secondTextColor,
                fontWeight: secondTextFontweight,
                decoration: secondTextDecoration),
          ),
          TextSpan(
            text: thirdText,
            style: TextStyle(
                fontFamily: thirdTextFontFamily??"Poppins-Regular",
                fontSize:thirdTextFontSize,
                color:thirdTextColor,
                fontWeight:thirdTextFontweight?? thirdTextFontweight,
                decoration:thirdTextDecoration),
          ),
        ],
      ),
    );
  }
}
