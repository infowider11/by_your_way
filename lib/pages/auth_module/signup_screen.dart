import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/pages/auth_module/driver_signup_screen.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/pages/common/bottom_tab.dart';
import 'package:by_your_way/widget/common_alert_dailog.dart';
import 'package:by_your_way/widget/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import '../../constants/global_data.dart';
import '../../constants/my_colors.dart';
import '../../constants/sized_box.dart';
import '../../functions/navigation_functions.dart';
import '../../functions/validation_functions.dart';
import '../../provider/auth_provider.dart';
import '../../widget/custom_text.dart';
import '../../widget/input_text_field_widget.dart';
import '../../widget/round_edged_button.dart';
import 'package:country_picker/country_picker.dart';

class SignupScreen extends StatefulWidget {
  final UserTypeData userType;

  const SignupScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier<String> selectedCountryCode = ValueNotifier(defaultCountryCode);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                titleText: "   ${widget.userType.name} Sign Up",
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
                        vSizedBox2,
                        MainHeadingText(
                          '${widget.userType.name} Sign Up',
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                        vSizedBox,
                        ParagraphText(
                          "Please enter your details.",
                          color: MyColors.blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        vSizedBox3,
                        InputTextFieldWidget(
                          controller: firstNameController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.name,
                          hintText: "First Name",
                          validator: (val) =>
                              ValidationFunction.requiredValidation(val),
                        ),
                        vSizedBox,
                        InputTextFieldWidget(
                          controller: lastNameController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.name,
                          hintText: "Last Name",
                          validator: (val) =>
                              ValidationFunction.requiredValidation(val),
                        ),
                        vSizedBox,
                        ValueListenableBuilder(
                            valueListenable: selectedCountryCode,
                            builder: (context, value, child) {
                              return InputTextFieldWidget(
                                controller: mobileNumberController,
                                borderRadius: 15,
                                fillColor: MyColors.whiteColor,
                                keyboardType: TextInputType.number,
                                hintText: "Mobile No.",
                                validator: (val) =>
                                    ValidationFunction.mobileNumberValidation(
                                        val),
                                prefix: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      // optional. Shows phone code before the country name.
                                      onSelect: (value) {
                                        selectedCountryCode.value =
                                            value.phoneCode;
                                      },
                                    );
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "+$value",
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(Icons.keyboard_arrow_down,
                                            size: 20, color: Colors.black),
                                        const SizedBox(width: 4),
                                        const VerticalDivider(
                                          width: 2,
                                          indent: 8,
                                          endIndent: 8,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        vSizedBox,
                        InputTextFieldWidget(
                          controller: emailAddressController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email Address",
                          validator: (val) =>
                              ValidationFunction.emailValidation(val),
                        ),
                        vSizedBox,
                        InputTextFieldWidget(
                          controller: passwordController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          hintText: "Password",
                          validator: (val) =>
                              ValidationFunction.passwordValidation(val),
                        ),
                        vSizedBox,
                        InputTextFieldWidget(
                          controller: confirmPasswordController,
                          borderRadius: 15,
                          obscureText: true,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Confirm Password",
                          validator: (val) =>
                              ValidationFunction.confirmPasswordValidation(
                                  val, passwordController.text),
                        ),
                        vSizedBox,
                        RoundEdgedButton(
                          text: widget.userType == UserTypeData.User
                              ? "Sign Up"
                              : "Next",
                          load: authProvider.load,
                          fontWeight: FontWeight.w500,
                          borderRadius: 15,
                          onTap: () async {
                            unFocusKeyBoard();
                            if (formKey.currentState!.validate()) {
                              if (widget.userType == UserTypeData.User) {
                                userType = widget.userType;
                                pushAndRemoveUntil(
                                    context: context,
                                    screen: const BottomBarScreen());
                                /* authProvider.signup(
                                  context,
                                  request: {
                                    ApiKeys.firstName:
                                        firstNameController.text.trim(),
                                    ApiKeys.lastName:
                                        lastNameController.text.trim(),
                                    ApiKeys.phone:
                                        mobileNumberController.text.trim(),
                                    ApiKeys.country_code:
                                        selectedCountryCode.value,
                                    ApiKeys.email:
                                        emailAddressController.text.trim(),
                                    ApiKeys.password:
                                        passwordController.text.trim(),
                                    ApiKeys.userType: widget.userType.name
                                  },
                                );*/
                              } else if (widget.userType ==
                                  UserTypeData.Company) {
                                await showSuccessPopup(
                                  context: context,
                                  heading: "Congratulations!!",
                                  subtitle:
                                      "Your Registration has been completed Successfully. Admin will check your documents and back to you 3-4 business days",
                                  bottomWidget: Center(
                                    child: RoundEdgedButton(
                                      text: "OK",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      height: 50,
                                      width: 90,
                                      borderRadius: 10,
                                      onTap: () {
                                        userType = UserTypeData.Company;
                                        pushAndRemoveUntil(
                                          context: context,
                                          screen: const BottomBarScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                push(
                                    context: context,
                                    screen: DriverSignupScreen(
                                      request: {
                                        ApiKeys.firstName:
                                            firstNameController.text.trim(),
                                        ApiKeys.lastName:
                                            lastNameController.text.trim(),
                                        ApiKeys.phone:
                                            mobileNumberController.text.trim(),
                                        ApiKeys.country_code:
                                            selectedCountryCode.value,
                                        ApiKeys.email:
                                            emailAddressController.text.trim(),
                                        ApiKeys.password:
                                            passwordController.text.trim(),
                                        ApiKeys.userType: widget.userType.name
                                      },
                                    ));
                              }
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
                            popPage(
                              context: context,
                            );
                            popPage(
                              context: context,
                            );
                          },
                          child: Center(
                            child: RichTextCustomWidget(
                              firstText: 'Already have an account? ',
                              secondText: 'Login',
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
