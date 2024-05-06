import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/language_en.dart';
import 'package:by_your_way/constants/language_keys.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/login_screen.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:by_your_way/provider/app_language_provider.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_scaffold.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/my_image_url.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/round_edged_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0.0,
        child: Stack(
          children: [
            CustomCircularImage(
              imageUrl: MyImagesUrl.imageIntroScreen,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              borderRadius: 0,
              fileType: CustomFileType.asset,
              fit: BoxFit.cover,
            ),
             CustomScaffold(
              backgroundColor: MyColors.transparent,
              body: Consumer<AppLanguageProvider>(
                  builder: (context, appLanguageProvider, child) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: globalHorizontalPadding,
                        right: globalHorizontalPadding,
                        top: 400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ParagraphText(
                          translate(LanguageKeys.createAnAccount),
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                        ParagraphText(
                          translate(LanguageKeys.onYourWay),
                          fontWeight: FontWeight.w600,
                          fontSize: 34,
                          color: MyColors.primaryColor,
                        ),
                        vSizedBox3,
                        ParagraphText(
                          translate(LanguageKeys.anyTimeAnyWhere),
                          fontWeight: FontWeight.w300,
                          fontSize: 26,
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<AppLanguageProvider>(
                  builder: (context, appLanguageProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: globalHorizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundEdgedButton(
                          text: translate(LanguageKeys.createAnAccount),
                          fontWeight: FontWeight.w500,
                          borderRadius: 15,
                          onTap: () {
                            push(context: context, screen: const PreSignUpScreen());
                          },
                        ),
                        RoundEdgedButton(
                          text: translate(LanguageKeys.login),
                          isBorder: true,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.blackColor,
                          color: Colors.white,
                          borderColor: MyColors.blackColor,
                          borderRadius: 15,
                          onTap: () {
                            push(context: context, screen: const LoginScreen());
                          },
                        ),

                        vSizedBox2,
                      ],
                    ),
                  );
                }
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              left: 100,
              child:
              Consumer<AppLanguageProvider>(
                builder: (context, appLanguageProvider, child) =>
                    CustomDropdownButton(
                      // validator: (val) => ValidationFunction.requiredValidation(val),
                      onChanged: ((dynamic value)async {
                        // selectedLanguageNotifier = value;
                        // sharedPreference.setString("lang", selectedLanguageNotifier['key']);
                        // appLanguageProvider.notifyListeners();
                        appLanguageProvider.changeAppLanguage(value);
                      }),

                      selectedItem: selectedLanguageNotifier,
                      items: languagesList,
                      hint: translate(LanguageKeys.selectLanguage),
                      itemMapKey: 'value',
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
