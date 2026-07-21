import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_size.dart';
import '../core/utils/app_text__styles.dart';

class CustomDropDown<T> extends StatelessWidget {
  final void Function(dynamic) onChange;
  final String? label;
  final String? hint;
  final T? value;
  final bool isEnabled;
  final Widget? prefixIcon;
  final bool isClearable;
  final List<DropdownMenuItem<T>> items;

  const CustomDropDown({
    super.key,
    required this.onChange,
    required this.items,
    this.prefixIcon,
    this.isClearable = false,
    this.isEnabled = true,
    this.label,
    this.hint,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      menuMaxHeight: 350,
      validator: (value) {
        if (value == null) {
          return "Required";
        }
        return null;
      },
      isExpanded: true,
      enableFeedback: false,

      selectedItemBuilder: (context) {
        return items.map((DropdownMenuItem<T> item) {
          return item.child;
        }).toList();
      },
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 25),

        prefixIcon: isClearable && value != null
            ? InkWell(
                child: Icon(Icons.clear, color: AppColors.red, size: 16),
                onTap: () => onChange(null),
              )
            : prefixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
        filled: true,
        fillColor: Colors.white,
        hoverColor: AppColors.white,
        labelText: label,
        hintText: hint,
        focusColor: AppColors.white,
        constraints: BoxConstraints(minHeight: getProportionateScreenHeight(35)),

        // ------------------ هنا التعديل الأساسي للـ Borders ------------------
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        // إضافة الـ errorBorder والـ focusedErrorBorder لتجنب اللون الأسود عند الخطأ
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey), // أو AppColors.red
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.grey),
        ),

        // ---------------------------------------------------------------------
        labelStyle: AppTextStyles.textstyle14_regular,
        enabled: isEnabled,
      ),
      onChanged: isEnabled ? onChange : null,
      items: items,
      value: value,
    );
  }
}
