import 'dart:io';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/provider/auth_provider.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_text.dart';
import '../../constants/my_image_url.dart';
import '../../functions/validation_functions.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_circular_image.dart';
import '../../widget/image_picker.dart';
import '../../widget/input_text_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier<String> selectedCountryCode = ValueNotifier(defaultCountryCode);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  ValueNotifier<File?> image = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

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
                      'Edit Profile',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  vSizedBox3,
                  ValueListenableBuilder(
                    valueListenable: image,
                    builder: (context, value, child) => Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: userDataNotifier,
                            builder: (context, userData, child) {
                              return CustomCircularImage(
                                fileType: value != null
                                    ? CustomFileType.file
                                    : userData?.profileImage == null
                                        ? CustomFileType.asset
                                        : CustomFileType.network,
                                imageUrl: userData?.profileImage == null
                                    ? MyImagesUrl.iconDummyUser
                                    : userData!.profileImage,
                                image: value,
                                width: 110,
                                height: 110,
                                borderRadius: 100,
                              );
                            }),
                        GestureDetector(
                          onTap: () async {
                            unFocusKeyBoard();
                            var img = await cameraGalleryPicker(context);
                            if (img != null) {
                              image.value = img['value'];
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: MyColors.whiteColor)),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  vSizedBox4,
                  InputTextFieldWidget(
                    controller: firstNameController,
                    hintText: "First Name",
                    borderRadius: 15,
                    validator: (val) =>
                        ValidationFunction.requiredValidation(val),
                  ),
                  vSizedBox2,
                  InputTextFieldWidget(
                    controller: lastNameController,
                    borderRadius: 15,
                    hintText: "Last Name",
                    validator: (val) =>
                        ValidationFunction.requiredValidation(val),
                  ),
                  vSizedBox2,
                  InputTextFieldWidget(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    // readOnly: true,
                    borderRadius: 15,
                    //enabled: false,
                    validator: (val) => ValidationFunction.emailValidation(val),
                  ),
                  vSizedBox2,
                  ValueListenableBuilder(
                      valueListenable: selectedCountryCode,
                      builder: (context, value, child) {
                        return InputTextFieldWidget(
                          controller: phoneNumberController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.number,
                          hintText: "Mobile No.",
                          validator: (val) =>
                              ValidationFunction.mobileNumberValidation(val),
                          prefix: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                // optional. Shows phone code before the country name.
                                onSelect: (value) {
                                  selectedCountryCode.value = value.phoneCode;
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
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, chile) {
                    return RoundEdgedButton(
                      text: "Update",
                      borderRadius: 15,
                      load: authProvider.load,
                      onTap: () async {
                        unFocusKeyBoard();
                        if (formKey.currentState!.validate()) {
                          var request = {
                            ApiKeys.firstName: firstNameController.text.trim(),
                            ApiKeys.lastName: lastNameController.text.trim(),
                            ApiKeys.email: emailController.text.trim(),
                            ApiKeys.country_code: selectedCountryCode.value,
                            ApiKeys.phone: phoneNumberController.text.trim(),
                          };
                          request;
                          popPage(context: context);
                        /*  authProvider.editProfileFunction(
                              context: context,
                              request: request,
                              files: image.value != null
                                  ? {ApiKeys.profileImage: image.value!}
                                  : null);*/
                        }
                      },
                      verticalMargin: 20,
                      fontSize: 18,
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
