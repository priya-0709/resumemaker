import 'package:get/get.dart';

import '../view/add_or_edit_resume/add_or_edit_resume_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: AppRoutes.addOrUpdateResumeScreen,
      page: () => AddOrEditResumeScreen(),
    ),
  ];
}
