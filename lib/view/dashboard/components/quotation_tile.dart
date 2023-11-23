import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resumemaker/core/data/database/models/resume_model.dart';
import 'package:resumemaker/view/dashboard/components/resume_delete_dialog.dart';

import '../../../res/app_colors.dart';
import '../../../res/icon_button.dart';
import '../../../route/app_routes.dart';
import '../../../utils/utils.dart';

class ResumeTile extends StatelessWidget {
  final Rx<ResumeModel>? resumeModel;
  final int index;

  const ResumeTile({
    super.key,
    this.resumeModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.pdfGenerateScreen,
          arguments: {
            "resumeModel": resumeModel?.value,
          },
        );
      },
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Document ${index + 1}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17.sp,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
                AppIconButton(
                  size: 30,
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.addOrUpdateResumeScreen,
                      arguments: {
                        "resumeId": resumeModel?.value.uid,
                      },
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 18,
                  ),
                ),
                AppIconButton(
                  size: 30,
                  onPressed: () {
                    ResumeDeleteDialog.deleteResumeDialog(context,
                        resumeId: resumeModel?.value.uid ?? "");
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat("dd MMM yyyy").format(quotationTime!),
                  style: TextStyle(fontSize: 13.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DateTime? get quotationTime {
    if (resumeModel?.value.createdAt != null) {
      return resumeModel?.value.createdAt; // Final value
    } else {
      return null;
    }
  }
}
