import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/functions/validation_functions.dart';
import 'package:by_your_way/provider/auth_provider.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/sized_box.dart';
import '../../widget/custom_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailIdController = TextEditingController(
      // text: 'test@gmail.com'
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
                titleText: "  Forget Password",
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: globalHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MainHeadingText(
                        'Forget Password',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                      vSizedBox,
                      ParagraphText(
                        "Please enter your email ",
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
                        hintText: "Email address",
                        validator: (val) =>
                            ValidationFunction.emailValidation(val),
                      ),
                      vSizedBox2,
                      RoundEdgedButton(
                        text: "Submit",
                        load: authProvider.load,
                        fontWeight: FontWeight.w500,
                        borderRadius: 15,
                        onTap: () async{
                          unFocusKeyBoard();
                          if (formKey.currentState!.validate()) {

                             await authProvider.forgetPassword(
                              context,
                              email: emailIdController.text,
                            );
                             // popPage(context: context);
                          }
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
      }),
    );
  }
}
