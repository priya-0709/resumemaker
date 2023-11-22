import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ShadowText extends StatelessWidget {
  final TextStyle? style;
  final Text textWidget;
  final double? blurSigmaX;

  const ShadowText({
    super.key,
    this.style,
    required this.textWidget,
    this.blurSigmaX,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Stack(
        children: [
          DefaultTextStyle(
            style: style?.copyWith(color: Colors.black.withOpacity(0.9)) ??
                Theme.of(context).textTheme.bodyMedium!,
            child: textWidget,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: blurSigmaX ?? 2.0, sigmaY: blurSigmaX ?? 2.0),
            child: Text(
              textWidget.data ?? "",
              style: style ?? Theme.of(context).textTheme.bodyMedium,
              textAlign: textWidget.textAlign,
              maxLines: textWidget.maxLines,
              overflow: textWidget.overflow,
            ),
          ),
        ],
      ),
    );
  }
}
