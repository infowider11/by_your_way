import 'package:by_your_way/widget/custom_circular_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/my_image_url.dart';
import '../../provider/auth_provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthProvider auth;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      auth = Provider.of<AuthProvider>(context, listen: false);
      auth.splashAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE4E4E4),
      body: Center(
        child: CustomCircularImage(
          imageUrl: MyImagesUrl.imageSplashScreen,
          height:  MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          borderRadius:0,
          fileType: CustomFileType.asset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
