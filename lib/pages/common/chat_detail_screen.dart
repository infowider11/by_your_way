import 'package:by_your_way/constants/global_data.dart';
import 'package:by_your_way/constants/my_colors.dart';
import 'package:by_your_way/constants/my_image_url.dart';
import 'package:by_your_way/constants/sized_box.dart';
import 'package:by_your_way/widget/custom_appbar.dart';
import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:by_your_way/widget/custom_text.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  ValueNotifier<bool> isStartSend = ValueNotifier(false);
  final messageController = TextEditingController();

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
              bgcolor: MyColors.whiteColor,
              title: Padding(
                padding: const EdgeInsets.only(left: globalHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCircularImage(
                            imageUrl: MyImagesUrl.iconDummyUser,
                            width: 45,
                            height: 45,
                            borderRadius: 25,
                            padding: 0,
                            fileType: CustomFileType.asset),
                        hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainHeadingText(
                              "Kim Change",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          MyImagesUrl.iconThreeDot,
                          height: 24,
                          width: 24,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomCurve: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: globalHorizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox2,
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: 10,
                      itemBuilder: (context, index) => ConversationMessageCard(
                        messageAlignment: index.isEven
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        messagesBgColor: index.isEven
                            ? MyColors.blackColor50.withOpacity(0.1)
                            : MyColors.primaryColor,
                        messagesTextStyle: TextStyle(
                          color: index.isEven
                              ? MyColors.blackColor
                              : MyColors.whiteColor,
                          fontSize: 12,
                        ),
                        index: index,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: "Type message here..........",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    MyColors.primaryColor.withOpacity(0.1),
                                suffixIcon: ValueListenableBuilder(
                                    valueListenable: isStartSend,
                                    builder: (context, isStart, child) {
                                      if (isStart) {
                                        return Container(
                                          height: 24,
                                          width: 24,
                                          padding: const EdgeInsets.all(10),
                                          child:
                                              const CircularProgressIndicator(
                                            color: MyColors.primaryColor,
                                            strokeWidth: 2,
                                          ),
                                        );
                                      } else {
                                        return IconButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          icon: Image.asset(
                                            MyImagesUrl.iconSend,
                                            height: 25,
                                            width: 25,
                                          ),
                                        );
                                      }
                                    }),
                                /*  prefixIcon: GestureDetector(
                                  onTap: () async {
                                    file.value =
                                    await pickImage(true);
                                  },
                                  child: const Icon(
                                    Icons.attach_file,
                                    color: MyColors.blackColor,
                                  ),
                                ),*/
                              ),
                              maxLines: 3,
                              validator: (val) {
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(
                                  color: Color(0xff7A7A7A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationMessageCard extends StatelessWidget {
  final Alignment messageAlignment;
  final Color messagesBgColor;
  final TextStyle messagesTextStyle;
  final int index;

  const ConversationMessageCard({
    super.key,
    required this.messageAlignment,
    required this.messagesBgColor,
    required this.messagesTextStyle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Align(
            alignment: messageAlignment,
            child: Container(
              // height: 100,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 245,
              decoration: BoxDecoration(
                color: messagesBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  bottomRight: Radius.circular(
                      MyColors.primaryColor == messagesBgColor ? 15 : 0),
                  bottomLeft: Radius.circular(
                      MyColors.primaryColor != messagesBgColor ? 15 : 0),
                  topRight: const Radius.circular(15),
                ),
              ),
              child: Text(
                index.isOdd
                    ? 'Hi, It\'s nice to meet you!'
                    : "Nice to meet you too! Looks like we both enjoy going to comedy ows! ",
                style: messagesTextStyle,
              ),
            ),
          ),
          Align(
            alignment: messagesBgColor == MyColors.primaryColor
                ? Alignment.topLeft
                : Alignment.topRight,
            child: const SizedBox(
              child: ParagraphText(
                "3:06 PM",
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
