import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/functions/common_function.dart';
import 'package:by_your_way/functions/validation_functions.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_drop_down_widget.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:by_your_way/widget/show_snackbar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/round_edged_button.dart';

class UserAddNewShipment extends StatefulWidget {
  const UserAddNewShipment({super.key});

  @override
  State<UserAddNewShipment> createState() => _UserAddNewShipmentState();
}

class _UserAddNewShipmentState extends State<UserAddNewShipment> {
  final formKey = GlobalKey<FormState>();
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  ValueNotifier<String> selectedCountryCode = ValueNotifier(defaultCountryCode);
  ValueNotifier selectedPackageType = ValueNotifier(null);
  ValueNotifier selectedWeight = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocusKeyBoard(),
      child: Scaffold(
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
                      "Add New Shipment",
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox2,
                Expanded(
                  child: ListView(
                    children: [
                      vSizedBox2,
                      Row(
                        children: [
                          Expanded(
                            child: InputTextFieldWidget(
                              headingText: "Pickup",
                              contentPaddingVertical: 7,
                              headingfontSize: 15,
                              headingColor: MyColors.greenColor,
                              headingfontWeight: FontWeight.w600,
                              controller: pickupController,
                              borderRadius: 15,
                              fillColor: MyColors.whiteColor,
                              keyboardType: TextInputType.text,
                              hintText: "Pickup",
                              validator: (val) =>
                                  ValidationFunction.requiredValidation(val),
                            ),
                          ),
                          hSizedBox,
                          const Column(
                            children: [
                              vSizedBox2,
                              Center(
                                child: Icon(
                                  Icons.location_on_rounded,
                                  color: MyColors.greenColor,
                                  size: 25,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      vSizedBox,
                      Row(
                        children: [
                          Expanded(
                            child: InputTextFieldWidget(
                              headingText: "Drop",
                              contentPaddingVertical: 7,
                              headingfontSize: 15,
                              headingColor: MyColors.redColor,
                              headingfontWeight: FontWeight.w600,
                              controller: dropController,
                              borderRadius: 15,
                              fillColor: MyColors.whiteColor,
                              keyboardType: TextInputType.text,
                              hintText: "Drop",
                              validator: (val) =>
                                  ValidationFunction.requiredValidation(val),
                            ),
                          ),
                          hSizedBox,
                          const Column(
                            children: [
                              vSizedBox2,
                              Center(
                                child: Icon(
                                  Icons.location_on_rounded,
                                  color: MyColors.redColor,
                                  size: 25,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      vSizedBox,
                      ValueListenableBuilder(
                        valueListenable: selectedPackageType,
                        builder: (_, value, __) => CustomDropDownField(
                          validator: (val) =>
                              ValidationFunction.requiredValidation(
                            val.toString(),
                          ),
                          contentVerticalPadding: 9,
                          headingText: "Package type",
                          headingFontSize: 15,
                          headingTextFontWeight: FontWeight.w500,
                          headingTextColor: MyColors.blackColor,
                          hintText: 'Select Package Type',
                          onChanged: (val) {
                            selectedPackageType.value = val;
                          },
                          itemsList: const [
                            {"name": "Package 1"},
                            {"name": "Package 2"},
                            {"name": "Package 3"},
                            {"name": "Package 4"},
                            {"name": "Package 5"},
                          ],
                          borderRadius: 15,
                          selectedValue: value,
                          popUpTextKey: 'name',
                        ),
                      ),
                      vSizedBox,
                      ValueListenableBuilder(
                        valueListenable: selectedWeight,
                        builder: (_, value, __) => CustomDropDownField(
                          validator: (val) =>
                              ValidationFunction.requiredValidation(
                            val.toString(),
                          ),
                          contentVerticalPadding: 9,
                          headingText: "Weight (Ex. 5kg - 6kg)",
                          headingFontSize: 15,
                          headingTextFontWeight: FontWeight.w500,
                          headingTextColor: MyColors.blackColor,
                          hintText: 'Select Weight',
                          onChanged: (val) {
                            selectedWeight.value = val;
                          },
                          itemsList: const [
                            {"name": "Weight 1"},
                            {"name": "Weight 2"},
                            {"name": "Weight 3"},
                            {"name": "Weight 4"},
                            {"name": "Weight 5"},
                          ],
                          borderRadius: 15,
                          selectedValue: value,
                          popUpTextKey: 'name',
                        ),
                      ),
                      vSizedBox2,
                      const MainHeadingText(
                        "Contact Person details",
                        fontWeight: FontWeight.w600,
                        color: MyColors.primaryColor,
                        fontSize: 16,
                      ),
                      vSizedBox,
                      InputTextFieldWidget(
                        headingText: "Name",
                        contentPaddingVertical: 7,
                        headingfontSize: 15,
                        headingColor: MyColors.blackColor,
                        headingfontWeight: FontWeight.w500,
                        controller: nameController,
                        borderRadius: 15,
                        fillColor: MyColors.whiteColor,
                        keyboardType: TextInputType.text,
                        hintText: "Name",
                        validator: (val) =>
                            ValidationFunction.requiredValidation(val),
                      ),
                      vSizedBox,
                      ValueListenableBuilder(
                          valueListenable: selectedCountryCode,
                          builder:(context, value, child) {
                            return InputTextFieldWidget(
                              headingText: "Mobile Number",
                              contentPaddingVertical: 7,
                              headingfontSize: 15,
                              headingColor: MyColors.blackColor,
                              headingfontWeight: FontWeight.w500,
                              controller: numberController,
                              borderRadius: 15,
                              fillColor: MyColors.whiteColor,
                              keyboardType: TextInputType.number,
                              hintText: "Mobile Number",
                              validator: (val) =>
                                  ValidationFunction.requiredValidation(val),
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
                      const SubHeadingText(
                        "Upload Images",
                        color: MyColors.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      vSizedBox05,
                      Row(
                        children: [
                          Container(
                            height: 66,
                            width: 66,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: MyColors.blackColor50)),
                            child: Icon(
                              Icons.add,
                              color: MyColors.blackColor50,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      vSizedBox2,
                      RoundEdgedButton(
                        text: "Add Shipment",
                        fontWeight: FontWeight.w500,
                        borderRadius: 15,
                        onTap: () {
                          unFocusKeyBoard();
                          if (formKey.currentState!.validate()) {
                            if (selectedPackageType.value != null) {
                              if (selectedWeight.value != null) {
                                Map<String, dynamic> req = {};
                                req[ApiKeys.packageType] =
                                    selectedPackageType.value['name'];
                                req[ApiKeys.weight] = selectedWeight.value['name'];
                                req[ApiKeys.pickup] = pickupController.text.trim();
                                req[ApiKeys.drop] = dropController.text.trim();
                                req[ApiKeys.name] = nameController.text.trim();
                                req[ApiKeys.number] = numberController.text.trim();
                                req[ApiKeys.phoneCode] = selectedCountryCode.value;
                                req[ApiKeys.phone_with_code] = '${selectedCountryCode.value}${numberController.text.trim()}';
                              } else {
                                showSnackbar('Please select weight.');
                              }
                            } else {
                              showSnackbar('Please select package type.');
                            }
                          }
                        },
                      ),
                      vSizedBox2,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
