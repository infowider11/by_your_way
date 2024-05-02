import 'package:by_your_way/constants/global_keys.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/showCustomDialog.dart';
import 'package:by_your_way/services/custom_navigation_services.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

showImageViewer({
  required String imageUrl,
  required CustomFileType fileType,

})async{
  return showCustomDialog(
    height: 440,
    verticalPadding: 10,
    verticalInsetPadding: 0,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(onTap:(){
                CustomNavigation.pop(MyGlobalKeys.navigatorKey.currentContext!);
              },child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.close),
              ),
                behavior: HitTestBehavior.opaque,
              )
            ],
          ),
          vSizedBox05,
          CustomCircularImage(
            imageUrl: imageUrl,
            fileType: fileType,
            height: 300,
            width: double.infinity,
            borderRadius: 8,

          ),
          RoundEdgedButton(text: 'Ok', onTap: (){
            CustomNavigation.pop(MyGlobalKeys.navigatorKey.currentContext!);
          },)
        ],
      ),
    )
  );
}