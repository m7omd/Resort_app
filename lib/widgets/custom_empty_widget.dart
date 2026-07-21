import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  final String message;
  // final String imageUrl;

  const EmptyScreen({
    super.key,
    required this.title,
    required this.message,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
           " AppAssets.emptyImage",
            height: 120,
            width: 120,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
