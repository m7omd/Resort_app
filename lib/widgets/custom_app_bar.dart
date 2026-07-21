import 'package:flutter/material.dart';
import 'package:resort_app/core/utils/app_colors.dart';

import '../config/routes/app_router.dart';
import '../core/utils/app_size.dart';
import '../core/utils/app_text__styles.dart';
import '../core/utils/imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const CustomAppBar({super.key, required this.title, this.showBack = false});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,

      // titleSpacing: -4,
      leading: showBack
          ? IconButton(
              padding: EdgeInsets.zero,
              color: Colors.black,
              onPressed: () => GoRouter.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: getProportionateScreenHeight(24),
                color: AppColors.white,
              ),
            )
          : SizedBox.shrink(),

      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
      ),
      actionsPadding: EdgeInsets.zero,
    );
  }
}
