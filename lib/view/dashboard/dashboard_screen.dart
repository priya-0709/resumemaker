import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controller/base_controller.dart';
import '../../res/icon_button.dart';
import 'components/logout_dialog.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController con = Get.put(DashboardController());
  final BaseController baseCon = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (con.globalKey.currentState!.isDrawerOpen) {
          Get.back();
          return false;
        }
        DashboardDialogs.backOperation(context);
        return true;
      },
      child: Scaffold(
        key: con.globalKey,
        appBar: AppBar(
          title: const Text("Dashboard"),
          leading: Builder(
            builder: (context) {
              return AppIconButton(
                icon: const Icon(Icons.menu, size: 22),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
      ),
    );
  }
}
