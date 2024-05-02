import 'package:flutter/material.dart';
import 'package:by_your_way/widget/round_edged_button.dart';

import '../constants/global_keys.dart';
import '../constants/my_colors.dart';
import '../constants/sized_box.dart';
import 'custom_text.dart';


Future<bool?>  showCustomConfirmationDialog(
    {
      required String headingMessage,
      String? description,

    }
    )async{
  return await showDialog(
      context: MyGlobalKeys.navigatorKey.currentContext!,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubHeadingText(
                  headingMessage,
                  color: Colors.red,
                  fontSize: 22,
                ),
                vSizedBox,
                if(description!=null)
                  ParagraphText( description),
                if(description!=null)
                  vSizedBox2,
                vSizedBox2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundEdgedButton(
                      text: 'No',
                      verticalPadding: 0,
                      // horizontalPadding: 0,
                      height: 36,
                      width: 100,
                      color: MyColors.primaryColor,
                      isSolid: false,
                      onTap: () {
                        Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
                      },
                    ),
                    hSizedBox2,
                    RoundEdgedButton(
                      text: 'Yes',
                      verticalPadding: 0,
                      height: 36,
                      width: 100,
                      color: MyColors.primaryColor,
                      onTap: () {
                        Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!, true);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}