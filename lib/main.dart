import 'package:by_your_way/provider/admin_settings_provider.dart';
import 'package:by_your_way/provider/bottom_tabbar_provider.dart';
import 'package:flutter/material.dart';
import 'constants/global_keys.dart';
import 'pages/auth_module/splash_screen.dart';
import 'provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
        ChangeNotifierProvider(create: (context) => AdminSettingsProvider(),),
        ChangeNotifierProvider(create: (context) => BottomTabBarProvider(),),
      ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'By Your Way app',
      // theme: ThemeData(
      //   scaffoldBackgroundColor: MyColors.whiteColor,
      //     colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
      //     useMaterial3: true,
      //     dividerColor: MyColors.blackColor.withOpacity(0.15),
      //     fontFamily: 'Font-Regular'),
      debugShowCheckedModeBanner: false,
      navigatorKey: MyGlobalKeys.navigatorKey,
      // home: Stack(
      //   children: [
      //     const SplashScreen(),
      //     Consumer<AppLoadingProvider>(
      //         builder: (context, loadProvider, child){
      //           if(loadProvider.load)
      //       return CustomLoader();
      //           return Container();
      //     }),
      //   ],
      // ),
      home: const SplashScreen(),
    );
  }
}

