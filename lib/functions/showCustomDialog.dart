import 'package:flutter/material.dart';

import '../constants/global_keys.dart';



Future<T?> showCustomDialog<T>(
    {
      required Widget child,
       double height = 200,
       double horizontalInsetPadding = 36,
       double verticalInsetPadding = 20,
       double horizontalPadding = 24,
       double verticalPadding = 28,
      // BuildContext? context

    }
    )async{
  return await showDialog<T>(
      context: MyGlobalKeys.navigatorKey.currentContext!,

      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: horizontalInsetPadding,vertical: verticalInsetPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            height: height,
            child: child,
          ),
        );
      });
}