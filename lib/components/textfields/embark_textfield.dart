import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmbarkTextfield extends StatelessWidget {
  final String? labelText;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? errorBorder;
  final InputBorder? enabledborder;
  final InputBorder? focusedborder;
  final bool? obscureText;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final Color? color;
  final TextInputType? keyBoardType;
  final BorderRadiusGeometry? borderRadius;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final TextStyle? errorStyle;
  final InputBorder? focusedErrorBorder;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator? validator;
  const EmbarkTextfield({
    super.key,
    this.labelText,
    this.autovalidateMode,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.onSaved,
    this.suffixIcon,
    this.color,
    this.borderRadius,
    this.obscureText = false,
    this.controller,
    this.hintStyle,
    this.labelStyle,
    this.border,
    this.enabledborder,
    this.focusedborder,
    this.keyBoardType,
    this.errorStyle,
    this.focusedErrorBorder,
    this.errorBorder,
    this.inputFormatters,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: (borderRadius ?? BorderRadius.circular(30)) as BorderRadius,
      borderSide: BorderSide(color: Colors.grey.shade800, width: 0.5),
    );
    return TextFormField(
      autofocus: autofocus ?? false,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      obscureText: obscureText ?? false,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary,
      ),
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        errorMaxLines: 2,
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25)),
        errorBorder: errorBorder ??
            OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.circular(25)),
        errorStyle: errorStyle ??
            TextStyle(
              color: Colors.red.shade500,
              fontSize: 12,
            ),
        hintText: hintText,
        hintStyle:
            hintStyle ?? TextStyle(fontSize: 18, color: Colors.grey.shade600),
        labelText: labelText,
        labelStyle: labelStyle ??
            Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        border: border ?? defaultBorder,
        enabledBorder: enabledborder ?? defaultBorder,
        focusedBorder: focusedborder ??
            defaultBorder.copyWith(
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
      ),
    );
  }
}
