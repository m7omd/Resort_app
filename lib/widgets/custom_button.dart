import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color? color, titleColor, borderColor;
  final List<Color>? colors;
  final Widget widget;
  final double height, width, titleSize, radius;
  final EdgeInsetsGeometry? margin;
  final bool isWidthInfinity;
  final bool isLoading;
  final bool isEnabled;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.color,
    this.isEnabled = true,
    this.titleColor = Colors.black,
    this.widget = const SizedBox(),
    this.height = 56,
    this.width = double.infinity,
    this.colors,
    this.margin,
    this.borderColor,
    this.titleSize = 16,
    this.isWidthInfinity = true,
    this.isLoading = false,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? AppColors.primary,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      width: isWidthInfinity ? width : null,
      height: height,
      child: MaterialButton(
        onPressed: isEnabled ? onPressed : null,
        padding: EdgeInsets.zero,
        disabledColor: AppColors.darkGrey,
        disabledTextColor: AppColors.white,
        visualDensity: VisualDensity(horizontal: -4),
        minWidth: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            const SizedBox(width: 5),
            isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                  )
                : Text(
                    title.tr(),
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.fade,
                      color: titleColor,
                      fontFamily: 'SegoeUI',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
