import 'package:flutter/material.dart';
import '../constants/my_colors.dart';
import '../constants/sized_box.dart';
import 'custom_loader.dart';

class RoundEdgedButton extends StatelessWidget {
  final double? height;
  final Color color;
  final Color borderColor;
  final String text;
  final String? fontfamily;
  final Function()? onTap;
  final double horizontalMargin;
  final double iconHeight;
  final double iconWidth;
  final double verticalPadding;
  final double horizontlyPadding;
  final double verticalMargin;
  // final Gradient? gradient;
  final bool isSolid;

  final bool isBorder;
  final Color? textColor;
  final double? borderRadius;
  final bool isBold;
  final TextAlign textAlign;
  final bool isIconStart;
  final double? fontSize;
  final double? width;
  final String? icon;
  final bool showGradient;
  final bool showShadow;
  final FontWeight? fontWeight;
  final bool load;
  final bool isFlexible;
  final bool enabled;

  const RoundEdgedButton(
      {Key? key,
      this.color = MyColors.primaryColor,
        this.enabled = true,
      this.borderColor = MyColors.primaryColor,
      required this.text,
        this.isFlexible = false,
      this.onTap,
      this.horizontlyPadding = 8,
      this.horizontalMargin = 0,
      this.iconHeight = 18,
      this.iconWidth = 15,
      this.borderRadius = 30,
      this.isBold = false,
      this.isIconStart = true,
      this.isBorder = false,
      this.verticalMargin = 12,
      this.verticalPadding = 0,
      this.width,
      this.icon,
      this.showGradient = false,
      this.showShadow = false,
      this.height = 55,
      this.textColor,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 20,
      this.textAlign = TextAlign.center,
      this.fontfamily,
      this.load = false,
      // required this.hasGradient,
      this.isSolid = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: load ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: height,
          margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: verticalMargin),
          width: isFlexible?null:width ?? (MediaQuery.of(context).size.width),
          constraints: BoxConstraints(
            maxWidth: (MediaQuery.of(context).size.width),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: horizontlyPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            color:  !enabled?MyColors.greyColor:isSolid
                    ? color
                    : Colors.transparent,
            gradient: showGradient
                ? const LinearGradient(
                    // begin: FractionalOffset.topRight,
                    // end: FractionalOffset.bottomCenter,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xfff02321),
                      Color(0xff781211),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius!),
            border: isBorder
                ? Border.all(color: borderColor)
                : isSolid
                    ? null
                    : Border.all(color: borderColor),
            boxShadow: showShadow
                ? [
                    BoxShadow(
                        color: MyColors.blackColor.withOpacity(0.2),
                        blurRadius: 10)
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && isIconStart)
                Padding(
                  padding: EdgeInsets.only(
                      left: textAlign == TextAlign.center ? 2.0 : 0),
                  child: Image.asset(
                    icon!,
                    color: color == MyColors.primaryColor
                        ? MyColors.whiteColor
                        : null,
                    height: iconHeight,
                    width: iconWidth,
                  ),
                ),
              if (icon != null && isIconStart) hSizedBox02,
              Flexible(
                child: Text(
                  text,
                  textAlign: textAlign,
                  style: TextStyle(
                    color: textColor ??
                        ( isSolid
                                ? Colors.white
                                : color),
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
              if (icon != null && isIconStart == false)
                Padding(
                  padding: EdgeInsets.only(
                    right: textAlign == TextAlign.center ? 5.0 : 0,
                    left: textAlign == TextAlign.center ? 5.0 : 0,
                  ),
                  child: Image.asset(
                    icon!,
                    height: iconHeight,
                    width: iconWidth,
                  ),
                ),
              if (load)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomLoader(
                    color: textColor ??
                        (isSolid
                                ? Colors.white
                                : color),
                  ),
                )
            ],
          )),
    );
  }
}
