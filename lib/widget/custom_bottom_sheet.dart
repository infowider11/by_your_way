import 'package:flutter/material.dart';
import '../constants/global_data.dart';
import '../constants/my_colors.dart';

Future<void> customBottomSheet(context,
    {isHorizontalPadding = false, required child}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: MyColors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: EdgeInsets.symmetric(
                horizontal: isHorizontalPadding ? 0 : globalHorizontalPadding,
                vertical: isHorizontalPadding ? 0 : 20),
            decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(30)),
            child: child),
      );
    },
  );
}
