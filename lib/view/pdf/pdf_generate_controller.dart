import 'package:get/get.dart';
import 'package:resumemaker/core/data/database/models/resume_model.dart';
import 'package:resumemaker/res/color_print.dart';

import '../../utils/utils.dart';

class PdfGenerateController extends GetxController {
  Rx<ResumeModel> resumeModel = ResumeModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments != null) {
      if (!isValEmpty(Get.arguments["resumeModel"])) {
        resumeModel.value = Get.arguments["resumeModel"];

        printData(key: "ResumeModel", value: resumeModel.value);
      }
    }
  }
}
