import 'package:by_your_way/functions/common_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_text.dart';
import '../../functions/validation_functions.dart';
import '../../provider/auth_provider.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/input_text_field_widget.dart';
import '../../widget/round_edged_button.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocusKeyBoard(),
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: CustomAppBar(
          titleText: 'Back',
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: globalHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  vSizedBox05,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SubHeadingText(
                      'Change Password',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  vSizedBox3,
                  InputTextFieldWidget(
                    obscureText: true,
                    controller: oldPassController,
                    borderRadius: 15,
                    hintText: "Old Password",
                    validator: (val) =>
                        ValidationFunction.passwordValidation(val),
                  ),
                  vSizedBox2,
                  InputTextFieldWidget(
                    obscureText: true,
                    controller: newPassController,
                    borderRadius: 15,
                    hintText: "New Password",
                    validator: (val) =>
                        ValidationFunction.passwordValidation(val),
                  ),
                  vSizedBox2,
                  InputTextFieldWidget(
                    obscureText: true,
                    controller: confirmPassCont,
                    borderRadius: 15,
                    hintText: "Confirm Password",
                    validator: (val) =>
                        ValidationFunction.confirmPasswordValidation(
                            val, newPassController.text),
                  ),
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return RoundEdgedButton(
                      text: "Update",
                      load: authProvider.load,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          var request = {
                            ApiKeys.oldPassword: oldPassController.text,
                            ApiKeys.newPassword: newPassController.text,
                          };
                          authProvider.changePassword(context,
                              request: request);
                        }
                      },
                      verticalMargin: 20,
                      fontSize: 18,
                      borderRadius: 15,
                      fontWeight: FontWeight.w700,
                      color: MyColors.primaryColor,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
