import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/controller/base_controller.dart';
import 'core/data/database/database.dart';
import 'firebase_options.dart';
import 'res/app_colors.dart';
import 'res/app_strings.dart';
import 'res/app_theme.dart';
import 'res/color_print.dart';
import 'route/app_pages.dart';
import 'route/app_routes.dart';
import 'utils/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await LocalStorage.readDataInfo();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DatabaseHelper().initDatabase();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorage.printLocalStorageData();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          initialBinding: LazyBinding(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightMode(
            kPrimaryColor: AppColors.kPrimaryColor,
            kBackgroundColor: AppColors.kBackgroundColor,
            errorColor: AppColors.errorColor,
            fontFamily: AppTheme.fontFamilyName,
          ),
          darkTheme: AppTheme.darkMode(
            kPrimaryColor: AppColors.kPrimaryColor,
            kBackgroundColor: AppColors.kBackgroundColor,
            errorColor: AppColors.errorColor,
            fontFamily: AppTheme.fontFamilyName,
          ),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}

class LazyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
    printData(key: "Get.put", value: BaseController);
  }
}
