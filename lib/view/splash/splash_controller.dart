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
    //! This static clause is written because there will be only one user in the database at any given time
    // if (LocalStorage.firebaseUid.value.isNotEmpty) {
    //   await DatabaseHelper().getBusinessInfoModel().then(
    //     (businessModel) {
    //       if (businessModel != null || !isValEmpty(businessModel?.id)) {
    //         Get.offAllNamed(AppRoutes.dashboardScreen);
    //       } else {
    //         Get.offAllNamed(
    //           AppRoutes.businessInfoScreen,
    //           arguments: {
    //             "isStartup": true,
    //           },
    //         );
    //       }
    //     },
    //   );
    // } else {
    // Get.offAllNamed(AppRoutes.loginScreen);
    Get.offAllNamed(AppRoutes.dashboardScreen);
    // }
  }
}
