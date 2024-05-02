import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/driver/driver_search_screen.dart';
import 'package:by_your_way/pages/common/shipment_detail_screen.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:flutter/material.dart';
import '../../functions/common_function.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        isBackIcon: false,
        title: Padding(
          padding: const EdgeInsets.only(left: globalHorizontalPadding),
          child: Row(
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
      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: globalHorizontalPadding),
            child: InputTextFieldWidget(
              controller: TextEditingController(),
              borderRadius: 30,
              enabled: true,
              readOnly: true,
              borderColor: Colors.transparent,
              onTap: () {
                push(context: context, screen: const DriverSearchScreen());
              },
              contentPaddingVertical: 7,
              prefix: const Icon(
                Icons.search,
                size: 24,
              ),
              fillColor: MyColors.whiteColor,
              keyboardType: TextInputType.emailAddress,
              hintText: "Search here for User & Company",
            ),
          ),
          vSizedBox2,
          Padding(
            padding:
            const EdgeInsets.only(left: globalHorizontalPadding, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MainHeadingText(
                  "Shipments By\nCompanies",
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
                CustomGestureDetector(
                  onTap: () {},
                  borderRadius: 5,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text(
                      'View All',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: MyColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          vSizedBox2,
          SizedBox(
            height: 130,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CustomGestureDetector(
                  onTap: () {
                    push(
                        context: context,
                        screen:  ShipmentDetailScreen(userTypeData: userType!,isCompany: true,));
                  },
                  borderRadius: 25,
                  child: Container(
                    height: 130,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width -
                        globalHorizontalPadding * 2,
                    margin: const EdgeInsets.only(
                        right: globalHorizontalPadding,
                        left: globalHorizontalPadding),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: MyColors.whiteColor,
                      border:
                      Border.all(width: 1, color: MyColors.blackColor50),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ParagraphText(
                              '#123245865841BAD',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: MyColors.blackColor50,
                            )
                          ],
                        ),
                        vSizedBox05,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainHeadingText(
                              "${cur}50.00",
                              fontSize: 16,
                            ),
                            const MainHeadingText(
                              "Weight: 200 kg",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: MyColors.primaryColor,
                              ),
                              child: const ParagraphText('View',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.whiteColor),
                            )
                          ],
                        ),
                        vSizedBox,
                        Divider(
                          height: 1,
                          color: MyColors.blackColor50,
                        ),
                        vSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MainHeadingText(
                                  "California",
                                  fontSize: 15,
                                ),
                                vSizedBox02,
                                ParagraphText(
                                  '03-Apr-2024',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.blackColor50,
                                )
                              ],
                            ),
                            Image.asset(
                              MyImagesUrl.iconArrowForword,
                              height: 12,
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const MainHeadingText(
                                  "Alaska",
                                  fontSize: 15,
                                ),
                                vSizedBox02,
                                ParagraphText(
                                  '10-Apr-2024',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.blackColor50,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: 3,
            ),
          ),
          vSizedBox2,
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: globalHorizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MainHeadingText(
                            "New Requests",
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                          CustomGestureDetector(
                            onTap: () {},
                            borderRadius: 5,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: MyColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    vSizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: globalHorizontalPadding),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return commonDriverCard(
                            requestType: RequestType.pending, index: index,
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                    vSizedBox2,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
