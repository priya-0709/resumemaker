import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:resumemaker/core/data/database/models/resume_model.dart';
import 'package:resumemaker/res/app_button.dart';
import 'package:resumemaker/res/app_text_field.dart';
import 'package:resumemaker/res/color_print.dart';
import 'package:resumemaker/route/app_routes.dart';
import 'package:resumemaker/utils/ui_utils.dart';
import 'package:resumemaker/utils/utils.dart';

import '../../core/data/database/database.dart';
import '../../res/app_strings.dart';
import '../../res/app_theme.dart';
import '../../res/icon_button.dart';
import '../dashboard/dashboard_controller.dart';
import 'add_or_edit_resume_controller.dart';

class AddOrEditResumeScreen extends StatelessWidget {
  AddOrEditResumeScreen({super.key});
  final AddOrEditResumeController con = Get.put(AddOrEditResumeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your resume"),
        leading: AppIconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(defaultPadding),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Text(
              "Personal Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: defaultPadding),
            AppTextField(
              title: "Full Name",
              hintText: "Enter your full name",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: con.nameCon.value,
              showError: con.nameValid.value,
              errorMessage: con.nameError.value,
              onChanged: (val) {
                if (con.nameValid.value == true) {
                  con.nameValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            AppTextField(
              title: "Email",
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: con.emailCon.value,
              showError: con.emailValid.value,
              errorMessage: con.emailError.value,
              onChanged: (val) {
                if (con.emailValid.value == true) {
                  con.emailValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            AppTextField(
              title: "Designation",
              hintText: "Enter your designation",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: con.designationCon.value,
              showError: con.designationValid.value,
              errorMessage: con.designationError.value,
              onChanged: (val) {
                if (con.designationValid.value == true) {
                  con.designationValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            AppTextField(
              title: "Mobile Number",
              hintText: "000 000 0000",
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              prefixIcon: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    AppStrings.indiaCountryCode,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      fontFamily: AppTheme.fontFamilyName,
                    ),
                  ),
                ),
              ),
              controller: con.mobileNumberCon.value,
              showError: con.mobileNumberValid.value,
              errorMessage: con.mobileNumberError.value,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: (val) {
                if (con.mobileNumberCon.value.text.trim().length != 10) {
                  con.mobileNumberError.value =
                      "Please enter valid mobile number";
                  con.mobileNumberValid.value = true;
                } else {
                  con.mobileNumberValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            Text(
              "Date of Birth",
              style: TextStyle(
                fontSize: 13.5.sp,
                fontFamily: AppTheme.fontFamilyName,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: con.selectedDate.value,
                  firstDate: DateTime(1800),
                  lastDate: DateTime.now(),
                );

                if (picked != null) {
                  con.selectedDate.value = picked;
                  con.confirmDate.value = con.selectedDate.value.toString();
                }
              },
              child: Container(
                height: 46.h,
                width: Get.width,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: defaultPadding),
                padding: const EdgeInsets.only(left: defaultPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Text(
                  con.confirmDate.value.isEmpty
                      ? "Choose date of birth"
                      : con.confirmDate.value.split(" ").first,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: con.confirmDate.value.isEmpty
                        ? FontWeight.w400
                        : FontWeight.w500,
                    color: con.confirmDate.value.isEmpty
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            AppTextField(
              title: "Address",
              hintText: "Enter your address",
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              controller: con.addressCon.value,
              showError: con.addressValid.value,
              errorMessage: con.addressError.value,
              defaultMaxLengthView: true,
              maxLines: 5,
              onChanged: (val) {
                if (con.addressValid.value == true) {
                  con.addressValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            Text(
              "Education Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: defaultPadding),
            AppTextField(
              title: "College Name",
              hintText: "Enter your college name",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: con.collegeCon.value,
              showError: con.collegeValid.value,
              errorMessage: con.collegeError.value,
              onChanged: (val) {
                if (con.collegeValid.value == true) {
                  con.collegeValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            AppTextField(
              title: "Degree/Course",
              hintText: "Enter your degree or course",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: con.degreeCon.value,
              showError: con.degreeValid.value,
              errorMessage: con.degreeError.value,
              onChanged: (val) {
                if (con.degreeValid.value == true) {
                  con.degreeValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    title: "Start Year",
                    hintText: "Start year",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: con.startYearCon.value,
                    showError: con.startYearValid.value,
                    errorMessage: con.startYearError.value,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    onChanged: (val) {
                      if (con.startYearValid.value == true) {
                        con.startYearValid.value = false;
                      }
                    },
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                  ),
                ),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: AppTextField(
                    title: "End Year",
                    hintText: "End year",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: con.endYearCon.value,
                    showError: con.endYearValid.value,
                    errorMessage: con.endYearError.value,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    onChanged: (val) {
                      if (con.endYearValid.value == true) {
                        con.endYearValid.value = false;
                      }
                    },
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                  ),
                ),
              ],
            ),
            AppTextField(
              title: "Skill",
              hintText: "Enter your Skill",
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.done,
              controller: con.skillCon.value,
              showError: con.skillValid.value,
              errorMessage: con.skillError.value,
              defaultMaxLengthView: true,
              maxLines: 5,
              onChanged: (val) {
                if (con.skillValid.value == true) {
                  con.skillValid.value = false;
                }
              },
              padding: const EdgeInsets.only(bottom: defaultPadding),
            ),
            SizedBox(
              height: 20.0,
              child: RadioGroup<String>.builder(
                direction: Axis.horizontal,
                groupValue: con.fresherOrExperience.value,
                horizontalAlignment: MainAxisAlignment.spaceAround,
                onChanged: (value) {
                  con.fresherOrExperience.value = value ?? "";
                  printWhite(con.fresherOrExperience.value);
                },
                items: con.status,
                textStyle: TextStyle(
                  fontSize: 13.5.sp,
                  fontFamily: AppTheme.fontFamilyName,
                  color: Theme.of(context).primaryColor,
                ),
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
            ),
            if (con.fresherOrExperience.value == "Experience")
              const SizedBox(height: defaultPadding),
            if (con.fresherOrExperience.value == "Experience")
              AppTextField(
                title: "How many years of experience?",
                hintText: "Enter your experience",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: con.experienceOfYearCon.value,
                showError: con.experienceOfYearValid.value,
                errorMessage: con.experienceOfYearError.value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChanged: (val) {
                  if (con.experienceOfYearValid.value == true) {
                    con.experienceOfYearValid.value = false;
                  }
                },
                padding: const EdgeInsets.only(bottom: defaultPadding),
              ),
            if (con.fresherOrExperience.value != "Experience")
              const SizedBox(height: defaultPadding),
            AppButton(
              onPressed: () async {
                /// name validation
                if (con.nameCon.value.text.trim().isEmpty) {
                  con.nameValid.value = true;
                  con.nameError.value = "Please enter your name";
                } else {
                  con.nameValid.value = false; // Complete
                }

                ///  Mobile validation
                if (con.mobileNumberCon.value.text.trim().isEmpty) {
                  con.mobileNumberValid.value = true;
                  con.mobileNumberError.value = "Please enter mobile number";
                }

                ///  email validation
                if (con.emailCon.value.text.trim().isEmpty) {
                  con.emailValid.value = true;
                  con.emailError.value = "Please enter your email";
                } else if (!GetUtils.isEmail(con.emailCon.value.text.trim())) {
                  con.emailValid.value = true;
                  con.emailError.value = "Please enter valid email";
                } else {
                  con.emailValid.value = false; // Complete
                }

                ///  Address Validation
                if (con.addressCon.value.text.trim().isEmpty) {
                  con.addressValid.value = true;
                  con.addressError.value = "Please enter your Address";
                } else {
                  con.addressValid.value = false; // Complete
                }

                ///  Designation Validation
                if (con.designationCon.value.text.trim().isEmpty) {
                  con.designationValid.value = true;
                  con.designationError.value = "Please enter your designation";
                } else {
                  con.designationValid.value = false; // Complete
                }

                ///  Address Validation
                if (con.addressCon.value.text.trim().isEmpty) {
                  con.addressValid.value = true;
                  con.addressError.value = "Please enter your address";
                } else {
                  con.addressValid.value = false; // Complete
                }

                ///  College Name Validation
                if (con.collegeCon.value.text.trim().isEmpty) {
                  con.collegeValid.value = true;
                  con.collegeError.value = "Please enter your college name";
                } else {
                  con.collegeValid.value = false; // Complete
                }

                ///  Degree/Course Name Validation
                if (con.degreeCon.value.text.trim().isEmpty) {
                  con.degreeValid.value = true;
                  con.degreeError.value = "Please enter your degree or course";
                } else {
                  con.degreeValid.value = false; // Complete
                }

                ///  Start Year Validation
                if (con.startYearCon.value.text.trim().isEmpty) {
                  con.startYearValid.value = true;
                  con.startYearError.value = "Please enter start year";
                } else {
                  con.startYearValid.value = false; // Complete
                }

                ///  End Year Validation
                if (con.endYearCon.value.text.trim().isEmpty) {
                  con.endYearValid.value = true;
                  con.endYearError.value = "Please enter end year";
                } else {
                  con.endYearValid.value = false; // Complete
                }

                /// Skill Validation
                if (con.skillCon.value.text.trim().isEmpty) {
                  con.skillValid.value = true;
                  con.skillError.value = "Please enter your skill";
                } else {
                  con.skillValid.value = false; // Complete
                }

                /// Year Of Experience Validation
                if (con.experienceOfYearCon.value.text.trim().isEmpty) {
                  con.experienceOfYearValid.value = true;
                  con.experienceOfYearError.value =
                      "Please enter year of experience";
                } else {
                  con.experienceOfYearValid.value = false; // Complete
                }
                if (con.confirmDate.value.isEmpty) {
                  UiUtils.toast("Please select your date of birth");
                }

                if (con.nameValid.isFalse &&
                        con.emailValid.isFalse &&
                        con.degreeValid.isFalse &&
                        con.mobileNumberValid.isFalse &&
                        con.confirmDate.value.isNotEmpty &&
                        con.addressValid.isFalse &&
                        con.collegeValid.isFalse &&
                        con.degreeValid.isFalse &&
                        con.startYearValid.isFalse &&
                        con.endYearValid.isFalse &&
                        con.skillValid
                            .isFalse /* &&
                    con.experienceOfYearValid.isFalse*/
                    ) {
                  printOkStatus("Done");

                  if (con.isUpdateResume.isFalse) {
                    await DatabaseHelper()
                        .setResumeData(
                      resumeModel: ResumeModel(
                        uid: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: con.nameCon.value.text.trim(),
                        email: con.emailCon.value.text.trim(),
                        designation: con.designationCon.value.text.trim(),
                        mobileNumber: con.mobileNumberCon.value.text.trim(),
                        dateOfBirth: con.confirmDate.value,
                        address: con.addressCon.value.text.trim(),
                        collegeName: con.collegeCon.value.text.trim(),
                        degree: con.degreeCon.value.text.trim(),
                        startYear: con.startYearCon.value.text.trim(),
                        endYear: con.endYearCon.value.text.trim(),
                        skill: con.skillCon.value.text.trim(),
                        fresherOrExperience: con.fresherOrExperience.value,
                        experienceOfYear:
                            con.experienceOfYearCon.value.text.trim(),
                        createdAt: DateTime.now(),
                      ),
                    )
                        .then(
                      (resumeModel) {
                        if (resumeModel != null) {
                          if (Get.isRegistered<DashboardController>()) {
                            final DashboardController dashCon =
                                Get.find<DashboardController>();
                            dashCon.resumeList.add(resumeModel);
                            UiUtils.toast("Quotation added successfully");
                            Get.back();
                            Get.toNamed(
                              AppRoutes.pdfGenerateScreen,
                              arguments: {
                                "quotationModel": resumeModel,
                              },
                            );
                          }
                        }
                      },
                    );
                  } else {
                    await DatabaseHelper()
                        .updateResumeData(
                      resumeModel: ResumeModel(
                        uid: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: con.nameCon.value.text.trim(),
                        email: con.emailCon.value.text.trim(),
                        designation: con.designationCon.value.text.trim(),
                        mobileNumber: con.mobileNumberCon.value.text.trim(),
                        dateOfBirth: con.confirmDate.value,
                        address: con.addressCon.value.text.trim(),
                        collegeName: con.collegeCon.value.text.trim(),
                        degree: con.degreeCon.value.text.trim(),
                        startYear: con.startYearCon.value.text.trim(),
                        endYear: con.endYearCon.value.text.trim(),
                        skill: con.skillCon.value.text.trim(),
                        fresherOrExperience: con.fresherOrExperience.value,
                        experienceOfYear:
                            con.experienceOfYearCon.value.text.trim(),
                        updateAt: DateTime.now(),
                      ),
                    )
                        .then(
                      (quotationModel) {
                        if (quotationModel != null) {
                          if (Get.isRegistered<DashboardController>()) {
                            final DashboardController dashCon =
                                Get.find<DashboardController>();
                            int myIndex = dashCon.resumeList.indexWhere(
                                (element) => element.uid == quotationModel.uid);
                            if (myIndex != -1) {
                              dashCon.resumeList.removeAt(myIndex);
                              dashCon.resumeList
                                  .insert(myIndex, quotationModel);
                            }
                            UiUtils.toast("Resume update successfully");
                            Get.back();
                          }
                        }
                      },
                    );
                  }
                }
              },
              title: "Create",
            ),
          ],
        ),
      ),
    );
  }
}
