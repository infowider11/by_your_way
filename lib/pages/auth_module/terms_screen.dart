import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/widget/custom_loader.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool load = false;
  String result = "";

  getData() async {
    /* setState(() {
      load = true;
    });
    var request = {ApiKeys.userType: userDataNotifier.value!.userType};
    var response = await NewestWebServices.getResponse(
        apiUrl: ApiUrls.terms, request: request, apiMethod: ApiMethod.get);
    result = response.data['description'].toString();
    setState(() {
      load = false;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: CustomAppBar(
        titleText: 'Back',
      ),
      body: load
          ? const Center(child: CustomLoader())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: globalHorizontalPadding),
                child: Column(
                  children: [
                    vSizedBox05,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: SubHeadingText(
                        'Terms & Conditions',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    vSizedBox3,
                    for (int i = 0; i < 6; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainHeadingText(
                              "${i + 1} Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                             vSizedBox,
                             const ParagraphText(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: MyColors.blackColor,
                            )
                          ],
                        ),
                      )

                    /*Container(
                      child: Html(
                        data: result??"",
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
    );
  }
}
