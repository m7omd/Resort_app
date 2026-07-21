import 'package:flutter/material.dart';

import '../../core/utils/app_text__styles.dart';

void snackbarError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any existing snackbar

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.down,
      backgroundColor: Colors.red,
      content: Text(
        errorMessage,
      ),
    ),
  );
}
