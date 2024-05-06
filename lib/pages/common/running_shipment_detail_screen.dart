import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/pages/common/bottom_tab.dart';
import 'package:by_your_way/pages/common/tracking_screen.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:provider/provider.dart';
import '../../constants/types/user_type.dart';
import '../../provider/bottom_tabbar_provider.dart';
import '../../widget/custom_appbar.dart';

class RunningShipmentDetailScreen extends StatefulWidget {
  final RequestType requestType;
  final int userTypeData;
  final bool isCompany;

  const RunningShipmentDetailScreen(
      {super.key,
      required this.requestType,
      required this.userTypeData,
      this.isCompany = false});

  @override
  State<RunningShipmentDetailScreen> createState() =>
      _RunningShipmentDetailScreenState();
}

class _RunningShipmentDetailScreenState
    extends State<RunningShipmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: CustomAppBar(
        titleText: 'Shipment summary',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: globalHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const MainHeadingText(
                    "Shipment ID:",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  hSizedBox,
                  MainHeadingText(
                    "#123245865841BAD",
                    fontSize: 14,
                    color: MyColors.blackColor50,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              vSizedBox2,
              MainHeadingText(
                widget.userTypeData == UserType.driver
                    ? widget.isCompany
                        ? "Company Detail"
                        : "User detail"
                    : "Driver Detail",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const CustomCircularImage(
                            imageUrl: MyImagesUrl.iconDummyUser,
                            width: 45,
                            height: 45,
                            borderRadius: 22,
                            padding: 0,
                            fileType: CustomFileType.asset),
                        hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ParagraphText(
                              "Simon	Dickens",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            vSizedBox05,
                            ParagraphText(
                              "Apt. 231 63825 Circle,",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.blackColor50,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (!widget.isCompany)
                    CustomGestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          MyImagesUrl.iconMessage,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  if (!widget.isCompany) hSizedBox,
                  if (!widget.isCompany)
                    CustomGestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          MyImagesUrl.iconCall,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    )
                ],
              ),
              vSizedBox2,
              const MainHeadingText(
                "Addresses",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ParagraphText(
                    "Destination Address",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  ParagraphText(
                    "414, abc road, california | 03-Apr-2024",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: MyColors.blackColor50,
                  )
                ],
              ),
              vSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ParagraphText(
                    "Pickup Address",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  ParagraphText(
                    "414, abc road, california | 03-Apr-2024",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: MyColors.blackColor50,
                  )
                ],
              ),
              vSizedBox2,
              const MainHeadingText(
                "Shipment Detail",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonCard(
                      heading: 'Package Type',
                      title: 'Box',
                      imageUrl: MyImagesUrl.iconPackageType),
                  hSizedBox2,
                  commonCard(
                      heading: 'Wight',
                      title: '4.5 Kg',
                      imageUrl: MyImagesUrl.iconWeight),
                ],
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonCard(
                      heading: 'Quantity',
                      title: '3',
                      imageUrl: MyImagesUrl.iconQuantity),
                  hSizedBox2,
                  commonCard(
                      heading: 'Distance',
                      title: '50 Km',
                      imageUrl: MyImagesUrl.iconDistance),
                ],
              ),
              vSizedBox2,
              const MainHeadingText(
                "Contact Person Information",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         ParagraphText(
                          "${userDataNotifier.value!.fullName}",
                          // "John Doe",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        vSizedBox05,
                        ParagraphText(
                          '+91 255184848',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: MyColors.blackColor50,
                        )
                      ],
                    ),
                  ),
                  if (!widget.isCompany)
                    CustomGestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          MyImagesUrl.iconCall,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    )
                ],
              ),
              vSizedBox2,
              const MainHeadingText(
                "Uploaded Images",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox,
              uploadedImageView(),
              vSizedBox3,
              RoundEdgedButton(
                text: "Track Order",
                verticalMargin: 0,
                borderRadius: 15,
                onTap: () {
                  push(
                      context: context,
                      screen: TrackingScreen(
                        isCompany: widget.isCompany,
                      ));
                },
              ),
              vSizedBox05,
              Center(
                child: CustomGestureDetector(
                  onTap: () {
                    Provider.of<BottomTabBarProvider>(context, listen: false)
                        .changeIndex(index: 0);
                    pushAndRemoveUntil(
                        context: context, screen: const BottomBarScreen());
                  },
                  borderRadius: 5,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: MainHeadingText("Back to Home",
                        fontWeight: FontWeight.w500,
                        color: MyColors.primaryColor,
                        fontSize: 18,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              vSizedBox2,
            ],
          ),
        ),
      ),
    );
  }

  Widget commonCard({
    required String heading,
    required String title,
    required String imageUrl,
  }) {
    return Expanded(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ParagraphText(
                heading,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              ParagraphText(
                title,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColors.blackColor50,
              )
            ],
          )
        ],
      ),
    );
  }
}
