import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  RxString verticalGroupValue = "Fresher".obs;
  final status = ["Fresher", "Experience"];
}
