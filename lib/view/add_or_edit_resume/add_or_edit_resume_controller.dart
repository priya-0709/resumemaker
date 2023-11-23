import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/data/database/database.dart';
import '../../core/data/database/models/resume_model.dart';
import '../../utils/utils.dart';

class AddOrEditResumeController extends GetxController {
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  RxBool nameValid = false.obs;
  RxString nameError = ''.obs;

  Rx<TextEditingController> emailCon = TextEditingController().obs;
  RxBool emailValid = false.obs;
  RxString emailError = ''.obs;

  Rx<TextEditingController> mobileNumberCon = TextEditingController().obs;
  RxBool mobileNumberValid = false.obs;
  RxString mobileNumberError = ''.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString confirmDate = "".obs;

  Rx<TextEditingController> addressCon = TextEditingController().obs;
  RxBool addressValid = false.obs;
  RxString addressError = ''.obs;

  Rx<TextEditingController> designationCon = TextEditingController().obs;
  RxBool designationValid = false.obs;
  RxString designationError = ''.obs;

  Rx<TextEditingController> collegeCon = TextEditingController().obs;
  RxBool collegeValid = false.obs;
  RxString collegeError = ''.obs;

  Rx<TextEditingController> degreeCon = TextEditingController().obs;
  RxBool degreeValid = false.obs;
  RxString degreeError = ''.obs;

  Rx<TextEditingController> startYearCon = TextEditingController().obs;
  RxBool startYearValid = false.obs;
  RxString startYearError = ''.obs;

  Rx<TextEditingController> endYearCon = TextEditingController().obs;
  RxBool endYearValid = false.obs;
  RxString endYearError = ''.obs;
  Rx<TextEditingController> skillCon = TextEditingController().obs;
  RxBool skillValid = false.obs;
  RxString skillError = ''.obs;

  Rx<TextEditingController> experienceOfYearCon = TextEditingController().obs;
  RxBool experienceOfYearValid = false.obs;
  RxString experienceOfYearError = ''.obs;

  RxString fresherOrExperience = "Fresher".obs;
  final status = ["Fresher", "Experience"];

  RxString resumeId = "".obs;
  RxBool isLoader = false.obs;

  /// Update module
  RxBool isUpdateResume = false.obs;
  Rx<ResumeModel> resumeModel = ResumeModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      if (!isValEmpty(Get.arguments["resumeId"])) {
        resumeId.value = Get.arguments['resumeId'];
        isUpdateResume.value = true;
        DatabaseHelper()
            .getSingleResumeModel(
                quotationId: resumeId.value, isLoader: isLoader)
            .then(
          (value) async {
            if (value != null) {
              resumeModel.value = value;
              await setLocalDataToModel();
            }
          },
        );
      }
    }
  }

  Future setLocalDataToModel() async {
    nameCon.value.text = resumeModel.value.name ?? "";
    emailCon.value.text = resumeModel.value.email ?? "";
    designationCon.value.text = resumeModel.value.designation ?? "";
    mobileNumberCon.value.text = resumeModel.value.mobileNumber ?? "";
    confirmDate.value = resumeModel.value.dateOfBirth ?? "";
    addressCon.value.text = resumeModel.value.address ?? "";
    collegeCon.value.text = resumeModel.value.collegeName ?? "";
    degreeCon.value.text = resumeModel.value.degree ?? "";
    startYearCon.value.text = resumeModel.value.startYear ?? "";
    endYearCon.value.text = resumeModel.value.endYear ?? "";
    skillCon.value.text = resumeModel.value.skill ?? "";
    skillCon.value.text = resumeModel.value.skill ?? "";
    fresherOrExperience.value = resumeModel.value.fresherOrExperience ?? "";
  }
}
