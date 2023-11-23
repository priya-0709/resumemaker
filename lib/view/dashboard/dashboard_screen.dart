import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumemaker/utils/utils.dart';

import '../../core/controller/base_controller.dart';
import '../../res/app_loader.dart';
import '../../res/empty_element.dart';
import '../../route/app_routes.dart';
import 'components/quotation_tile.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController con = Get.put(DashboardController());
  final BaseController baseCon = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.globalKey,
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Obx(
        () => con.isLoader.isFalse
            ? (con.resumeList.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(defaultPadding).copyWith(
                        bottom: MediaQuery.of(context).padding.bottom +
                            defaultPadding * 5),
                    itemBuilder: (context, index) {
                      return ResumeTile(
                        resumeModel: con.resumeList[index].obs,
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: defaultPadding,
                      );
                    },
                    itemCount: con.resumeList.length,
                  )
                : const EmptyElement(title: "No Resume Found"))
            : const CircularLoader(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.toNamed(AppRoutes.addOrUpdateResumeScreen);
        },
      ),
    );
  }
}
