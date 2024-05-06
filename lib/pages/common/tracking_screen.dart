import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/pages/common/bottom_tab.dart';
import 'package:by_your_way/provider/bottom_tabbar_provider.dart';
import 'package:by_your_way/widget/common_alert_dailog.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_rich_text.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../../constants/types/user_type.dart';

class TrackingScreen extends StatefulWidget {
  final bool isCompany;

  const TrackingScreen({super.key, required this.isCompany});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: CustomAppBar(
        titleText: 'Track Shipment',
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
              Image.asset(
                MyImagesUrl.imageMap,
                width: double.infinity,
                height: 350,
              ),
              vSizedBox2,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainHeadingText(
                    "${cur}50.00",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.yellowColor,
                    ),
                    child: const ParagraphText('Running',
                        fontSize: 12,
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              vSizedBox,
              const Divider(
                height: 1,
              ),
              vSizedBox2,
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: globalHorizontalPadding,
                    vertical: globalHorizontalPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.primaryColor.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CustomCircularImage(
                            imageUrl: MyImagesUrl.iconDummyUser,
                            width: 50,
                            height: 50,
                            borderRadius: 25,
                            padding: 0,
                            fileType: CustomFileType.asset),
                        hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichTextCustomWidget(
                              firstText: 'Pickup: ',
                              firstTextColor: MyColors.greenColor,
                              firstTextFontSize: 16,
                              firstTextFontweight: FontWeight.w600,
                              secondText: 'California',
                              secondTextColor: MyColors.blackColor,
                              secondTextFontSize: 16,
                              secondTextFontweight: FontWeight.w600,
                            ),
                            ParagraphText(
                              "414, abc road, california | 03-Apr-2024",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.blackColor50,
                            )
                          ],
                        )
                      ],
                    ),
                    vSizedBox05,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 17, bottom: 2),
                          child: SizedBox(
                            height: 6,
                            child: VerticalDivider(
                                color: Colors.black, thickness: 1.2),
                          ),
                        ),
                      ],
                    ),
                    vSizedBox02,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 17, bottom: 2),
                          child: SizedBox(
                            height: 12,
                            child: VerticalDivider(
                                color: Colors.black, thickness: 1.2),
                          ),
                        ),
                      ],
                    ),
                    vSizedBox02,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 17,
                          ),
                          child: SizedBox(
                            height: 6,
                            child: VerticalDivider(
                                color: Colors.black, thickness: 1.2),
                          ),
                        ),
                      ],
                    ),
                    vSizedBox05,
                    Row(
                      children: [
                        Image.asset(
                          MyImagesUrl.iconLocation2,
                          height: 50,
                          width: 50,
                        ),
                        hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichTextCustomWidget(
                              firstText: 'Drop: ',
                              firstTextColor: MyColors.redColor,
                              firstTextFontSize: 16,
                              firstTextFontweight: FontWeight.w600,
                              secondText: 'Alaska',
                              secondTextColor: MyColors.blackColor,
                              secondTextFontSize: 16,
                              secondTextFontweight: FontWeight.w600,
                            ),
                            ParagraphText(
                              "414, abc road, california |10-Apr-2024",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.blackColor50,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              vSizedBox2,
              MainHeadingText(
                userDataNotifier.value!.userType == UserType.driver
                    ? widget.isCompany
                        ? "Company detail"
                        : "User detail"
                    : "Driver detail",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              vSizedBox,
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: globalHorizontalPadding, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: MyColors.blackColor50)),
                child: Row(
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
                    if (userDataNotifier.value!.userType == UserType.driver && !widget.isCompany)
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
                      )
                  ],
                ),
              ),
              vSizedBox2,
              if (userDataNotifier.value!.userType == UserType.driver)
                RoundEdgedButton(
                  text: "Mark As Complete",
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                  verticalMargin: 0,
                  borderRadius: 15,
                  onTap: () async {
                    await showSuccessPopup(
                      context: context,
                      heading: "Shipment Completed",
                      subtitle: "You have successfully shipped the package.",
                      bottomWidget: Center(
                        child: RoundEdgedButton(
                          text: "OK",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 50,
                          width: 200,
                          borderRadius: 10,
                          onTap: () {
                            Provider.of<BottomTabBarProvider>(context,
                                    listen: false)
                                .changeIndex(index: 0);
                            pushAndRemoveUntil(
                                context: context,
                                screen: const BottomBarScreen());
                          },
                        ),
                      ),
                    );
                  },
                ),
              vSizedBox2,
            ],
          ),
        ),
      ),
    );
  }
}
