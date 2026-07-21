import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AppConstant {
  static void showErrorDialog({required BuildContext context, required String msg}) {
    showDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(msg, style: const TextStyle(color: Colors.black, fontSize: 16)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                child: const Text('Ok'),
              ),
            ],
          ),
    );
  }

  static void showSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static String formatTime({DateTime? dateTime}) {
    return DateFormat.jms().format(dateTime ?? DateTime.now());
  }

  static String formatDate({DateTime? dateTime}) {
    return DateFormat.yMMMEd().format(dateTime ?? DateTime.now());
  }

}
