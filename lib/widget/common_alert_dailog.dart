import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:flutter/material.dart';


import '../constants/my_colors.dart';
import '../constants/sized_box.dart';
import 'custom_text.dart';
import 'round_edged_button.dart';


showCommonAlertDailog(context,
    {String? message,
    String? headingText,
    double? headingFontSize,
      FontWeight? headingFontWeight,
    Widget? richText,
    String? cancelButtonText,
    String? confirmButtonText,
    bool successIcon = false,
    bool error = false,
    MainAxisAlignment buttonAlignMent = MainAxisAlignment.end,
    bool showCancelButton = true,
    String? imageUrl,
    Icon? icon,
    List<Widget>? actions}) {
  return showDialog(
    context: context,
    barrierDismissible: false,

    barrierColor: Colors.black.withOpacity(0.3),
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: MyColors.whiteColor,
        backgroundColor: MyColors.whiteColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        titlePadding: const EdgeInsets.symmetric(vertical: 18),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        title: imageUrl != null
            ? Center(
                child: Image.asset(
                  imageUrl,
                  width: 70,
                  color: MyColors.primaryColor,
                ),
              )
            : icon != null
                ? Center(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border:
                                Border.all(color: MyColors.redColor, width: 2)),
                        child: icon),
                  )
                : successIcon
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                  color: MyColors.primaryColor, width: 2)),
                          child: const Icon(
                            Icons.done_outline_sharp,
                            color: MyColors.primaryColor,
                            size: 45,
                          ),
                        ),
                      ):error? Center(
          child: Container(
            // padding: const EdgeInsets.all(10),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.error_outline_outlined,
              color: MyColors.redColor,
              size: 60,
            ),
          ),
        )
                    :Container(),
        actions: actions ??
            [
              Row(
                mainAxisAlignment: buttonAlignMent,
                children: [
                  if (showCancelButton)
                    RoundEdgedButton(
                      text: "Cancel",
                      color: MyColors.blackColor50,
                      textColor: MyColors.blackColor,
                      width: 100,
                      height: 40,
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                    ),
                  hSizedBox2,
                  RoundEdgedButton(
                    text: confirmButtonText ?? "Ok",
                    width: 100,
                    height: 40,
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  hSizedBox,
                ],
              ),
            ],
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (headingText != null)
              Align(
                  alignment: Alignment.center,
                  child: SubHeadingText(
                    headingText,
                    fontSize:headingFontSize?? 22,
                    fontWeight:FontWeight.w600,
                  )),
            if (headingText != null) vSizedBox02,
            if (message != null)
              ParagraphText(
                message,
                fontSize: 16,
                textAlign: TextAlign.center,
                color: MyColors.blackColor,
              ),
            if (richText != null)
              richText
          ],
        ),
      );
    },
  );
}



Future<void> showSuccessPopup({
  required BuildContext context,
  required String heading,
  required String subtitle,
  required Widget bottomWidget,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: MyColors.whiteColor,
        insetPadding: const EdgeInsets.symmetric(
            horizontal: globalHorizontalPadding + globalHorizontalPadding),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: globalHorizontalPadding, vertical: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors.whiteColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainHeadingText(
                heading,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              vSizedBox2,
              Image.asset(
                MyImagesUrl.iconChecked,
                height: 92,
                width: 92,
              ),
              vSizedBox2,
              Center(
                  child: ParagraphText(
                    subtitle,
                    fontSize: 13,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                  )),
              vSizedBox,
              bottomWidget,
            ],
          ),
        ),
      );
    },
  );
}
