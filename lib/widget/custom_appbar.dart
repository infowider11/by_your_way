import 'package:by_your_way/functions/common_function.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import '../constants/my_colors.dart';
import '../constants/my_image_url.dart';
import '../constants/sized_box.dart';
import '../functions/navigation_functions.dart';
import '../pages/common/notification_screen.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Color? bgcolor;
  Color? titleColor;
  String? titleText;
  String? imgUrl;
  Widget? title;
  double? toolbarHeight;
  Widget? subTitleWidget;
  double? titleFontSize;
  bool centerTitle;
  bool isBackIcon;
  bool isNotificationIcon;
  bool isEdit;
  bool bottomCurve;
  bool showBottomBorder;
  String? leadingIcon;
  FontWeight titleFontWeight;
  double leadingWidth;
  PreferredSizeWidget? bottom;
  Function()? onPressed;
  List<Widget>? actions;

  CustomAppBar({
    Key? key,
    this.bgcolor,
    this.titleColor,
    this.titleText,
    this.imgUrl,
    this.actions,
    this.bottom,
    this.title,
    this.titleFontWeight = FontWeight.w600,
    this.onPressed,
    this.leadingWidth = 0,
    this.titleFontSize = 18.0,
    this.subTitleWidget,
    this.showBottomBorder = true,
    this.centerTitle = false,
    this.bottomCurve = false,
    this.isBackIcon = true,
    this.isNotificationIcon = false,
    this.isEdit = false,
    this.toolbarHeight = 65.0,
    this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: toolbarHeight,
      shape: bottomCurve
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            )
          : null,
      title: title ??
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: centerTitle
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SubHeadingText(
                titleText ?? '',
                fontSize: titleFontSize,
                color: titleColor ?? MyColors.blackColor,
                fontWeight: titleFontWeight,
              ),
              subTitleWidget != null ? vSizedBox02 : Container(),
              subTitleWidget ?? Container()
            ],
          ),
      backgroundColor: bgcolor ?? MyColors.transparent,
      centerTitle: centerTitle,
      automaticallyImplyLeading: isBackIcon,
      titleSpacing: 0,
      leadingWidth: isBackIcon ? 45 : leadingWidth,
      leading: isBackIcon
          ? IconButton(
              onPressed: onPressed ??
                  () {
                    unFocusKeyBoard();
                    Navigator.pop(context);
                  },
              icon: Image.asset(
                leadingIcon ?? MyImagesUrl.iconBack,
                color: titleColor ?? MyColors.blackColor,
                height: 20,
                width: 20,
              ),
            )
          : imgUrl != null
              ? Center(
                  child: Image.asset(
                    imgUrl!,
                    height: 40,
                    width: 40,
                  ),
                )
              : Container(),
      actions: actions ??
          [
            if (isNotificationIcon)
              GestureDetector(
                onTap: () async {
                  push(context: context, screen: const NotificationScreen());
                },
                child: Image.asset(
                  MyImagesUrl.notification,
                  width: 25,
                ),
              ),
            if (isEdit)
              GestureDetector(
                onTap: () async {
                  push(context: context, screen: const NotificationScreen());
                },
                child: Image.asset(
                  MyImagesUrl.edit,
                  width: 20,
                ),
              ),
            hSizedBox2,
          ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight!);
}
