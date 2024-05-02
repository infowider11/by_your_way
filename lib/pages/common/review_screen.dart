import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void init() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Image.asset(
            MyImagesUrl.imageHomeScreen,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              isBackIcon: true,
              titleText: 'Back',
            ),
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  vSizedBox2,
                  Expanded(child: reviewList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
