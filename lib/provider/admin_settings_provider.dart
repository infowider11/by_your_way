
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:by_your_way/constants/global_keys.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/print_function.dart';
import 'package:by_your_way/functions/showCustomDialog.dart';
import 'package:by_your_way/services/api_urls.dart';
import 'package:by_your_way/services/newest_webservices.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:by_your_way/widget/round_edged_button.dart';
import 'package:by_your_way/widget/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modal/default_app_settings_modal.dart';
import '../services/google_map_services.dart';

class AdminSettingsProvider extends ChangeNotifier {


  /// run it only once to initialize settings
  // await AdminSettingsProvider.updateDefaultAppSettingsToFirebase();
  /// add this in main function
  // var adminSettingsProvider= Provider.of<AdminSettingsProvider>(context, listen: false);
  // await adminSettingsProvider.getDefaultAppSettings();

  bool isFirebase = true;

  DefaultAppSettingModal defaultAppSettingModal = DefaultAppSettingModal(
    appVersionIos: 1,
    appVersionAndroid: 1,
    hardUpdateVersionIos: 1,
    hardUpdateVersionAndroid: 1,
    updatePopup: true,
    googleApiKey: GoogleMapServices.googleMapApiKey,
    updateUrlAndroid: '',
    updateUrlIos: '',
      updateMessage: 'New Version is available, Please download latest version from store',
      autoCancelPaymentNotDoneInMin:5,
  autoCancelProviderNotAcceptInMin:15,
  autoCancelOnProviderNotArrivedInMin:120,
  autoCancelOnUserNotAccept_ProviderArrivingInMin:45,
  );
  static final adminSettingCollection =
      FirebaseFirestore.instance.collection('adminSettings');
  static final defaultAppSettingsDocument =
      adminSettingCollection.doc('defaultAppSettings');

  static const appVersionAndroid = 1;
  static const appVersionIos = 1;

  getDefaultAppSettings() async {
    bool showPopup = false;
    Map? data;
   if(isFirebase){
     var snapshot = await defaultAppSettingsDocument.get();

     myCustomPrintStatement('the app settings snapshot is $snapshot');
     if (snapshot.exists) {
       data = snapshot.data() as Map;

     }
   }else{
     var response = await NewestWebServices.getResponse(apiUrl: ApiUrls.appSettings, request: {}, apiMethod: ApiMethod.get, customHeaders: {
       'x-api-key': 'phgrew6SDGDF5ra1214er14wer64346rf'
     });
     if(response.status==1){
       data = response.data;
     }
   }

    try {
      defaultAppSettingModal =
          DefaultAppSettingModal.fromJson(data!);


    print('the response for app settings is ${data}');
    if (defaultAppSettingModal.appVersionAndroid > appVersionAndroid &&
    Platform.isAndroid) {
    print('the snapshot true sd');
    showPopup = true;
    }
    if (defaultAppSettingModal.appVersionIos > appVersionIos &&
    Platform.isIOS) {
    print('the snapshot true sdsdf');
    showPopup = true;
    }
    } catch (e) {
    myCustomPrintStatement('Error in catch block in admin settings $e');
    }

    if (showPopup) {
      await showUpdateDialog();
    }
  }

  showUpdateDialog() async {
    return showCustomDialog(
      height: 230,
        child: PopScope(
      // onPopInvoked: (value)async{
      //
      // },
      canPop: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SubHeadingText(
              defaultAppSettingModal.updateMessage),
          vSizedBox2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if ((defaultAppSettingModal.hardUpdateVersionAndroid <=
                          appVersionAndroid &&
                      Platform.isAndroid) ||
                  (defaultAppSettingModal.hardUpdateVersionIos <=
                          appVersionIos &&
                      Platform.isIOS))
                TextButton(
                    onPressed: () {
                      Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
                    }, child: const SubHeadingText('Remind me later'))
              else
                vSizedBox,
              RoundEdgedButton(
                text: 'Update',
                width: 100,
                height: 40,
                onTap: () {
                  try{
                    if(Platform.isIOS){
                      launchUrl(Uri.parse(defaultAppSettingModal.updateUrlIos));
                    }else{
                      launchUrl(Uri.parse(defaultAppSettingModal.updateUrlAndroid));
                    }
                  }catch(e){
                    showSnackbar('Some Error, please update from store');
                  }
                },
              ),
            ],
          )
        ],
      ),
    ));
  }

  static updateDefaultAppSettingsToFirebase() async {
    var request = {
      'appVersionIos': 1,
      'appVersionAndroid': 1,
      'hardUpdateVersionAndroid': 1,
      'hardUpdateVersionIos': 1,
      'updatePopup': true,
      'updateUrlAndroid': 'https://www.instagram.com/manish.talreja.50',
      'updateUrlIos': 'https://www.instagram.com/manish.talreja.50',
      'googleApiKey': GoogleMapServices.googleMapApiKey,
      'updateMessage': 'New Version is available, Please download latest version from store',
      // 'googleApiKey': 'AIzaSyBgwFg2GYp7N3LPg1va6Wnr7upfoeku8f0',
    };
    var snapshot = await defaultAppSettingsDocument.get();
    if (snapshot.exists) {
      defaultAppSettingsDocument.update(request);
    } else {
      defaultAppSettingsDocument.set(request);
    }
  }


}
