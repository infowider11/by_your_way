import 'package:flutter/cupertino.dart';

import '../functions/print_function.dart';

class CustomPaginatedListView<T> extends StatelessWidget {
  final NullableIndexedWidgetBuilder? itemBuilder;
  final Widget? child;
  final ScrollPhysics? physics;
  final int? itemCount;
  final Function()? onMaxScrollExtent;
  const CustomPaginatedListView({
    super.key,
    required this.itemBuilder,
    required this.physics,
    required this.itemCount,
    this.child,
    this.onMaxScrollExtent,
  });

  @override
  Widget build(BuildContext context) {


    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (scroll) {
        myCustomPrintStatement('Notification is listened');

        if (scroll.metrics.maxScrollExtent == scroll.metrics.pixels) {
          myCustomPrintStatement('Notification is listened...max extent reached');

          if(onMaxScrollExtent!=null){
            onMaxScrollExtent!();
          }
        }
        return true;
      },
      child: ListView.builder(
        itemBuilder: itemBuilder??(context, index){
          return child;
        },
        physics: physics??AlwaysScrollableScrollPhysics(),
        itemCount: itemCount,

      ),
    );
  }
}
