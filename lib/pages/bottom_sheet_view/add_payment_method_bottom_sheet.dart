import 'package:by_your_way/pages/bottom_sheet_view/add_card_details_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../constants/my_colors.dart';
import '../../../constants/my_image_url.dart';
import '../../../constants/sized_box.dart';
import '../../../functions/navigation_functions.dart';
import '../../../widget/custom_bottom_sheet.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/round_edged_button.dart';

class AddPaymentSheet extends StatelessWidget {
  final bool isAddPayment;

  AddPaymentSheet({Key? key, required this.isAddPayment}) : super(key: key);
  final ValueNotifier<int> isSelectCard = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelectCard,
      builder: (context, value, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAddPayment)
            const SubHeadingText(
              'Add Payment Method',
              color: MyColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )
          else
            const SubHeadingText(
              'Select Payment Method ',
              color: MyColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          vSizedBox2,
          customCard(
              activeCard: value,
              cardIndex: 1,
              onTap: () {
                isSelectCard.value = 1;
              },
              img: MyImagesUrl.iconCreditCard,
              title: isAddPayment ? 'Cash' : "Cash",
              subtitle: 'Bank Name'),
          vSizedBox2,
          customCard(
              imgWidth: 40,
              isBorder: true,
              activeCard: value,
              cardIndex: 2,
              onTap: () {
                isSelectCard.value = 2;
              },
              color: MyColors.whiteColor,
              img: MyImagesUrl.pseImg,
              title: isAddPayment
                  ? 'Add Debit/credit Card'
                  : 'Add Debit/credit Card',
              subtitle: 'Bank Name'),
          vSizedBox2,
          RoundEdgedButton(
            text: "Next",
            verticalMargin: 0,
            borderRadius: 15,
            onTap: () async {
              await customBottomSheet(
                context,
                child: AddCardDetailSheet(
                  isAddPayment: isAddPayment,
                ),
              );
              // ignore: use_build_context_synchronously
              await popPage(context: context);
            },
          ),
        ],
      ),
    );
  }

  Widget customCard({
    required String img,
    required Function() onTap,
    double? imgWidth,
    Color? color,
    required int activeCard,
    required int cardIndex,
    bool isBorder = false,
    required String title,
    String? subtitle,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isAddPayment ? 16 : 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isAddPayment ? 15 : 15),
            border: Border.all(color: MyColors.enabledTextFieldBorderColor)),
        child: isAddPayment
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ParagraphText(
                    title,
                    fontSize: 18,
                    color: MyColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  activeCard == cardIndex
                      ? const Icon(
                          Icons.radio_button_on,
                          color: MyColors.primaryColor,
                          size: 22,
                        )
                      : Icon(
                          Icons.radio_button_off,
                          color: MyColors.blackColor50,
                          size: 22,
                        ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ParagraphText(
                    title,
                    fontSize: 18,
                    color: MyColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  activeCard == cardIndex
                      ? const Icon(
                          Icons.radio_button_on,
                          color: MyColors.primaryColor,
                          size: 22,
                        )
                      : Icon(
                          Icons.radio_button_off,
                          color: MyColors.blackColor50,
                          size: 22,
                        ),
                ],
              ), /*Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color ?? MyColors.primaryColor.withOpacity(0.24),
                      border: Border.all(
                          color: isBorder
                              ? MyColors.enabledTextFieldBorderColor
                              : MyColors.transparent),
                    ),
                    child: Center(
                      child: Image.asset(
                        img,
                        width: imgWidth ?? 23,
                      ),
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
                            ParagraphText(
                              title,
                              fontSize: 15,
                              color: MyColors.bluishColor,
                              fontWeight: FontWeight.w500,
                            ),
                            vSizedBox05,
                            ParagraphText(
                              subtitle!,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColors.blackColor50,
                            ),
                            vSizedBox05,
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: MyColors.blackColor50,
                          size: 22,
                        )
                      ],
                    ),
                  ),
                ],
              ),*/
      ),
    );
  }
}
