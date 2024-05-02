import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_rich_text.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';

class DriverWalletScreen extends StatefulWidget {
  const DriverWalletScreen({super.key});

  @override
  State<DriverWalletScreen> createState() => _DriverWalletScreenState();
}

class _DriverWalletScreenState extends State<DriverWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50)),
          child: Image.asset(
            MyImagesUrl.imageWalletScreen,
            fit: BoxFit.fill,
            height: 250,
            width: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            isBackIcon: false,
            titleText: "     My Wallet",
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: globalHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParagraphText(
                      'Balance',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: MyColors.blackColor50,
                    ),
                    vSizedBox,
                    MainHeadingText(
                      "${cur}1500.00",
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      textAlign: TextAlign.start,
                    ),
                    vSizedBox,
                    CustomGestureDetector(
                      onTap: () {},
                      borderRadius: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.primaryColor),
                        child: const ParagraphText(
                          'Withdraw Request',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              vSizedBox6,
              vSizedBox,
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: globalHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MainHeadingText(
                      "Transactions",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ],
                ),
              ),
              vSizedBox3,
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
                        vSizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: globalHorizontalPadding),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 13),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 1, color: MyColors.blackColor50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomCircularImage(
                                          imageUrl: MyImagesUrl.iconDummyUser,
                                          width: 45,
                                          height: 45,
                                          borderRadius: 25,
                                          fileType: CustomFileType.asset),
                                      hSizedBox,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichTextCustomWidget(
                                              firstText: 'Received',
                                              secondText: ' ${cur}20 ',
                                              thirdText: "from Simon	Dickens",
                                              firstTextColor: MyColors
                                                  .blackColor
                                                  .withOpacity(0.5),
                                              secondTextColor:
                                                  MyColors.primaryColor,
                                              thirdTextColor:
                                                  MyColors.blackColor,
                                              firstTextFontSize: 15,
                                              secondTextFontSize: 15,
                                              thirdTextFontSize: 15,
                                              firstTextFontweight:
                                                  FontWeight.w500,
                                              secondTextFontweight:
                                                  FontWeight.w500,
                                              thirdTextFontweight:
                                                  FontWeight.w600,
                                            ),
                                            vSizedBox02,
                                            ParagraphText(
                                              'Sat, 23Apr, 2022 at 10:30 AM',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.blackColor50,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: MyColors.greenColor,
                                        ),
                                        child: const ParagraphText('Received',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: MyColors.whiteColor),
                                      )
                                    ],
                                  ),
                                ),
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
        ),
      ],
    );
  }
}
