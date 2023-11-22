import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';

Widget simmer({required Widget child, Color? color, bool isShowSimmer = true}) {
  if (isShowSimmer == true) {
    return Shimmer.fromColors(
      baseColor: color?.withOpacity(0.7) ?? AppColors.kPrimaryColor.withOpacity(0.7),
      highlightColor: color?.withOpacity(0.1) ?? AppColors.kPrimaryColor.withOpacity(0.1),
      child: child,
    );
  } else {
    return child;
  }
}

Container d({Color? color}) {
  return Container(
    height: 1,
    color: color ?? Colors.white.withOpacity(0.2),
  );
}
