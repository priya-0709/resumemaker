import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MeasureSize extends StatefulWidget {
  final Widget child;
  final Function(RxDouble height, RxDouble width) onChange;

  const MeasureSize({super.key, required this.onChange, required this.child});

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final GlobalKey widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
  }

  Size? oldSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize || newSize == null) return;

    oldSize = newSize;
    widget.onChange(newSize.height.obs, newSize.width.obs);
  }
}
