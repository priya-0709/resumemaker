import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/app_colors.dart';

class UiUtils {
  static String indianRupee = '₹';
  static Future toast(message) async {
    FToast fToast = FToast();
    fToast.removeQueuedCustomToasts();
    fToast.removeCustomToast();
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }

  static boxShadow({double? blurRadius, double? spreadRadius, Color? color, Offset? offset}) => [
        BoxShadow(
          color: color ?? AppColors.blackColor.withOpacity(0.2),
          spreadRadius: spreadRadius ?? 1,
          blurRadius: blurRadius ?? 4,
          offset: offset ?? const Offset(0, 3),
        ),
      ];
  static Widget simmerContainer({double? height, double? width, double? borderRadius, Widget? child, Decoration? decoration}) => Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 50),
              color: AppColors.kPrimaryColor.withOpacity(0.1),
            ),
      );
}
