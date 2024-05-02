import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/functions/validation_functions.dart';
import 'package:by_your_way/provider/auth_provider.dart';
import 'package:by_your_way/widget/common_alert_dailog.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_drop_down_widget.dart';
import 'package:by_your_way/widget/custom_rich_text.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:by_your_way/widget/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../common/bottom_tab.dart';
import 'pre_signup_screen.dart';

class DriverSignupScreen extends StatefulWidget {
  final Map<String, dynamic> request;

  const DriverSignupScreen({super.key, required this.request});

  @override
  State<DriverSignupScreen> createState() => _DriverSignupScreenState();
}

class _DriverSignupScreenState extends State<DriverSignupScreen> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier selectedVehicleType = ValueNotifier(null);
  ValueNotifier selectedVehicleModel = ValueNotifier(null);
  ValueNotifier<XFile?> idProof = ValueNotifier(null);
  ValueNotifier<XFile?> drivingLicense = ValueNotifier(null);
  TextEditingController vNumber = TextEditingController();
  TextEditingController vYear = TextEditingController();
  TextEditingController vModel = TextEditingController();
  TextEditingController vMake = TextEditingController();

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
                titleText: "   Vehicle Information & Identity",
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
                        const ParagraphText(
                          "Upload your Identity documents.",
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                        vSizedBox2,
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: MyColors.blackColor.withOpacity(0.4),
                                width: 1),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainHeadingText(
                                "Upload ID proof",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              RoundEdgedButton(
                                text: "upload",
                                fontSize: 14,
                                height: 25,
                                width: 80,
                              ),
                            ],
                          ),
                        ),
                        vSizedBox2,
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: MyColors.blackColor.withOpacity(0.4),
                                width: 1),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainHeadingText(
                                "Upload Driving License",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              RoundEdgedButton(
                                text: "upload",
                                fontSize: 14,
                                height: 25,
                                width: 80,
                              ),
                            ],
                          ),
                        ),
                        vSizedBox3,
                        const ParagraphText(
                          "Enter Vehicle Information.",
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                        vSizedBox2,
                        ValueListenableBuilder(
                          valueListenable: selectedVehicleType,
                          builder: (_, value, __) => CustomDropDownField(
                            validator: (val) =>
                                ValidationFunction.requiredValidation(
                              val.toString(),
                            ),
                            headingFontSize: 18,
                            headingTextColor: MyColors.blackColor,
                            hintText: 'Select Vehicle Type',
                            onChanged: (val) {
                              selectedVehicleType.value = val;
                            },
                            itemsList: const [
                              {"name": "Two Sitter"},
                              {"name": "Three Sitter"},
                              {"name": "Four Sitter"},
                              {"name": "Six Sitter"},
                              {"name": "Eight Sitter"},
                            ],
                            borderRadius: 15,
                            selectedValue: value,
                            popUpTextKey: 'name',
                          ),
                        ),
                        vSizedBox,
                        Row(
                          children: [
                            Expanded(
                              child: InputTextFieldWidget(
                                controller: vNumber,
                                borderRadius: 15,
                                fillColor: MyColors.whiteColor,
                                keyboardType: TextInputType.text,
                                hintText: "Vehicle No.",
                                validator: (val) =>
                                    ValidationFunction.requiredValidation(val),
                              ),
                            ),
                            hSizedBox,
                            Expanded(
                              child: InputTextFieldWidget(
                                controller: vYear,
                                borderRadius: 15,
                                fillColor: MyColors.whiteColor,
                                keyboardType: TextInputType.datetime,
                                hintText: "Year",
                                validator: (val) =>
                                    ValidationFunction.requiredValidation(val),
                              ),
                            ),
                          ],
                        ),
                        vSizedBox,
                        InputTextFieldWidget(
                          controller: vMake,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Make",
                          validator: (val) =>
                              ValidationFunction.requiredValidation(val),
                        ),
                        vSizedBox,
                        ValueListenableBuilder(
                          valueListenable: selectedVehicleModel,
                          builder: (_, value, __) => CustomDropDownField(
                            validator: (val) =>
                                ValidationFunction.requiredValidation(
                              val.toString(),
                            ),
                            headingFontSize: 18,
                            headingTextColor: MyColors.blackColor,
                            hintText: 'Select Vehicle Model',
                            onChanged: (val) {
                              selectedVehicleModel.value = val;
                            },
                            itemsList: const [
                              {"name": "Model 1"},
                              {"name": "Model 2"},
                              {"name": "Model 3"},
                              {"name": "Model 4"},
                              {"name": "Model 5"},
                            ],
                            borderRadius: 15,
                            selectedValue: value,
                            popUpTextKey: 'name',
                          ),
                        ),
                        vSizedBox4,
                        Center(
                          child: ParagraphText(
                            "By clicking the button, acknowledge that you will accept our",
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: MyColors.blackColor.withOpacity(0.5),
                          ),
                        ),
                        vSizedBox02,
                        GestureDetector(
                          onTap: () {
                            unFocusKeyBoard();
                          },
                          child: Center(
                            child: RichTextCustomWidget(
                              firstText: 'Privacy Policy',
                              secondText: ' and ',
                              thirdText: "Terms and Conditions.",
                              firstTextColor: MyColors.primaryColor,
                              secondTextColor:
                                  MyColors.blackColor.withOpacity(0.5),
                              thirdTextColor: MyColors.primaryColor,
                              firstTextFontSize: 12,
                              secondTextFontSize: 12,
                              secondTextFontweight: FontWeight.w400,
                              thirdTextFontSize: 12,
                              firstTextDecoration: TextDecoration.underline,
                              thirdTextDecoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        vSizedBox2,
                        RoundEdgedButton(
                          text: "Continue",
                          load: authProvider.load,
                          fontWeight: FontWeight.w500,
                          borderRadius: 15,
                          onTap: () async {
                            unFocusKeyBoard();
                            if (formKey.currentState!.validate()) {
                              if (selectedVehicleType.value != null) {
                                if (selectedVehicleModel.value != null) {
                                  /* authProvider.signupDriver(
                                    context,
                                    request: req,
                                    files: {},
                                  );*/
                                  Map<String, dynamic> req = widget.request;
                                  req[ApiKeys.vehicleType] =
                                      selectedVehicleType.value['name'];
                                  req[ApiKeys.vehicleModel] =
                                      selectedVehicleModel.value['name'];
                                  req[ApiKeys.vehicleYear] = vYear.text.trim();
                                  req[ApiKeys.vehicleNumber] = vNumber.text.trim();
                                  req[ApiKeys.vehicleMake] = vMake.text.trim();
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
                                          userType = UserTypeData.Driver;
                                          pushAndRemoveUntil(
                                              context: context,
                                              screen: const BottomBarScreen());
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  showSnackbar('Please select vehicle model.');
                                }
                              } else {
                                showSnackbar('Please select vehicle type.');
                              }
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
          ),
        );
      }),
    );
  }
}
