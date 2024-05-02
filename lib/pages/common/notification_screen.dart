import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_your_way/functions/custom_time_functions.dart';
import 'package:by_your_way/provider/notifications_provider.dart';
import 'package:by_your_way/widget/custom_loader.dart';
import '../../constants/global_data.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_image_url.dart';
import '../../constants/sized_box.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var notificationsProvider = Provider.of<NotificationsProvider>(context, listen: false);
      notificationsProvider.getNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackIcon: true,
        titleText: 'Notifications',
        titleFontSize: 20,
        titleFontWeight: FontWeight.w600,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<NotificationsProvider>(
              builder: (context, notificationsProvider, child) {

                if(notificationsProvider.notificationsLoad){
                  return const CustomLoader();
                }
                if(notificationsProvider.notifications.isEmpty){
                  return const Center(
                    child: ParagraphText('No Notifications Found'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: globalHorizontalPadding),
                    itemCount: notificationsProvider.notifications.length,
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: (){
                            NotificationsProvider.handleNotification(data: notificationsProvider.notifications[index].otherData, context: context, popAll: false);
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: MyColors.greyColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(MyImagesUrl.userProfile,
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                hSizedBox,
                                Expanded(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ParagraphText(
                                              notificationsProvider.notifications[index].title,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.secondaryColor,
                                            ),
                                            vSizedBox02,
                                            ParagraphText(
                                              notificationsProvider.notifications[index].message,
                                              // 'Mathew Buy goat for Farmhouse 5 ',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.secondaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      hSizedBox05,
                                      ParagraphText(
                                        CustomTimeFunctions.timeAgo(notificationsProvider.notifications[index].createdAt),
                                        // '1 min ago',
                                        fontSize: 10,
                                        color: MyColors.blackColor50,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
              }
            ),
          )
        ],
      ),
    );
  }
}
