import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../res/app_strings.dart';
import '../../../utils/utils.dart';

class DashboardDialogs {
  static backOperation(BuildContext context) {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2).copyWith(top: 0),
                padding: const EdgeInsets.all(defaultPadding),
                child: const Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
                child: Text(
                  AppStrings.exitAppString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.all(defaultPadding / 2.5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(defaultRadius)),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final cacheDir = await getTemporaryDirectory();
                        if (cacheDir.existsSync()) {
                          cacheDir.deleteSync(recursive: true);
                        }
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(defaultRadius)),
                        ),
                        padding: const EdgeInsets.all(defaultPadding / 2.5),
                        child: Center(
                          child: Text(
                            "Exit",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future logoutDialog(BuildContext context, {required VoidCallback onTap, required RxBool isLoader}) {
    return Get.dialog(
      barrierDismissible: !isLoader.value,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2).copyWith(top: 0),
                padding: const EdgeInsets.all(defaultPadding),
                child: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
                child: Text(
                  AppStrings.logoutString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.all(defaultPadding / 2.5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(defaultRadius)),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: isLoader.isFalse ? onTap : null,
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(defaultRadius)),
                        ),
                        padding: const EdgeInsets.all(defaultPadding / 2.5),
                        child: Obx(
                          () => Center(
                            child: isLoader.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
