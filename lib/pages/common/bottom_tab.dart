// ignore_for_file: deprecated_member_use
import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/pages/auth_module/pre_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../constants/my_colors.dart';
import '../../../constants/my_image_url.dart';
import '../../../constants/sized_box.dart';
import '../../../widget/common_alert_dailog.dart';
import '../../../widget/round_edged_button.dart';
import '../../constants/types/user_type.dart';
import '../../provider/bottom_tabbar_provider.dart';
import 'dart:math' as math;

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: WillPopScope(
        onWillPop: () async {
          BottomTabBarProvider bottomTabBarProvider =
              Provider.of<BottomTabBarProvider>(context, listen: false);
          if (bottomTabBarProvider.currentIndex == 0) {
            bool? result = await showCommonAlertDailog(context,
                headingText: "Are you sure?",
                message: "Do you want to exit the app",
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundEdgedButton(
                        text: "No",
                        color: MyColors.primaryColor,
                        isSolid: false,
                        width: 100,
                        height: 40,
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                      ),
                      hSizedBox2,
                      RoundEdgedButton(
                        text: "Yes",
                        width: 100,
                        height: 40,
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                      ),
                      hSizedBox,
                    ],
                  ),
                ],
                imageUrl: MyImagesUrl.logoutIcon);
            if (result == true) {
              SystemNavigator.pop();
            }
          } else {
            bottomTabBarProvider.changeIndex(index: 0);
            return false;
          }
          return false;
        },
        child: Consumer<BottomTabBarProvider>(
            builder: (context, bottomBarProvider, child) {
          return Container(
            margin: EdgeInsets.zero,
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Image.asset(
                  MyImagesUrl.imageHomeScreen,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Scaffold(
                  key: _scaffoldKey,
                  resizeToAvoidBottomInset: false,
                  backgroundColor: MyColors.transparent,
                  body: userDataNotifier.value!.userType != UserType.driver
                      ? bottomBarProvider
                          .tabsUser[bottomBarProvider.currentIndex]
                      : bottomBarProvider
                          .tabsDriver[bottomBarProvider.currentIndex],
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<BottomTabBarProvider>(context,
                                listen: false)
                            .changeIndex(index: 2);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: MyColors.primaryColor)
                            ]),
                        child: userDataNotifier.value!.userType != UserType.driver
                            ? const Icon(
                                Icons.add,
                                size: 30,
                                color: MyColors.whiteColor,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  MyImagesUrl.iconWallet,
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: Consumer<BottomTabBarProvider>(
                      builder: (context, bottomBarProvider, child) {
                    return Material(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.transparent),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              MyImagesUrl.imageTest,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              height: 73,
                              color: MyColors.primaryColor.withOpacity(0.1),
                            ),
                            BottomAppBar(
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                color: Colors.transparent,
                                clipBehavior: Clip.hardEdge,
                                shape: const CustomShape(),
                                notchMargin: 0,
                                child: BottomNavigationBar(
                                  currentIndex: bottomBarProvider.currentIndex,
                                  onTap: (int index) {
                                    bottomBarProvider.changeIndex(index: index);
                                  },
                                  backgroundColor: Colors.transparent,
                                  type: BottomNavigationBarType.fixed,
                                  showSelectedLabels: true,
                                  showUnselectedLabels: true,
                                  elevation: 0,
                                  selectedFontSize: 10,
                                  unselectedFontSize: 10,
                                  selectedItemColor: MyColors.primaryColor,
                                  unselectedItemColor: MyColors.blackColor,
                                  items: const <BottomNavigationBarItem>[
                                    BottomNavigationBarItem(
                                      label: 'Home',
                                      icon: ImageIcon(
                                        AssetImage(MyImagesUrl.iconHome),
                                        size: 22,
                                      ),
                                      // icon: Icon(Icons.),
                                      activeIcon: ImageIcon(
                                        AssetImage(
                                            MyImagesUrl.iconSelectedHome),
                                        size: 22,
                                      ),
                                    ),
                                    BottomNavigationBarItem(
                                      label: 'History',
                                      icon: ImageIcon(
                                        AssetImage(MyImagesUrl.iconHistory),
                                        size: 22,
                                      ),
                                      activeIcon: ImageIcon(
                                        AssetImage(
                                            MyImagesUrl.iconSelectedHistory),
                                        size: 22,
                                      ),
                                      backgroundColor: MyColors.whiteColor,
                                    ),
                                    BottomNavigationBarItem(
                                      label: ' ',
                                      icon: ImageIcon(
                                        AssetImage(MyImagesUrl.iconHistory),
                                        color: MyColors.transparent,
                                        size: 30,
                                      ),
                                      // icon: Icon(Icons.),
                                      activeIcon: ImageIcon(
                                        AssetImage(MyImagesUrl.iconHistory),
                                        color: MyColors.transparent,
                                        size: 30,
                                      ),
                                      backgroundColor: MyColors.whiteColor,
                                    ),
                                    BottomNavigationBarItem(
                                      label: 'Chat',
                                      icon: ImageIcon(
                                        AssetImage(MyImagesUrl.iconChat),
                                        size: 22,
                                      ),
                                      // icon: Icon(Icons.),
                                      activeIcon: ImageIcon(
                                        AssetImage(
                                            MyImagesUrl.iconSelectedChat),
                                        size: 22,
                                      ),
                                      backgroundColor: MyColors.whiteColor,
                                    ),
                                    BottomNavigationBarItem(
                                      label: 'My Profile',
                                      icon: ImageIcon(
                                        AssetImage(MyImagesUrl.iconProfile),
                                        size: 22,
                                      ),
                                      activeIcon: ImageIcon(
                                        AssetImage(
                                            MyImagesUrl.iconSelectedProfile),
                                        size: 22,
                                      ),
                                      backgroundColor: MyColors.whiteColor,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CustomShape extends NotchedShape {
  /// Creates a [CircularNotchedRectangle].
  ///
  /// The same object can be used to create multiple shapes.
  const CustomShape();

  /// Creates a [Path] that describes a rectangle with a smooth circular notch.
  ///
  /// `host` is the bounding box for the returned shape. Conceptually this is
  /// the rectangle to which the notch will be applied.
  ///
  /// `guest` is the bounding box of a circle that the notch accommodates. All
  /// points in the circle bounded by `guest` will be outside of the returned
  /// path.
  ///
  /// The notch is curve that smoothly connects the host's top edge and
  /// the guest circle.
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
