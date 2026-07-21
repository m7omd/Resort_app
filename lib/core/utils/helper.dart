import 'package:easy_localization/easy_localization.dart';

import 'imports.dart';
import 'dart:math' as math;

// bottom sheet
void customBottomSheet({required context, required Widget widget}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    builder: (context) {
      return widget;
    },
  );
}

// alert dialog
void customAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  required String confirmText,
  required VoidCallback onConfirm,
  String? cancelText,
  VoidCallback? onCancel,
  Color confirmColor = Colors.blue,
  Color? cancelColor,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content:
            content != null
                ? Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                )
                : null,
        actions: [
          // Cancel button
          if (cancelText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (onCancel != null) {
                  onCancel();
                }
              },
              child: Text(cancelText),
            ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Trigger the confirm action
            },
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
