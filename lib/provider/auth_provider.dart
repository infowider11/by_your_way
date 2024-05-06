import 'dart:async';
import 'package:by_your_way/firebase_options.dart';
import 'package:by_your_way/pages/auth_module/change_password_screen.dart';
import 'package:by_your_way/pages/auth_module/contact_us_screen.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/pages/auth_module/privacy_policy_screen.dart';
import 'package:by_your_way/pages/auth_module/terms_screen.dart';
import 'package:by_your_way/pages/driver/driver_profile_screen.dart';
import 'package:by_your_way/pages/user/user_profile_screen.dart';
import 'package:by_your_way/pages/common/payment_method_screen.dart';
import 'package:by_your_way/provider/app_language_provider.dart';
import 'package:by_your_way/widget/custom_bottom_sheet.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:by_your_way/constants/api_keys.dart';
import 'package:by_your_way/constants/global_keys.dart';
import 'package:by_your_way/modal/response_modal.dart';
import 'package:by_your_way/services/newest_webservices.dart';
import '../constants/global_data.dart';
import '../constants/my_colors.dart';
import '../constants/my_image_url.dart';
import '../constants/shared_preference_keys.dart';
import '../constants/sized_box.dart';
import '../constants/types/user_type.dart';
import '../functions/navigation_functions.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../functions/print_function.dart';
import '../modal/user_modal.dart';
import '../pages/auth_module/intro_screen.dart';
import '../pages/auth_module/pending_verification_screen.dart';
import '../pages/common/bottom_tab.dart';
import '../services/api_urls.dart';
import '../services/custom_navigation_services.dart';
import '../services/firebase_push_notifications.dart';
import '../services/webservices.dart';
import '../widget/common_alert_dailog.dart';
import '../widget/round_edged_button.dart';
import '../widget/show_snackbar.dart';
import 'admin_settings_provider.dart';
import 'bottom_tabbar_provider.dart';
import 'location_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool load = false;
  // ValueNotifier<int> selectedLanguage = ValueNotifier(0);

  void showLoading() {
    load = true;
    notifyListeners();
  }

  void hideLoading() {
    load = false;
    notifyListeners();
  }

  void userNavigationAfterLogin(BuildContext context) {
    FirebasePushNotifications.updateDeviceToken();
       if(userDataNotifier.value?.firstName==null || userDataNotifier.value?.userType==null){
      CustomNavigation.pushAndRemoveUntil(context: context, screen: PreSignUpScreen());
    }else if(userDataNotifier.value?.userType==UserType.driver && userDataNotifier.value?.verification_status==0){
      CustomNavigation.pushAndRemoveUntil(context: context, screen: PendingVerificationScreen());
    }
    else{
      pushAndRemoveUntil(context: context, screen: const BottomBarScreen());
    }
  }

  Future<void> splashAuthentication(context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebasePushNotifications.initializeFirebaseNotifications();
    //var adminSettingsProvider =
    //    Provider.of<AdminSettingsProvider>(context, listen: false);
    //await AdminSettingsProvider.updateDefaultAppSettingsToFirebase();
    //await adminSettingsProvider.getDefaultAppSettings();

    sharedPreference = await SharedPreferences.getInstance();
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context, listen: false);
    appLanguageProvider.initializeLanguage();
    await getCategoriesAndSubCategories();
    UserModal? result = await isLoggedIn();

    if (result != null) {
      // String? lang =
      //     sharedPreference.getString(SharedPreferenceKeys.selectedLanguage);
      // if (lang != null) {
      //   if (lang == 'ar') {
      //     selectedLanguageNotifier.value = languagesList[1];
      //   } else {
      //     selectedLanguageNotifier.value = languagesList[0];
      //   }
      // } else {
      //   selectedLanguageNotifier.value = languagesList[0];
      // }


      userNavigationAfterLogin(context);
    } else {
      pushAndRemoveUntil(context: context, screen: const IntroScreen());
    }
  }

  Future<UserModal?> isLoggedIn() async {
    String? userDataString =
        sharedPreference.getString(SharedPreferenceKeys.userData);
    if (userDataString != null) {
      Map<String, dynamic> userData = convert.jsonDecode(userDataString);
      userToken = sharedPreference.getString(SharedPreferenceKeys.userToken);
      userDataNotifier.value = UserModal.fromJson(userData);
      await updateUserData();
      return userDataNotifier.value;
    } else {
      return null;
    }
  }

  Future<void> updateUserDataInSharedPreference(
      {required Map userData, String? token}) async {
    String userDataString = convert.jsonEncode(userData);
    userDataNotifier.value = UserModal.fromJson(userData);
    await sharedPreference.setString(
        SharedPreferenceKeys.userData, userDataString);
    if (token != null) {
      userToken = token;
      await sharedPreference.setString(SharedPreferenceKeys.userToken, token);
    }
  }

  Future<void> updateUserData() async {
    var jsonResponse = await NewestWebServices.getResponse(
        apiMethod: ApiMethod.get,
        apiUrl: ApiUrls.getUserDetails,
        request: {},
        showSuccessMessage: false);
    if (jsonResponse.status == 1) {
      updateUserDataInSharedPreference(
        userData: jsonResponse.data['user_info'],
      );
    }
  }

  Future<void> login(BuildContext context,
      {required String email, required String password}) async {
    showLoading();
    var request = {'email': email, 'password': password};
    var jsonResponse = await NewestWebServices.getResponse(
        apiUrl: ApiUrls.login, request: request);
    if (jsonResponse.status == 1) {
      await updateUserDataInSharedPreference(
          userData: jsonResponse.data[ApiKeys.user_info],
          token: jsonResponse.data['token']);
      // ignore: use_build_context_synchronously
      userNavigationAfterLogin(context);
    }
    hideLoading();
  }

  Future<void> signup(BuildContext context,
      {required Map<String, dynamic> request}) async {
    showLoading();
    var jsonResponse = await NewestWebServices.getResponse(
        apiUrl: ApiUrls.signup, request: request);
    if (jsonResponse.status == 1) {
      await updateUserDataInSharedPreference(
          userData: jsonResponse.data[ApiKeys.user_info],
          token: jsonResponse.data['token']);

      // showSuccesfulRegistration();
      // ignore: use_build_context_synchronously
      userNavigationAfterLogin(context);
    }
    hideLoading();
  }

  Future showSuccesfulRegistration()async{
    return  showSuccessPopup(
      context: MyGlobalKeys.navigatorKey.currentContext!,
      heading: "Congratulations!!",
      subtitle:
      "Your Registration has been completed Successfully. Admin will check your documents and back to you 3-4 business days",
      bottomWidget: Center(
        child: RoundEdgedButton(
          text: "OK",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 50,
          width: 90,
          borderRadius: 10,
          onTap: () {
            // userType = UserTypeData.Driver;
            // pushAndRemoveUntil(
            //     context: MyGlobalKeys.navigatorKey.currentContext!,
            //     screen: const BottomBarScreen());
          },
        ),
      ),
    );
  }



  Future<bool> checkUniqueness(BuildContext context,
      {required String email, required String phoneNumberWithCode}) async {
    showLoading();
    var request = {ApiKeys.email: email, ApiKeys.phone_with_code: phoneNumberWithCode};
    var jsonResponse = await NewestWebServices.getResponse(
        apiUrl: ApiUrls.checkPhoneEmailUniqueness, request: request);
    if (jsonResponse.status == 1) {
      hideLoading();
      return true;
    }
    hideLoading();
    return false;

  }




  getCategoriesAndSubCategories()async{
    var response =await NewestWebServices.getResponse(apiUrl: ApiUrls.getVehicleTypeList, request: {}, apiMethod: ApiMethod.get);
    if(response.status==1){
      globalCategoriesList = response.data[ApiKeys.data];
    }

    var subresponse =await NewestWebServices.getResponse(apiUrl: ApiUrls.getVehicleModelList, request: {}, apiMethod: ApiMethod.get);
    if(subresponse.status==1){
      globalSubCategoriesList = subresponse.data[ApiKeys.data];
    }
    notifyListeners();
    // globalCategoriesList =
  }


  Future<void> forgetPassword(BuildContext context,
      {required String email}) async {
    showLoading();
    var request = {
      'email': email,
    };
    var jsonResponse = await NewestWebServices.getResponse(
        apiUrl: ApiUrls.forgetPassword,
        request: request,
        apiMethod: ApiMethod.post,
        load: true);
    if (jsonResponse.status == 1) {
      // ignore: use_build_context_synchronously
      popPage(context: context);
      showSnackbar(jsonResponse.message);
    }
    hideLoading();
  }

  Timer? intervalTimer;


  intervalProviderToCheckBlockStatus()async{


    var locationProvider = Provider.of<MyLocationProvider>(MyGlobalKeys.navigatorKey.currentContext!, listen: false);

    intervalTimer?.cancel();
    intervalTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      try{
        Map<String, dynamic> request = {

        };
        if(locationProvider.latitude!=0){
          request['latitude'] = locationProvider.latitude;
          request['longitude'] = locationProvider.longitude;
          request[ApiKeys.userType] = userDataNotifier.value?.userType;
        }
        NewestWebServices.getResponse(apiUrl: ApiUrls.interval, request: request, apiMethod: ApiMethod.put).then((value){
          if(value.status==1){
            // var bookingProvider =
            // Provider.of<BookingProvider>(MyGlobalKeys.navigatorKey.currentContext!,
            //     listen: false);
            Map? bookingMap =value.data['latest_bookings'];
            if(bookingMap!=null){
            //   myCustomPrintStatement('The user has a new booking ... ${bookingProvider.hasNoBooking.value}  .... ${bookingProvider.isBookingDialogOpen}: ${bookingMap}');
            //   bookingProvider.hasNoBooking.value = false;
            //   if(bookingProvider.isBookingDialogOpen == false){
            //     // bookingProvider.isBookingDialogOpen = true;
            //     print('opening booking dialog');
            //     BookingModal bookingModal = BookingModal.fromJson(bookingMap);
            //     bookingProvider.showBookingPopup(bookingModal);
            //   }
            }else{
              myCustomPrintStatement('The user has no booking');
              // bookingProvider.hasNoBooking.value = true;
              // bookingProvider.isBookingDialogOpen = false;
            }


          }else
          if(value.data['status']==2){
            showSnackbar(value.message);
            intervalTimer?.cancel();
            logout(MyGlobalKeys.navigatorKey.currentContext!);
          }
        });

      }catch(e){

      }
    });

  }
  // Future<void> intervalProviderToCheckBlockStatus() async {
  //   intervalTimer?.cancel();
  //   intervalTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     NewestWebServices.getResponse(
  //             apiUrl: ApiUrls.interval, request: {}, apiMethod: ApiMethod.put)
  //         .then((value) {
  //       if (value.data['status'] != 1) {
  //         showSnackbar(value.message);
  //         intervalTimer?.cancel();
  //         logout(MyGlobalKeys.navigatorKey.currentContext!);
  //       }
  //     });
  //   });
  // }

  Future<void> clickOnProfileMenu(
      {required int index, required BuildContext context}) async {
    if (userDataNotifier.value!.userType == UserType.company) {
      if (index == 0) {
        if (userDataNotifier.value!.userType == UserType.user) {
          push(context: context, screen: const UserProfileScreen());
        } else if (userDataNotifier.value!.userType == UserType.driver) {
          push(context: context, screen: const DriverProfileScreen());
        } else {
          push(context: context, screen: const UserProfileScreen());
        }
      } else if (index == 1) {
        push(context: context, screen: const ChangePassScreen());
      } else if (index == 2) {
        await languageBottomsheet(context: context);
      } else if (index == 3) {
        push(context: context, screen: const ContactUsScreen());
      } else if (index == 4) {
        push(context: context, screen: const TermsAndConditionsPage());
      } else if (index == 5) {
        push(context: context, screen: const PrivacyNewPage());
      } else if (index == 6) {
        logoutPopup(context);
      }
    } else {
      if (index == 0) {
        if (userDataNotifier.value!.userType == UserType.user) {
          push(context: context, screen: const UserProfileScreen());
        } else if (userDataNotifier.value!.userType ==UserType.driver) {
          push(context: context, screen: const DriverProfileScreen());
        } else {
          push(context: context, screen: const UserProfileScreen());
        }
      } else if (index == 1) {
        push(context: context, screen: const ChangePassScreen());
      } else if (index == 2) {
        push(context: context, screen: const PaymentMethodScreen());
      } else if (index == 3) {
        await languageBottomsheet(context: context);
      } else if (index == 4) {
        push(context: context, screen: const ContactUsScreen());
      } else if (index == 5) {
        push(context: context, screen: const TermsAndConditionsPage());
      } else if (index == 6) {
        push(context: context, screen: const PrivacyNewPage());
      } else if (index == 7) {
        logoutPopup(context);
      }
    }
  }

  Future<bool> editProfileFunction({
    required BuildContext context,
    required Map<String, dynamic> request,
    Map<String, dynamic>? files,
  }) async {
    showLoading();
    ResponseModal response;

    if (files == null) {
      response = await NewestWebServices.getResponse(
          apiUrl: ApiUrls.editProfile,
          request: request,
          apiMethod: ApiMethod.put,
          showSuccessMessage: true);
    } else {
      print('the files are ${files}');
      for(int i = 0;i<files.keys.length;i++){
        // print('the files is ${files.keys.toList()[i]}');

        request[files.keys.toList()[i]] = await NewestWebServices.uploadImageAndGetUrl(files[files.keys.toList()[i]].path);
      }
      // dead;
      response = await NewestWebServices.getResponse(
          apiUrl: ApiUrls.editProfile,
          request: request,
          apiMethod: ApiMethod.put,
          showSuccessMessage: true);
      // response = await NewestWebServices.postDataWithImageFunction(
      //     apiUrl: ApiUrls.editProfile,
      //     body: request,
      //     files: files,
      //     apiMethod: ApiMethod.post,
      //     showSuccessMessage: true);
    }

    if (response.status == 1) {
      FirebasePushNotifications.updateDeviceToken();
      updateUserDataInSharedPreference(
          userData: response.data[ApiKeys.user_info]);
      // ignore: use_build_context_synchronously
      popPage(context: context);
      hideLoading();
      return true;
    }

    hideLoading();
    return false;
  }

  Future<void> changePassword(
    BuildContext context, {
    required Map<String, dynamic> request,
  }) async {
    showLoading();
    var response = await NewestWebServices.getResponse(
      apiUrl: ApiUrls.changePassword,
      request: request,
      apiMethod: ApiMethod.patch,
      showSuccessMessage: true,
    );
    if (response.status == 1) {
      // ignore: use_build_context_synchronously
      popPage(context: context);
    }
    hideLoading();
  }

  Future<void> languageBottomsheet({required BuildContext context}) async {
    await customBottomSheet(
      context,
      child: Consumer<AppLanguageProvider>(
          builder: (context, appLanguageProvider, child) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  vSizedBox,
                  for(int i = 0;i<languagesList.length;i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomGestureDetector(
                        onTap: () {
                          appLanguageProvider.changeAppLanguage(languagesList[i]);
                        },
                        borderRadius: 15,
                        child: commonContainer(
                            selected: selectedLanguageNotifier==languagesList[i], value: languagesList[i]['value'])),
                  ),
                  // vSizedBox,
                  // CustomGestureDetector(
                  //   onTap: () {
                  //     selectedLanguage.value = 1;
                  //   },
                  //   borderRadius: 15,
                  //   child: commonContainer(
                  //       selected: selectedValue == 1, value: "Arabic"),
                  // ),
                  // vSizedBox,
                  RoundEdgedButton(
                    text: "Update",
                    onTap: () {
                      popPage(context: context);
                    },
                    verticalMargin: 10,
                    fontSize: 18,
                    borderRadius: 15,
                    fontWeight: FontWeight.w700,
                    color: MyColors.primaryColor,
                  ),
                ],
              ),
            );
          }),
      isHorizontalPadding: false,
    );
  }

  Widget commonContainer({required bool selected, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: globalHorizontalPadding, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: MyColors.blackColor50,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainHeadingText(
            value,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          if (selected)
            const Icon(
              Icons.check_circle_sharp,
              color: MyColors.primaryColor,
            )
          else
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: MyColors.blackColor50)),
            )
        ],
      ),
    );
  }

  Future<void> contactUs(
    BuildContext context, {
    required Map<String, dynamic> request,
  }) async {
    showLoading();
    var jsonResponse = await NewestWebServices.getResponse(
      apiUrl: ApiUrls.contactUs,
      request: request,
      showSuccessMessage: true,
    );
    if (jsonResponse.status == 1) {
      // ignore: use_build_context_synchronously
      popPage(context: context);
    }
    hideLoading();
  }

  Future<void> logoutPopup(context) async {
    await showCommonAlertDailog(
      context,
      imageUrl: MyImagesUrl.logoutIcon,
      headingText: 'Are you sure?',
      message: 'You want to Logout',
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundEdgedButton(
              text: "Cancel",
              color: MyColors.primaryColor,
              isSolid: false,
              width: 100,
              height: 40,
              onTap: () {
                popPage(context: context);
              },
            ),
            hSizedBox2,
            RoundEdgedButton(
                text: 'Logout',
                width: 100,
                height: 40,
                onTap: () async {
                  logout(context);
                }),
            hSizedBox,
          ],
        ),
      ],
    );
  }

  Future<void> logout(BuildContext context) async {
    sharedPreference.clear();
    intervalTimer?.cancel();
    Provider.of<BottomTabBarProvider>(context, listen: false)
        .changeIndex(index: 0);
    pushAndRemoveUntil(context: context, screen: const IntroScreen());
  }
}
