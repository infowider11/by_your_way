import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:flutter/material.dart';

class DriverSearchScreen extends StatefulWidget {
  const DriverSearchScreen({super.key});

  @override
  State<DriverSearchScreen> createState() => _DriverSearchScreenState();
}

class _DriverSearchScreenState extends State<DriverSearchScreen> {
  PageController pageController = PageController();
  ValueNotifier<int> selectedTab = ValueNotifier(0);
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
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
              titleText: "Back",
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: globalHorizontalPadding),
                  child: InputTextFieldWidget(
                    controller: searchController,
                    borderRadius: 30,
                    contentPaddingVertical: 7,
                    prefix: const Icon(
                      Icons.search,
                      size: 24,
                    ),
                    fillColor: MyColors.whiteColor,
                    keyboardType: TextInputType.text,
                    hintText: "Search here for User & Company",
                  ),
                ),
                vSizedBox2,
                Expanded(
                  child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: value == 0
                                              ? MyColors.primaryColor
                                              : MyColors.greyColor),
                                      child: MainHeadingText(
                                        "Users",
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
                                        "Company",
                                        fontSize: 13,
                                        color: value == 1
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
                                commonListView(
                                    requestType: RequestType.pending),
                                companyListView(
                                    requestType: RequestType.pending),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget companyListView({required RequestType requestType}) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return commonCompanyCard();
      },
      itemCount: 10,
    );
  }
}
