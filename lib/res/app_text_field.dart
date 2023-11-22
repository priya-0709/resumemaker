import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';
import 'app_theme.dart';

class AppTextField extends StatefulWidget {
  /// Global property
  final EdgeInsetsGeometry? padding;

  /// Title widget
  final String? title;
  final TextStyle? titleStyle;

  /// Filed widget
  final TextStyle? style;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? initialValue;

  final Function(String value)? onChanged;
  final String? Function(String?)? validate;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;

  final Widget? prefixIcon;
  final VoidCallback? prefixOnTap;
  final Widget? suffixIcon;
  final VoidCallback? suffixOnTap;

  final int? maxLines;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscureText;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;

  final Color? fillColor;
  final Color? cursorColor;
  final bool? autofocus;
  final double? radius;
  final double? cursorHeight;
  final double? titleSpacing;

  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;

  final bool? defaultMaxLengthView;

  /// Error widget
  final String? errorMessage;
  final bool? showError;
  final TextStyle? errorStyle;
  final double? errorSpacing;
  final double? errorHeight;

  const AppTextField({
    super.key,

    /// Global property
    this.padding,

    /// Title widget
    this.title,
    this.titleStyle,

    /// Filed widget
    this.style,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.initialValue,
    this.onChanged,
    this.validate,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.prefixOnTap,
    this.suffixIcon,
    this.suffixOnTap,
    this.maxLines,
    this.enabled,
    this.readOnly,
    this.obscureText,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
    this.contentPadding,
    this.fillColor,
    this.cursorColor,
    this.autofocus,
    this.radius,
    this.cursorHeight,
    this.titleSpacing,
    this.enabledBorder,
    this.border,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.errorBorder,
    this.defaultMaxLengthView,

    /// Error widget
    this.errorMessage,
    this.showError,
    this.errorStyle,
    this.errorSpacing,
    this.errorHeight,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focus = FocusNode();
  bool isFieldActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode?.addListener(_onFocusChange);
    } else {
      _focus.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    setState(() {
      if (widget.focusNode != null) {
        isFieldActive = widget.focusNode?.hasFocus ?? false;
      } else {
        isFieldActive = _focus.hasFocus;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      if (widget.focusNode != null) {
        widget.focusNode?.removeListener(_onFocusChange);
      } else {
        _focus.removeListener(_onFocusChange);
        _focus.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null && widget.title!.isNotEmpty) ...[
            titleWidget(context),
            SizedBox(height: widget.titleSpacing ?? 5),
          ],
          textFieldWidget(context),
          if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty)
            FieldErrorWidget(
              context,
              errorHeight: widget.errorHeight,
              errorSpacing: widget.errorSpacing,
              showError: widget.showError,
              errorStyle: widget.errorStyle,
              errorMessage: widget.errorMessage,
            ),
        ],
      ),
    );
  }

  Widget titleWidget(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 150),
      style: widget.titleStyle ??
          TextStyle(
            fontSize: 13.5.sp,
            fontFamily: AppTheme.fontFamilyName,
            color: isFieldActive == true
                ? Theme.of(context).primaryColor
                : Colors.grey.shade700,
          ),
      child: Text(
        widget.title!,
      ),
    );
  }

  TextFormField textFieldWidget(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      focusNode: (widget.focusNode ?? _focus),
      autofocus: widget.autofocus ?? false,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
      initialValue: widget.initialValue,
      controller: widget.controller,
      enabled: widget.enabled,
      cursorHeight: widget.cursorHeight,
      maxLength: widget.showError == false
          ? (widget.defaultMaxLengthView == true
              ? (widget.maxLength != 0 ? widget.maxLength : null)
              : null)
          : null,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      onChanged: (String value) {
        widget.onChanged != null ? widget.onChanged!(value) : null;
      },
      maxLines: widget.maxLines ?? 1,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: textFormFieldStyle,
      inputFormatters: widget.inputFormatters ??
          [
            if (widget.maxLength != null)
              LengthLimitingTextInputFormatter(widget.maxLength),
          ],
      readOnly: widget.readOnly ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            widget.fillColor ?? Theme.of(context).scaffoldBackgroundColor,
        isCollapsed: true,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(18),
        prefixIcon: widget.prefixIcon != null
            ? InkWell(
                overlayColor: MaterialStateProperty.all(
                    Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.white),
                onTap: widget.prefixOnTap,
                child: DefaultTextStyle(
                    style: textFormFieldStyle, child: widget.prefixIcon!),
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? InkWell(
                overlayColor: MaterialStateProperty.all(
                    Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.white),
                onTap: widget.suffixOnTap,
                child: widget.suffixIcon,
              )
            : null,
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(
                  color: widget.showError == false
                      ? Colors.grey.shade700
                      : Theme.of(context).colorScheme.error),
            ),
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .primaryColor
                      .withOpacity(widget.readOnly == true ? 0.2 : 1)),
            ),
        focusedErrorBorder: widget.focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
        disabledBorder: widget.disabledBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(color: Colors.grey.shade800),
            ),
        errorBorder: widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.error),
            ),
      ),
    );
  }

  BorderRadius get filedBorderRadius {
    return const BorderRadius.all(Radius.circular(defaultRadius));
  }

  TextStyle get textFormFieldStyle {
    return widget.style ?? TextStyle(fontSize: 15.sp);
  }
}

/// [FieldErrorWidget] You can also use the widget globally in a way where you have created your own custom TextField
class FieldErrorWidget extends StatelessWidget {
  final double? errorHeight;
  final double? errorSpacing;
  final bool? showError;
  final String? errorMessage;
  final TextStyle? errorStyle;
  final BuildContext? mainContext;

  const FieldErrorWidget(
    this.mainContext, {
    super.key,
    this.errorHeight,
    this.errorSpacing,
    this.showError = false,
    this.errorMessage,
    this.errorStyle,
  });

  @override
  Widget build(context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      tween: showError == true
          ? Tween(begin: 0.0, end: (errorHeight ?? 16.0) + (errorSpacing ?? 5))
          : Tween(begin: 0.0, end: 0.0),
      builder: (context, value, child) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: errorSpacing ?? 5),
          height: value,
          child: Text(
            errorMessage ?? "",
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: errorStyle ??
                TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        );
      },
    );
  }
}
