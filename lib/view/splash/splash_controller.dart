import 'package:get/get.dart';

import '../../route/app_routes.dart';

class SplashController extends GetxController {
  @override
  onReady() async {
    super.onReady();
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      navigate();
    });
  }

  void navigate() async {
    Get.offAllNamed(AppRoutes.dashboardScreen);
  }
}
