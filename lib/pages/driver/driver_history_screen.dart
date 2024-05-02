import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';

class DriverHistoryScreen extends StatefulWidget {
  const DriverHistoryScreen({super.key});

  @override
  State<DriverHistoryScreen> createState() => _DriverHistoryScreenState();
}

class _DriverHistoryScreenState extends State<DriverHistoryScreen> {
  PageController pageController = PageController();
  ValueNotifier<int> selectedTab = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        isBackIcon: false,
        title: Padding(
          padding: const EdgeInsets.only(left: globalHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                MyImagesUrl.iconLocation,
                height: 40,
                width: 40,
              ),
              hSizedBox2,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainHeadingText(
                      "Hello John!",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    MainHeadingText(
                      "Los Angeles, USA",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
              const CustomCircularImage(
                  imageUrl: MyImagesUrl.iconDummyUser,
                  width: 45,
                  height: 45,
                  borderRadius: 25,
                  padding: 0,
                  fileType: CustomFileType.asset),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: globalHorizontalPadding,
        ),
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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox2,
            ValueListenableBuilder(
                valueListenable: selectedTab,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomGestureDetector(
                        onTap: () {
                          if (value != 0) {
                            selectedTab.value = 0;
                            pageController.jumpToPage(0);
                          }
                        },
                        borderRadius: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: value == 0
                                  ? MyColors.primaryColor
                                  : MyColors.greyColor),
                          child: MainHeadingText(
                            "New",
                            fontSize: 13,
                            color: value == 0
                                ? MyColors.whiteColor
                                : MyColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      hSizedBox,
                      CustomGestureDetector(
                        onTap: () {
                          if (value != 1) {
                            selectedTab.value = 1;
                            pageController.jumpToPage(1);
                          }
                        },
                        borderRadius: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            color: value == 1
                                ? MyColors.primaryColor
                                : MyColors.greyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MainHeadingText(
                            "Running",
                            fontSize: 13,
                            color: value == 1
                                ? MyColors.whiteColor
                                : MyColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      hSizedBox,
                      CustomGestureDetector(
                        onTap: () {
                          if (value != 2) {
                            selectedTab.value = 2;
                            pageController.jumpToPage(2);
                          }
                        },
                        borderRadius: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 9),
                          decoration: BoxDecoration(
                            color: value == 2
                                ? MyColors.primaryColor
                                : MyColors.greyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MainHeadingText(
                            "Completed",
                            fontSize: 13,
                            color: value == 2
                                ? MyColors.whiteColor
                                : MyColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            vSizedBox,
            Expanded(
              child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    commonListView(requestType: RequestType.pending),
                    commonListView(requestType: RequestType.running),
                    commonListView(requestType: RequestType.completed),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget commonListView({required RequestType requestType}) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return commonDriverCard(
            requestType: requestType,
            backgroundColor: MyColors.primaryColor.withOpacity(0.05), index: index);
      },
      itemCount: 10,
    );
  }
}
