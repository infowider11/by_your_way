import 'package:by_your_way/pages/bottom_sheet_view/add_payment_method_bottom_sheet.dart';
import 'package:by_your_way/widget/custom_bottom_sheet.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_text.dart';
import '../../constants/my_image_url.dart';
import '../../widget/custom_appbar.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: CustomAppBar(
        titleText: 'Back',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await customBottomSheet(
            context,
            child: AddPaymentSheet(
              isAddPayment: true,
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: MyColors.primaryColor,
        child: const Icon(
          Icons.add,
          color: MyColors.whiteColor,
          size: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: globalHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vSizedBox05,
              const Align(
                alignment: Alignment.centerLeft,
                child: SubHeadingText(
                  'Payment Method',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              vSizedBox2,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomGestureDetector(
                    onTap: () {},
                    borderRadius: 15,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: MyColors.enabledTextFieldBorderColor)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: MyColors.primaryColor,
                            child: Image.asset(
                              MyImagesUrl.iconCreditCard,
                              height: 25,
                              width: 24,
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const ParagraphText(
                                      'xxxx xxxx xxxx 2131',
                                      fontSize: 15,
                                      color: MyColors.bluishColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    vSizedBox05,
                                    ParagraphText(
                                      'Bank Name',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.blackColor50,
                                    ),
                                    vSizedBox05,
                                  ],
                                ),
                                CustomGestureDetector(
                                  onTap: () {},
                                  borderRadius: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      MyImagesUrl.iconTrash,
                                      width: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
