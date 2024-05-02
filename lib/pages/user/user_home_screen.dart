import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/validation_functions.dart';
import 'package:by_your_way/provider/bottom_tabbar_provider.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/input_text_field_widget.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/common_function.dart';
import '../../widget/custom_circular_image.dart';


class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UserHomeScreen> {
  final key = GlobalKey<FormState>();
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        isBackIcon: false,
        title: Padding(
          padding: const EdgeInsets.only(left: globalHorizontalPadding),
          child: Row(
            children: [
              Image.asset(
                MyImagesUrl.iconLocation,
                height: 40,
                width: 40,
              ),
              hSizedBox2,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainHeadingText(
                      "Hello John!",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    MainHeadingText(
                      "Los Angeles, USA",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
              const CustomCircularImage(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: globalHorizontalPadding),
              child: Image.asset(
                MyImagesUrl.iconHomeScreenBanner,
                height: 200,
                width: double.infinity,
              ),
            ),
            vSizedBox2,
            Form(
              key: key,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: globalHorizontalPadding),
                padding: const EdgeInsets.symmetric(
                  horizontal: globalHorizontalPadding / 2,
                  vertical: globalHorizontalPadding,
                ),
                decoration: BoxDecoration(
                    //  border: Border.all(color: MyColors.blackColor50, width: 1),
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InputTextFieldWidget(
                            headingText: "From",
                            contentPaddingVertical: 7,
                            headingfontSize: 15,
                            headingColor: MyColors.greenColor,
                            headingfontWeight: FontWeight.w600,
                            controller: fromController,
                            borderRadius: 15,
                            fillColor: MyColors.whiteColor,
                            keyboardType: TextInputType.text,
                            hintText: "From",
                            validator: (val) =>
                                ValidationFunction.requiredValidation(val),
                          ),
                        ),
                        hSizedBox,
                        Expanded(
                            child: InputTextFieldWidget(
                          headingText: "To",
                          contentPaddingVertical: 7,
                          headingfontSize: 15,
                          headingColor: MyColors.redColor,
                          headingfontWeight: FontWeight.w600,
                          controller: toController,
                          borderRadius: 15,
                          fillColor: MyColors.whiteColor,
                          keyboardType: TextInputType.text,
                          hintText: "To",
                          validator: (val) =>
                              ValidationFunction.requiredValidation(val),
                        )),
                      ],
                    ),
                    vSizedBox,
                    RoundEdgedButton(
                      text: '--- Search ---',
                      width: 150,
                      height: 40,
                      onTap: () {
                        if (key.currentState!.validate()) {
                          Provider.of<BottomTabBarProvider>(context,
                                  listen: false)
                              .changeIndex(index: 2);
                        }
                      },
                      borderRadius: 15,
                      verticalMargin: 0,
                    ),
                  ],
                ),
              ),
            ),
            vSizedBox2,
            /* RoundEdgedButton(
              text: '----- Add Shipment -----',
              width: 230,
              height: 40,
              onTap: () {
                Provider.of<BottomTabBarProvider>(context, listen: false)
                    .changeIndex(index: 2);
              },
              borderRadius: 15,
              verticalMargin: 15,
            ),*/
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: globalHorizontalPadding, vertical: 30),
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainHeadingText(
                    "Parcel Your package",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  vSizedBox02,
                  const MainHeadingText(
                    "On Your Way",
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: MyColors.primaryColor,
                  ),
                  vSizedBox2,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return commonUserCard(
                        requestType: RequestType.running,
                        index: index,
                      );
                    },
                    itemCount: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
