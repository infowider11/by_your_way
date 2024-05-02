import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/pages/bottom_sheet_view/add_payment_method_bottom_sheet.dart';
import 'package:by_your_way/pages/common/bottom_tab.dart';
import 'package:by_your_way/pages/common/chat_detail_screen.dart';
import 'package:by_your_way/provider/bottom_tabbar_provider.dart';
import 'package:by_your_way/widget/custom_bottom_sheet.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_rich_text.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:provider/provider.dart';
import '../../functions/common_function.dart';
import '../../widget/common_alert_dailog.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/round_edged_button.dart';

class ShipmentDetailScreen extends StatefulWidget {
  final UserTypeData userTypeData;
  final bool isCompany;

  const ShipmentDetailScreen({
    super.key,
    required this.userTypeData,
    this.isCompany = false,
  });

  @override
  State<ShipmentDetailScreen> createState() => _ShipmentDetailScreenState();
}

class _ShipmentDetailScreenState extends State<ShipmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: CustomAppBar(
        titleText: 'Detail Page',
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
              if (widget.userTypeData == UserTypeData.Driver)
                MainHeadingText(
                  widget.isCompany ? "Company detail" : "User detail",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              if (widget.userTypeData == UserTypeData.Driver) vSizedBox,
              if (widget.userTypeData == UserTypeData.Driver)
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
                  ],
                ),
              if (widget.userTypeData == UserTypeData.Driver) vSizedBox2,
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
              if (widget.userTypeData != UserTypeData.Driver)
                const MainHeadingText(
                  "Drivers who applied for this job",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              if (widget.userTypeData != UserTypeData.Driver) vSizedBox,
              if (widget.userTypeData != UserTypeData.Driver)
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: globalHorizontalPadding, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: MyColors.blackColor50, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomCircularImage(
                                imageUrl: MyImagesUrl.iconDummyUser,
                                width: 45,
                                height: 45,
                                borderRadius: 22,
                                padding: 0,
                                fileType: CustomFileType.asset),
                            hSizedBox,
                            Expanded(
                              child: Column(
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
                                  vSizedBox05,
                                  CustomGestureDetector(
                                    onTap: () {
                                      push(
                                          context: context,
                                          screen: const ChatDetailScreen());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: MyColors.blackColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.message,
                                            color: MyColors.whiteColor,
                                            size: 12,
                                          ),
                                          hSizedBox05,
                                          ParagraphText(
                                            "Chat",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: MyColors.whiteColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainHeadingText(
                                  "${cur}50.00",
                                  fontSize: 16,
                                  color: MyColors.primaryColor,
                                ),
                                vSizedBox2,
                                CustomGestureDetector(
                                  onTap: () async {
                                    await customBottomSheet(
                                      context,
                                      child: AddPaymentSheet(
                                        isAddPayment: false,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: MyColors.primaryColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ParagraphText(
                                          "Award",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                ),
              if (widget.userTypeData == UserTypeData.Driver)
                const MainHeadingText(
                  "Uploaded Images",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              if (widget.userTypeData == UserTypeData.Driver) vSizedBox,
              if (widget.userTypeData == UserTypeData.Driver)
                uploadedImageView(),
              if (widget.userTypeData == UserTypeData.Driver)
                RoundEdgedButton(
                  text: "Apply",
                  verticalMargin: 15,
                  borderRadius: 15,
                  onTap: () async {
                    await showSuccessPopup(
                      context: context,
                      heading: "Successfully Applied",
                      subtitle:
                          "You have successfully applied. You can now chat with user about shipment",
                      bottomWidget: Row(
                        mainAxisAlignment: widget.isCompany
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          CustomGestureDetector(
                            onTap: () {
                              Provider.of<BottomTabBarProvider>(context,
                                      listen: false)
                                  .changeIndex(index: 0);
                              pushAndRemoveUntil(
                                  context: context,
                                  screen: const BottomBarScreen());
                            },
                            borderRadius: 5,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: MainHeadingText("Go to Home",
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.primaryColor,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          if (!widget.isCompany)
                            RoundEdgedButton(
                              text: "Chat",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 40,
                              width: 80,
                              borderRadius: 10,
                              onTap: () {
                                popPage(context: context);
                                pushReplacement(
                                    context: context,
                                    screen: const ChatDetailScreen());
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyColors.blackColor50, width: 1),
        ),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              height: 30,
              width: 25,
            ),
            hSizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ParagraphText(
                  heading,
                  fontSize: 14,
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
      ),
    );
  }
}
