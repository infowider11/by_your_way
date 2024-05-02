import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/pages/auth_module/edit_profile_screen.dart';
import 'package:by_your_way/pages/common/review_screen.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_gesture_detector.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_text.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              isBackIcon: true,
              title: Padding(
                padding: const EdgeInsets.only(left: globalHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainHeadingText(
                          "Back ",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ],
                    ),
                    CustomGestureDetector(
                      onTap: () {
                        push(
                            context: context,
                            screen: const EditProfileScreen());
                      },
                      borderRadius: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          MyImagesUrl.iconEditProfile,
                          height: 17,
                          width: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: globalHorizontalPadding,
              ),
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: ValueListenableBuilder(
                  valueListenable: userDataNotifier,
                  builder: (context, authProvider, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vSizedBox2,
                        Expanded(
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const MainHeadingText(
                                          "John Doe",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        vSizedBox05,
                                        ParagraphText(
                                          "john@gmail.com",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.blackColor50,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: MyColors.primaryColor,
                                        size: 22,
                                      ),
                                      hSizedBox02,
                                      MainHeadingText(
                                        "4.7 (828k)",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.blackColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              vSizedBox2,
                              const CustomCircularImage(
                                  imageUrl: MyImagesUrl.iconDummyUser,
                                  width: double.infinity,
                                  height: 200,
                                  borderRadius: 15,
                                  padding: 0,
                                  fileType: CustomFileType.asset),
                              vSizedBox2,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        MyImagesUrl.iconEmail,
                                        height: 13,
                                        width: 17,
                                      ),
                                      hSizedBox,
                                      const MainHeadingText(
                                        "john@gmail.com",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.blackColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        MyImagesUrl.iconPhone,
                                        height: 13,
                                        width: 13,
                                      ),
                                      hSizedBox,
                                      const MainHeadingText(
                                        "+123 69 25654",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.blackColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              vSizedBox2,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const MainHeadingText(
                                    "Reviews",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.blackColor,
                                  ),
                                  CustomGestureDetector(
                                    onTap: () {
                                      push(context: context, screen: const ReviewsScreen());
                                    },
                                    borderRadius: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: MyColors.primaryColor,
                                      ),
                                      child: const ParagraphText("View More",
                                          fontSize: 12,
                                          color: MyColors.whiteColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              vSizedBox2,
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: CustomGestureDetector(
                                      onTap: () {},
                                      borderRadius: 25,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 13),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 1,
                                              color: MyColors.blackColor50),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const CustomCircularImage(
                                                    imageUrl: MyImagesUrl
                                                        .iconDummyUser,
                                                    width: 50,
                                                    height: 50,
                                                    borderRadius: 25,
                                                    padding: 0,
                                                    fileType:
                                                        CustomFileType.asset),
                                                hSizedBox,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const MainHeadingText(
                                                        "John Doe",
                                                        fontSize: 14,
                                                      ),
                                                      MainHeadingText(
                                                        "Apr 2022",
                                                        fontSize: 12,
                                                        color: MyColors
                                                            .blackColor50,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      MyImagesUrl.iconRatting,
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    hSizedBox05,
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3),
                                                      child: MainHeadingText(
                                                        "4.7",
                                                        fontSize: 12,
                                                        color:
                                                            MyColors.blackColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            vSizedBox,
                                            const ParagraphText(
                                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
