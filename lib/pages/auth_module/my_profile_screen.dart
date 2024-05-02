import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/provider/auth_provider.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_text.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<String> titleList = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() {
    if (userType == UserTypeData.Company) {
      titleList = [
        'My Profile',
        "Change Password",
        "Language",
        "Contact Us",
        "Terms & Conditions",
        "Privacy Policy",
        "Log Out",
      ];
    } else {
      titleList = [
        'My Profile',
        "Change Password",
        "Payment Method",
        "Language",
        "Contact Us",
        "Terms & Conditions",
        "Privacy Policy",
        "Log Out",
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        isBackIcon: false,
        title: const Padding(
          padding: EdgeInsets.only(left: globalHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainHeadingText(
                    "My Profile ",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ],
              ),
              CustomCircularImage(
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
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CustomCircularImage(
                                  imageUrl: MyImagesUrl.iconDummyUser,
                                  width: 100,
                                  height: 100,
                                  borderRadius: 50,
                                  padding: 0,
                                  fileType: CustomFileType.asset),
                              hSizedBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MainHeadingText(
                                      "John Doe",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    vSizedBox05,
                                    ParagraphText(
                                      "john@gmail.com",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.blackColor50,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        if (userType != UserTypeData.Company)
                          Image.asset(
                            MyImagesUrl.imageQr,
                            height: 45,
                            width: 45,
                          )
                      ],
                    ),
                    vSizedBox2,
                    Card(
                      margin: EdgeInsets.zero,
                      color: MyColors.whiteColor,
                      surfaceTintColor: MyColors.whiteColor,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: titleList.length,
                        itemBuilder: (context, index) {
                          return CustomGestureDetector(
                            onTap: () {
                              authProvider.clickOnProfileMenu(
                                  index: index, context: context);
                            },
                            borderRadiusEdge: index == 0
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))
                                : index == titleList.length - 1
                                    ? const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))
                                    : null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  vSizedBox2,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MainHeadingText(
                                          titleList[index],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: MyColors.blackColor50
                                              .withOpacity(0.3),
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  vSizedBox2,
                                  if (index != titleList.length - 1)
                                    Divider(
                                      height: 1,
                                      color: MyColors.blackColor50
                                          .withOpacity(0.2),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
