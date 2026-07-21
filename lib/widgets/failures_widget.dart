import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resort_app/widgets/show_dialog.dart';

import '../config/routes/app_router.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/app_text__styles.dart';
import 'custom_button.dart';

class FailuresWidget extends StatefulWidget {
  final String errorMessage;
  final void Function()? onPressed;
  final bool viewIcon;
  const FailuresWidget({super.key, required this.errorMessage, this.onPressed, this.viewIcon = true});

  @override
  State<FailuresWidget> createState() => _FailuresWidgetState();
}

class _FailuresWidgetState extends State<FailuresWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.errorMessage == 'Unauthorized') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowDialog.showMyDialog(
          dismissible: false,
          context: context,
          widget: const SizedBox(),
          title: "sessionExpired",
          subtitle: "sessionExpiredMsg",
          bottons: [
            CustomButton(
              margin: const EdgeInsets.all(6),
              width: SizeConfig.screenWidth * .35,
              onPressed: () {
                // CacheHelper().deleteCache();
                // refreshMessagesToken();
                // GoRouter.of(context).pushReplacement(AppRouter.kStartView);
              },
              title: "OK",
            ),
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.errorMessage == 'No internet Connection' && widget.viewIcon)
            Icon(Icons.wifi_off_outlined, size: 120, color: AppColors.grey),
          Text(
            widget.errorMessage,
            // style: AppTextStyles.errorMessage.copyWith(),
          ),
          const SizedBox(height: 20),
          if (widget.onPressed != null)
            CustomButton(height: 35, width: 160, onPressed: widget.onPressed, title: "refresh"),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
