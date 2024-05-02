import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/signup_screen.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_gesture_detector.dart';

enum UserTypeData {
  // ignore: constant_identifier_names
  User,
  // ignore: constant_identifier_names
  Driver,
  // ignore: constant_identifier_names
  Company,
}

class PreSignUpScreen extends StatefulWidget {
  const PreSignUpScreen({super.key});

  @override
  State<PreSignUpScreen> createState() => _PreSignUpScreenState();
}

class _PreSignUpScreenState extends State<PreSignUpScreen> {
  ValueNotifier<UserTypeData> userType = ValueNotifier(UserTypeData.User);

  List<String> iconList = [
    MyImagesUrl.iconUser,
    MyImagesUrl.iconDriver,
   // MyImagesUrl.iconCompany,
  ];
  List<UserTypeData> usersList = [
    UserTypeData.User,
    UserTypeData.Driver,
    //UserTypeData.Company
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => unFocusKeyBoard(),
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar: CustomAppBar(
            titleText: "   Sign Up",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: globalHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  vSizedBox2,
                  const MainHeadingText(
                    'Sign Up',
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                  vSizedBox,
                  ParagraphText(
                    "Select User Type to sign up.",
                    color: MyColors.blackColor.withOpacity(0.7),
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                  vSizedBox3,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder(
                        valueListenable: userType,
                        builder: (context, value, child) => Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: CustomGestureDetector(
                            borderRadius: 15,
                            onTap: () {
                              userType.value = usersList[index];
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: value == usersList[index]
                                        ? MyColors.primaryColor
                                        : MyColors.blackColor.withOpacity(0.7),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: value == usersList[index]
                                      ? MyColors.primaryColor.withOpacity(0.2)
                                      : Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomCircularImage(
                                        imageUrl: iconList[index],
                                        height: 32,
                                        width: 32,
                                        borderRadius: 0,
                                        fileType: CustomFileType.asset,
                                        fit: BoxFit.cover,
                                      ),
                                      hSizedBox2,
                                      ParagraphText(
                                        usersList[index].name,
                                        fontSize: 20,
                                      )
                                    ],
                                  ),
                                  if (value == usersList[index])
                                    const Icon(Icons.check_circle_sharp,
                                        color: MyColors.primaryColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: usersList.length,
                  ),
                  vSizedBox,
                  RoundEdgedButton(
                    text: "Continue",
                    fontWeight: FontWeight.w500,
                    borderRadius: 15,
                    onTap: () {
                      unFocusKeyBoard();
                      push(
                        context: context,
                        screen: SignupScreen(
                          userType: userType.value,
                        ),
                      );
                    },
                  ),
                  vSizedBox2,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
