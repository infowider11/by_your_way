import 'package:flutter/material.dart';

import '../constants/global_keys.dart';

showSnackbar(String text,{int? seconds, BuildContext? context}){
  ScaffoldMessenger.of(context??MyGlobalKeys.navigatorKey.currentContext!).showSnackBar(
      SnackBar(content: Text(text),
        duration: Duration(seconds:seconds??2),
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // behavior: SnackBarBehavior.floating,
      )
  );
}