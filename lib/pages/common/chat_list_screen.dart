import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/functions/navigation_functions.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_text.dart';
import 'chat_detail_screen.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        isBackIcon: false,
        title: const Padding(
          padding: EdgeInsets.only(left: globalHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainHeadingText(
                    "Chat List",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ],
              ),
              CustomCircularImage(
                  imageUrl: MyImagesUrl.iconDummyUser,
                  width: 45,
                  height: 45,
                  borderRadius: 25,
                  padding: 0,
                  fileType: CustomFileType.asset),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox2,
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      push(context: context, screen: const ChatDetailScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      //color: MyColors.whiteColor,
                      child: Column(
                        children: [
                          if (index == 0) vSizedBox,
                          Row(
                            children: [
                              Container(
                                width: 64,
                                height: 62,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const CustomCircularImage(
                                  imageUrl: MyImagesUrl.iconDummyUser,
                                  width: 64,
                                  height: 62,
                                  borderRadius: 32,
                                  fileType: CustomFileType.asset,
                                ),
                              ),
                              hSizedBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          'Kim Change',
                                          fontSize: 16,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        hSizedBox,
                                        ParagraphText(
                                          "06 may 2024",
                                          fontSize: 12,
                                          maxLines: 1,
                                          color: MyColors.primaryColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: ParagraphText(
                                            "That's sound good. I get off work around...",
                                            fontSize: 14,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        hSizedBox,
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.primaryColor,
                                          ),
                                          child: ParagraphText(
                                            '${index + 1}',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: MyColors.whiteColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          vSizedBox,
                          Divider(
                            color: MyColors.blackColor.withOpacity(0.3),
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
