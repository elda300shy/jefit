import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jefit/core/helpers/extensions.dart';

class AppTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  
  final TextInputType? keyboardType;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.keyboardType
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late FocusNode focusNode;

  /// Custom Background Color for the TextFormField
  Color? customBackgroundColor;

  /// Initialize the focusNode when the widget is initialized
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(updateBackgroundColorWhenFocusChange);
  }

  // When Focus changes, we update the background color of the TextFormField
  /// Focus changes means That textfield is focused or unfocused
  void updateBackgroundColorWhenFocusChange() {
    setState(() {
      customBackgroundColor = focusNode.hasFocus
          ? context.theme.scaffoldBackgroundColor
          : context.theme.colorScheme.surface;
    });
  }

  /// Dispose the focusNode when the widget is disposed
  @override
  void dispose() {
    focusNode.removeListener(updateBackgroundColorWhenFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: widget.controller,
      keyboardType:widget.keyboardType?? TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        hintStyle: widget.hintStyle ??
            TextStyle(
                color: context.theme.colorScheme.onSurface, fontSize: 16.sp),
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        fillColor: widget.backgroundColor ?? customBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: context.theme.colorScheme.error),
        ),
        filled: true,
      ),
      obscureText: widget.isObscureText ?? false,
      style: widget.inputTextStyle ??
          TextStyle(
              color: context.theme.colorScheme.onSurface, fontSize: 16.sp),
      validator: (value) {
        return widget.validator(value);
      },
    );
  }
}
