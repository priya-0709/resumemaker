import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumemaker/core/data/database/models/resume_model.dart';

import '../../core/data/database/database.dart';

class DashboardController extends GetxController {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  RxBool isLoader = true.obs;
  RxList<ResumeModel> resumeList = <ResumeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    setAndGetUserData();
  }

  Future setAndGetUserData() async {
    await DatabaseHelper().getAllResumeModel(isLoader: isLoader).then(
      (value) {
        if (value != null) {
          resumeList.value = value;
        }
      },
    );
  }
}
