import 'package:by_your_way/provider/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  const CustomScaffold({
     this.appBar,
     this.body,
     this.backgroundColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
      builder: (context, appLanguageProvider, child) {
        print(' i am being relistend');
        return Scaffold(
          appBar: appBar,
          body: body,
          backgroundColor: backgroundColor,
        );
      }
    );
  }
}
