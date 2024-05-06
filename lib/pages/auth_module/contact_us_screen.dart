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

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: userDataNotifier.value!.fullName);
  TextEditingController emailController = TextEditingController(text: userDataNotifier.value!.email);
  TextEditingController messageController = TextEditingController();

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
                      'Contact Us',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  vSizedBox3,
                  InputTextFieldWidget(
                    controller: nameController,
                    borderRadius: 15,
                    hintText: "Full Name",
                    validator: (val) =>
                        ValidationFunction.requiredValidation(val),
                    keyboardType: TextInputType.text,
                  ),
                  vSizedBox2,
                  InputTextFieldWidget(
                    controller: emailController,
                    borderRadius: 15,
                    hintText: "Email Address",
                    validator: (val) => ValidationFunction.emailValidation(val),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  vSizedBox2,
                  InputTextFieldWidget(
                    controller: messageController,
                    borderRadius: 15,
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    hintText: "Enter your message here...",
                    validator: (val) => ValidationFunction.requiredValidation(
                      val,
                    ),
                  ),
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return RoundEdgedButton(
                      text: "Send",
                      load: authProvider.load,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          var request = {
                            ApiKeys.fullName: nameController.text,
                            ApiKeys.email: emailController.text,
                            ApiKeys.message: messageController.text,
                          };
                          authProvider.contactUs(context,
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
