import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/api_keys.dart';
import '../../constants/global_data.dart';
import '../../constants/my_image_url.dart';
import '../../constants/sized_box.dart';
import '../../functions/print_function.dart';
import '../../provider/auth_provider.dart';
import '../../services/api_urls.dart';
import '../../services/custom_navigation_services.dart';
import '../../services/newest_webservices.dart';
import '../../widget/custom_text.dart';
import '../../widget/round_edged_button.dart';
import '../common/bottom_tab.dart';
// import 'package:simplix_app/constants/api_keys.dart';
// import 'package:simplix_app/constants/global_data.dart';
// import 'package:simplix_app/constants/sized_box.dart';
// import 'package:simplix_app/functions/print_function.dart';
// import 'package:simplix_app/pages/common/bottom_tab.dart';
// import 'package:simplix_app/provider/auth_provider.dart';
// import 'package:simplix_app/services/api_urls.dart';
// import 'package:simplix_app/services/custom_navigation_services.dart';
// import 'package:simplix_app/services/newest_webservices.dart';
// import 'package:simplix_app/widget/custom_text.dart';
// import 'package:simplix_app/widget/round_edged_button.dart';

class PendingVerificationScreen extends StatefulWidget {
  const PendingVerificationScreen({super.key});

  @override
  State<PendingVerificationScreen> createState() => _PendingVerificationScreenState();
}

class _PendingVerificationScreenState extends State<PendingVerificationScreen> {
  
  
  
  Timer? timer;
  
  
  
  initializeTimer()async{
  try{
    var response = await NewestWebServices.getResponse(apiUrl: ApiUrls.getUserDetails, request: {}, apiMethod: ApiMethod.get);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(response.status==1){
      if(response.data[ApiKeys.user_info][ApiKeys.user_status]==1){
        authProvider.updateUserDataInSharedPreference(userData: response.data[ApiKeys.user_info]);
        CustomNavigation.pushAndRemoveUntil(context: context, screen: BottomBarScreen());
      }else{
        await Future.delayed(Duration(seconds: 10));
        initializeTimer();
      }
    }else{
      myCustomPrintStatement('__________________________________ISSSUEEEE___________________');
    }
  }catch(e){
    print('Error in catch block dgds $e');
  }
  }
  @override
  void initState() {
    // TODO: implement initState
    initializeTimer();
    super.initState();
  }
  
  
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   titleText: '',
      // ),
      body: Padding(
        padding: const EdgeInsets.all(globalHorizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              MyImagesUrl.iconChecked,
              height: 92,
              width: 92,
            ),
            // Icon(Icons.timer, size: 120, color: Colors.grey.withOpacity(0.6),),
            vSizedBox2,
            SubHeadingText('Your Registration has been completed Successfully. Admin will check your documents and back to you 3-4 business days', textAlign: TextAlign.center,),
            vSizedBox2,
            RoundEdgedButton(text: 'Ok', horizontalMargin: 30, onTap: (){
              initializeTimer();
            },),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return RoundEdgedButton(
                  text: 'Logout',
                  horizontalMargin: 30,
                  onTap: (){
                  authProvider.logoutPopup(context);
                },
                  isSolid: false,
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
