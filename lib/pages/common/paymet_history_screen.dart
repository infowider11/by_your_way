import 'package:flutter/material.dart';

import '../../constants/global_data.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_image_url.dart';
import '../../constants/sized_box.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_text.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   CustomAppBar(
        bottomCurve: true,
        isBackIcon: true,
        titleText:'Payment History',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                padding: const EdgeInsets.symmetric(horizontal: globalHorizontalPadding),
                itemBuilder: (context, index) =>
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.only(left:20,bottom: 12,top: 12,right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color:index.isEven?MyColors.greenColor.withOpacity(0.1):MyColors.redColor.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(index.isEven?MyImagesUrl.creditIcon:MyImagesUrl.debitIcon,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          hSizedBox2,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SubHeadingText('\$ 250 ',
                                  fontSize: 16,
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                 SubHeadingText('${index.isEven?"Credited":"debited"}Credited in Acc no. **** **** 4521',
                                  fontSize: 14,
                                  color:MyColors.secondaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                vSizedBox02,
                                SubHeadingText(
                                  'Jan 23rd, 2024, 05:06 PM ',
                                  fontSize: 12,
                                  color: MyColors.blackColor50,
                                  fontWeight: FontWeight.w400,
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    )
            ),
          )
        ],
      ),

    );
  }
}
