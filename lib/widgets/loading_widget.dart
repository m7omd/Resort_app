import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({super.key, this.color});
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Center(child: SpinKitRipple(color: AppColors.primary,));
    } else if (Platform.isIOS) {
      return const Center(child: CupertinoActivityIndicator());
    }
    return Center(child: SpinKitRipple(color: AppColors.primary,));
  }
}
