import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/login_screen.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';
import '../../constants/my_image_url.dart';
import '../../widget/round_edged_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0.0,
        child: Stack(
          children: [
            CustomCircularImage(
              imageUrl: MyImagesUrl.imageIntroScreen,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              borderRadius: 0,
              fileType: CustomFileType.asset,
              fit: BoxFit.cover,
            ),
            const Scaffold(
              backgroundColor: MyColors.transparent,
              body: Padding(
                padding: EdgeInsets.only(
                    left: globalHorizontalPadding,
                    right: globalHorizontalPadding,
                    top: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParagraphText(
                      "Welcome To",
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                    ParagraphText(
                      "On Your Way",
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                      color: MyColors.primaryColor,
                    ),
                    vSizedBox3,
                    ParagraphText(
                      "Anytime Any Where.",
                      fontWeight: FontWeight.w300,
                      fontSize: 26,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: globalHorizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundEdgedButton(
                      text: "Create an Account",
                      fontWeight: FontWeight.w500,
                      borderRadius: 15,
                      onTap: () {
                        push(context: context, screen: const PreSignUpScreen());
                      },
                    ),
                    RoundEdgedButton(
                      text: "Login",
                      isBorder: true,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.blackColor,
                      color: Colors.white,
                      borderColor: MyColors.blackColor,
                      borderRadius: 15,
                      onTap: () {
                        push(context: context, screen: const LoginScreen());
                      },
                    ),
                    vSizedBox2
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
