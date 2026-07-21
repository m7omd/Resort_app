import 'package:flutter/material.dart';
import '../../core/utils/app_text__styles.dart';

void snackbarSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any existing snackbar

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      backgroundColor: Colors.green,
      content: Text(message, textAlign: TextAlign.center, ),
    ),
  );
}
