// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/global_data.dart';
import '../constants/my_colors.dart';
import '../constants/sized_box.dart';
import 'custom_text.dart';


class InputTextFieldWidget extends StatelessWidget {
  final Function()? onTap;
  final TextEditingController controller;
  final double? width;
  final Color? focusedBorderColor;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final Color? bgColor;
  final Color? fillColor;
  final double borderRadius;
  final Color? borderColor;
  final String hintText;
  final bool textalign;
  final Color? textColor;
  final String? headingText;
  final double? headingfontSize;
  final FontWeight? headingfontWeight;
  final double? fontsize;
  final double? hintTextFontsize;
  final Color? hintcolor;
  final double verticalPadding;
  final double? contentPaddingVertical;
  final double? contentPaddinghorizonatly;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? suffixText;
  final Widget? suffix;
  final Widget? prefix;
  final String? prefixText;
  TextInputType? keyboardType;
  final bool enabled;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final bool? autofocus;
  final bool? showShadow;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  bool filled;

  final Color? headingColor;
  InputTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.inputFormatters,
    this.contentPaddinghorizonatly,
    this.borderColor,
    this.maxLines,
    this.validator,
    this.maxLength,
    this.onSaved,
    this.headingfontWeight=FontWeight.w400,
    this.autofocus = false,
    this.readOnly = false,
    this.prefix,
    this.filled = true,
    this.headingfontSize = 18,
    this.headingText,
    this.contentPaddingVertical,
    this.horizontalPadding = false,
    this.obscureText = false,
    this.fillColor,
    this.bgColor,
    this.hintcolor,
    this.verticalPadding = 0,
    this.fontsize,
    this.hintTextFontsize,
    this.borderRadius = 30,
    this.keyboardType,
    this.onChanged,
    this.enabled = true,
    this.suffix,
    this.suffixText,
    this.textColor = MyColors.lightdark,
    this.focusedBorderColor,
    this.prefixText,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.textalign = false,
    this.showShadow = false,
    this.width, this.headingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding?globalHorizontalPadding:0, vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (headingText != null)
            SubHeadingText(
              headingText!,
              color: headingColor??MyColors.secondaryColor,
              fontSize: headingfontSize,
              fontWeight: headingfontWeight,
            ),
          if (headingText != null) vSizedBox05,
          Stack( alignment: Alignment.topCenter,
            children: [
              if(showShadow!)
              Container(
                height: 50,
                width: width ?? MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding?globalHorizontalPadding:0,
                    vertical: verticalPadding),
                decoration: BoxDecoration(
                    color: bgColor,
                    border: border,
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.blackColor.withOpacity(0.18),
                          blurRadius: 1.2,
                          spreadRadius:0
                      )
                    ]
                ),

              ),
              TextFormField(
                  cursorColor: MyColors.blackColor,
                  maxLines: maxLines ?? 1,
                  readOnly: readOnly,
                  maxLength: maxLength,
                  focusNode: focusNode,
                  textAlign: textalign ? TextAlign.center : TextAlign.left,
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: TextStyle(color: enabled?textColor:hintcolor??MyColors.blackColor50, fontSize: fontsize ?? 16,fontFamily: fontFamily),
                  autofocus: autofocus!,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  // enableInteractiveSelection: true,
                  inputFormatters: inputFormatters,
                  enabled: enabled,
                  decoration: InputDecoration(
                    enabled: enabled,
                    counterText: '',
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: filled,
                    fillColor: fillColor??MyColors.whiteColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color:borderColor??MyColors.enabledTextFieldBorderColor),
                      borderRadius: BorderRadius.circular(
                          borderRadius), // Set the border radius here
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:borderColor??MyColors.enabledTextFieldBorderColor),
                      borderRadius: BorderRadius.circular(
                          borderRadius), // Set the border radius here
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:borderColor??MyColors.disabledTextFieldBorderColor),
                      borderRadius: BorderRadius.circular(
                          borderRadius), // Set the border radius here
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: focusedBorderColor ?? Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(
                          borderRadius), // Set the border radius here
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: focusedBorderColor ?? Colors.blue),
                      borderRadius: BorderRadius.circular(
                          borderRadius), // Set the border radius here
                    ),

                    suffixIcon: suffix,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: contentPaddingVertical ?? 18,
                        horizontal: contentPaddinghorizonatly ?? 22),
                    suffixStyle: const TextStyle(fontSize: 16),
                    prefixIcon: prefix,
                    hintText: hintText,
                    suffixText: suffixText,
                    prefixText: prefixText,
                    prefixStyle: const TextStyle(fontSize: 16, color: Colors.black),
                    hintStyle: TextStyle(
                      color:hintcolor??MyColors.blackColor50,
                      fontSize: hintTextFontsize ?? 15,
                      fontWeight: FontWeight.w500
                    ),
                    // labelStyle: TextStyle(
                    //   color: hintcolor ?? MyColors.lightdark.withOpacity(0.5),
                    //   fontSize: hintTextFontsize ?? 13,
                    // ),
                    // border: headingText != null ? null : InputBorder.none,
                  ),
                  onChanged: onChanged,
                  onSaved: onSaved,
                  onTap: onTap,
                  validator: validator),
            ],
          ),
        ],
      ),
    );
  }
}
