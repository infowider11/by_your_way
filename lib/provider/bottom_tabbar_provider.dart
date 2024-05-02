import 'package:by_your_way/pages/auth_module/my_profile_screen.dart';
import 'package:by_your_way/pages/driver/driver_history_screen.dart';
import 'package:by_your_way/pages/driver/driver_home_screen.dart';
import 'package:by_your_way/pages/driver/driver_wallet_screen.dart';
import 'package:by_your_way/pages/user/user_history_screen.dart';
import 'package:flutter/material.dart';
import '../pages/common/chat_list_screen.dart';
import '../pages/user/user_home_screen.dart';
import '../pages/user/user_add_new_shipment.dart';

class BottomTabBarProvider extends ChangeNotifier {
  int currentIndex = 0;

  var tabsUser = [
    const UserHomeScreen(),
    const UserHistoryScreen(),
    const UserAddNewShipment(),
    const ChatList(),
    const MyProfileScreen(),
  ];

  var tabsDriver = [
    const DriverHomeScreen(),
    const DriverHistoryScreen(),
    const DriverWalletScreen(),
    const ChatList(),
    const MyProfileScreen(),
  ];

  void changeIndex({required int index}) {
    currentIndex = index;
    notifyListeners();
  }
}
