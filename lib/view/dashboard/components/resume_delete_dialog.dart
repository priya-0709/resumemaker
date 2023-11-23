import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/data/database/database.dart';
import '../../../utils/ui_utils.dart';
import '../../../utils/utils.dart';
import '../../dashboard/dashboard_controller.dart';

class ResumeDeleteDialog {
  static Future deleteResumeDialog(BuildContext context,
      {required String resumeId}) {
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
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2)
                    .copyWith(top: 0),
                padding: const EdgeInsets.all(defaultPadding),
                child: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Text(
                  "Are you sure delete your resume?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
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
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(defaultRadius)),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        await DatabaseHelper()
                            .deleteResume(resumeId: resumeId)
                            .then(
                          (quotationModelId) {
                            if (!isValEmpty(quotationModelId)) {
                              if (Get.isRegistered<DashboardController>()) {
                                final DashboardController dashCon =
                                    Get.find<DashboardController>();
                                dashCon.resumeList.removeWhere(
                                    (value) => value.uid == quotationModelId);
                                UiUtils.toast("Resume deleted successfully");
                                Get.back();
                              }
                            }
                          },
                        );
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(defaultRadius)),
                        ),
                        padding: const EdgeInsets.all(defaultPadding / 2.5),
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
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
