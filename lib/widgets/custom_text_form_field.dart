import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CustomTextFormField extends StatefulWidget {
  /// Behavior
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool readOnly;
  final bool isPassword;
  final bool autoGrow;        // يتمدّد تلقائيًا (TextArea)
  final int? minLines;        // أقل عدد سطور عند الـ autoGrow
  final int? maxLines;        // استخدمه لتثبيت عدد السطور (لو autoGrow=false)
  final int? maxLength;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  /// Layout
  final EdgeInsetsGeometry? contentPadding;
  final bool dense;           // ارتفاع أقل للحقل الأحادي السطر
  final double? height;       // لتثبيت ارتفاع الحقل (أحادي السطر)

  /// Decoration
  final String? labelText;
  final String? hintText;
  final String? prefixText;

  /// Icons
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final VoidCallback? onSuffixPressed;

  /// Border
  final double borderRadius;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? disabledBorderColor;
  final Color? fillColor;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.readOnly = false,
    this.isPassword = false,
    this.autoGrow = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.contentPadding,
    this.dense = false,
    this.height,
    this.labelText,
    this.hintText,
    this.prefixText,
    this.prefix,
    this.suffix,
    this.prefixIconData,
    this.suffixIconData,
    this.onSuffixPressed,
    this.borderRadius = 8,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.disabledBorderColor,
    this.fillColor,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMultiline = widget.autoGrow || ((widget.maxLines ?? 1) > 1);

    // اختيارات الأكشن حسب نوع الإدخال
    final TextInputAction? action = isMultiline
        ? TextInputAction.newline
        : (widget.textInputAction ?? TextInputAction.done);

    // زر إظهار/إخفاء الباسورد إن لزم
    Widget? computedSuffix = widget.suffix;
    if (widget.isPassword) {
      computedSuffix = IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        tooltip: _obscure ? 'Show' : 'Hide',
      );
    } else if (widget.onSuffixPressed != null && widget.suffixIconData != null) {
      computedSuffix = IconButton(
        onPressed: widget.onSuffixPressed,
        icon: Icon(widget.suffixIconData),
      );
    } else if (computedSuffix == null && widget.suffixIconData != null) {
      computedSuffix = Icon(widget.suffixIconData);
    }

    final Widget? computedPrefix =
        widget.prefix ?? (widget.prefixIconData != null ? Icon(widget.prefixIconData) : null);

    final input = TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      keyboardType: isMultiline ? TextInputType.multiline : widget.keyboardType,
      textInputAction: action,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      obscureText: _obscure,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,

      // التحكم في السطور:
      minLines: widget.autoGrow ? (widget.minLines ?? 1) : widget.minLines,
      maxLines: widget.autoGrow ? null : widget.maxLines,

      decoration: InputDecoration(
        isDense: widget.dense,
        filled: true,
        fillColor: widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor ?? Colors.white,
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixText: widget.prefixText,
        prefixIcon: computedPrefix,
        suffixIcon: computedSuffix,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 14,
              vertical: isMultiline ? 12 : (widget.dense ? 8 : 12),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.enabledBorderColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.focusedBorderColor ?? Theme.of(context).colorScheme.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.disabledBorderColor ?? Colors.grey.shade400),
        ),
      ),
    );

    // لو عايز تثبّت ارتفاع معين في وضع سطر واحد
    if (!isMultiline && widget.height != null) {
      return ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: widget.height),
        child: Center(child: input),
      );
    }

    return input;
  }
}
