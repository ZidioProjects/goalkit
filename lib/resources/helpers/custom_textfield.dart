import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goalkit/resources/managers/string_manager.dart';


class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final Function(String?)? onChanged, onFieldSubmitted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;
  final Color? labelColor;
  final Color? hintTextColor;
  final Color? filledColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final FontWeight fontWeight;
  final int? maxLength;
  final bool filled;
  final bool autofocus;
  final TextStyle? style;
  final TextInputAction? textInputAction;

  const CustomTextField(
      {super.key,
      this.label,
      this.hintText,
      this.initialValue,
      this.prefixIcon,
      this.suffixIcon,
      this.textAlign,
      this.keyboardType,
      this.obscureText = false,
      this.filled = false,
      this.enabled = true,
      this.onFieldSubmitted,
      this.maxLines = 1,
      this.onChanged,
      this.controller,
      this.validator,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.onTap,
      this.inputFormatters,
      this.borderRadius,
      this.labelColor,
      this.hintTextColor,
      this.filledColor,
      this.borderColor,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.fontWeight = FontWeight.w400,
      this.labelText,
      this.maxLength,
      this.autofocus = false,
      this.style,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          label != null
              ? Text(
                  label ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: labelColor,
                    fontWeight: fontWeight,
                  ),
                )
              : const SizedBox.shrink(),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            autofocus: autofocus,
            initialValue: initialValue,
            maxLines: maxLines,
            enabled: enabled,
            textInputAction: textInputAction ?? TextInputAction.done,
            inputFormatters: inputFormatters,
            onFieldSubmitted: onFieldSubmitted,
            maxLength: maxLength,
            style: style ??
                TextStyle(
                  color: Colors.black,
                  fontWeight: fontWeight,
                  fontSize: 16,
                  letterSpacing: 0.4,
                  fontFamily: StringManager.fontFamily,
                ),
            autovalidateMode: autovalidateMode,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: hintTextColor,
                fontWeight: FontWeight.w400,
                fontFamily: StringManager.fontFamily,
                fontSize: 14,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              filled: filled,
              fillColor: filledColor ?? Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? const Color(0xFFE0E0E0),
                  width: 1,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: focusedBorderColor ?? const Color(0xFFE0E0E0),
                  width: 1,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(100),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor ?? const Color(0xFFE0E0E0),
                  width: 1,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(100),
              ),
            ),
            obscureText: obscureText,
            controller: controller,
            textAlign: textAlign ?? TextAlign.start,
            keyboardType: keyboardType,
            onSaved: onChanged,
            onChanged: onChanged,
            validator: validator,
            minLines: maxLines,
          ),
        ],
      ),
    );
  }
}
