import 'package:by_your_way/constants/global_keys.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/widget/common_alert_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/my_colors.dart';
import '../../../constants/sized_box.dart';
import '../../../functions/validation_functions.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/input_text_field_widget.dart';
import '../../../widget/round_edged_button.dart';

class AddCardDetailSheet extends StatelessWidget {
  final bool isAddPayment;

  AddCardDetailSheet({Key? key, required this.isAddPayment}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController holderName = TextEditingController();
  final TextEditingController cvvNum = TextEditingController();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController cardNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubHeadingText(
            'Enter Card Details',
            color: MyColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          vSizedBox2,
          InputTextFieldWidget(
            controller: cardNum,
            hintText: "Card Number",
            borderRadius: 15,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (val) => ValidationFunction.requiredValidation(val),
          ),
          vSizedBox2,
          Row(
            children: [
              Expanded(
                child: InputTextFieldWidget(
                  controller: expiryDate,
                  hintText: "Expiry Date",
                  borderRadius: 15,
                  validator: (val) =>
                      ValidationFunction.requiredValidation(val),
                ),
              ),
              hSizedBox2,
              Expanded(
                child: InputTextFieldWidget(
                  controller: cvvNum,
                  hintText: "CVV",
                  keyboardType: TextInputType.number,
                  borderRadius: 15,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (val) =>
                      ValidationFunction.requiredValidation(val),
                ),
              ),
            ],
          ),
          vSizedBox2,
          InputTextFieldWidget(
            controller: holderName,
            hintText: "Card Holder Name",
            borderRadius: 15,
            validator: (val) => ValidationFunction.requiredValidation(val),
          ),
          vSizedBox2,
          RoundEdgedButton(
            text: isAddPayment ? "Done" : "Pay Now",
            verticalMargin: 0,
            borderRadius: 15,
            onTap: () async {
              if (formKey.currentState!.validate()) {
                if (isAddPayment) {
                  popPage(context: context);
                } else {
                  await showSuccessPopup(
                    context: MyGlobalKeys.navigatorKey.currentContext!,
                    heading: "Congratulations!!",
                    subtitle:
                        "Payment has been Done.Your shipment is awarded, now you can contact with the driver and track your shipment.",
                    bottomWidget: Center(
                      child: RoundEdgedButton(
                        text: "OK",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 50,
                        width: 90,
                        borderRadius: 10,
                        onTap: () {
                          popPage(
                            context: MyGlobalKeys.navigatorKey.currentContext!,
                          );
                        },
                      ),
                    ),
                  );
                  popPage(
                    context: MyGlobalKeys.navigatorKey.currentContext!,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
