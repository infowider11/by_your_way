import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/widget/custom_loader.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../constants/api_keys.dart';
import '../../services/api_urls.dart';
import '../../services/newest_webservices.dart';

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
     setState(() {
      load = true;
    });
    var request = {ApiKeys.userType: userDataNotifier.value!.userType};
    var response = await NewestWebServices.getResponse(
        apiUrl: ApiUrls.terms, request: request, apiMethod: ApiMethod.get);
    result = response.data['description'].toString();
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Terms & Conditions', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body:
      load?
      Center(child: CustomLoader()):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Html(
            data: """$result""",
          ),
        ),
      ),
    );
  }
}
