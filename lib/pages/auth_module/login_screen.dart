import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/functions/validation_functions.dart';
import 'package:by_your_way/pages/auth_module/forget_pass_screen.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/pages/common/bottom_tab.dart';
import 'package:by_your_way/provider/auth_provider.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:by_your_way/widget/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_image_url.dart';
import '../../constants/sized_box.dart';
import '../../widget/custom_rich_text.dart';
import '../../widget/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailIdController = TextEditingController(
      // text: 'test@gmail.com'
      );
  TextEditingController passwordController = TextEditingController(
      // text: '123456'
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return GestureDetector(
          onTap: () => unFocusKeyBoard(),
          child: AbsorbPointer(
            absorbing: authProvider.load,
            child: Scaffold(
              backgroundColor: MyColors.whiteColor,
              appBar: CustomAppBar(
                titleText: "  Log In",
              ),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: globalHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: CustomCircularImage(
                              imageUrl: MyImagesUrl.imageLoginScreen,
                              height: 70,
                              width: 199,
                              borderRadius: 0,
                              fileType: CustomFileType.asset,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const MainHeadingText(
                          'Login',
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                        vSizedBox,
                        ParagraphText(
                          "Please enter your email and password",
                          color: MyColors.blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        vSizedBox4,
                        InputTextFieldWidget(
                          controller: emailIdController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Username / Email address",
                          validator: (val) =>
                              ValidationFunction.emailValidation(val),
                        ),
                        vSizedBox2,
                        InputTextFieldWidget(
                          controller: passwordController,
                          borderRadius: 15,
                          obscureText: true,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Enter Password",
                          validator: (val) =>
                              ValidationFunction.passwordValidation(val),
                        ),
                        vSizedBox2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomGestureDetector(
                              onTap: () {
                                unFocusKeyBoard();
                                push(context: context, screen: const ForgotPasswordScreen());
                              },
                              child: ParagraphText(
                                "Forgot Password ?",
                                fontSize: 16,
                                color: MyColors.blackColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        vSizedBox2,
                        RoundEdgedButton(
                          text: "Login",
                          load: authProvider.load,
                          fontWeight: FontWeight.w500,
                          borderRadius: 15,
                          onTap: () {
                            unFocusKeyBoard();
                            if (formKey.currentState!.validate()) {
                              if (emailIdController.text.trim() ==
                                  "user@gmail.com") {
                                userType = UserTypeData.User;
                                pushAndRemoveUntil(
                                    context: context,
                                    screen: const BottomBarScreen());
                              } else if (emailIdController.text.trim() ==
                                  "company@gmail.com") {
                                userType = UserTypeData.Company;
                                pushAndRemoveUntil(
                                    context: context,
                                    screen: const BottomBarScreen());
                              } else if (emailIdController.text.trim() ==
                                  "driver@gmail.com") {
                                userType = UserTypeData.Driver;
                                pushAndRemoveUntil(
                                    context: context,
                                    screen: const BottomBarScreen());
                              } else {
                                showSnackbar("Invalid Credential!");
                              }

                              /*authProvider.login(context,
                                  email: emailIdController.text,
                                  password: passwordController.text);*/
                            }
                          },
                        ),
                        vSizedBox,
                        vSizedBox05,
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                height: 1,
                                endIndent: 10,
                              ),
                            ),
                            ParagraphText('or'),
                            Expanded(
                              child: Divider(
                                height: 1,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        vSizedBox2,
                        InkWell(
                          onTap: () {
                            unFocusKeyBoard();
                            push(
                                context: context,
                                screen: const PreSignUpScreen());
                          },
                          child: Center(
                            child: RichTextCustomWidget(
                              firstText: 'You don’t have an account? ',
                              secondText: 'Signup',
                              secondTextColor: MyColors.primaryColor,
                              secondTextDecoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        vSizedBox2,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
