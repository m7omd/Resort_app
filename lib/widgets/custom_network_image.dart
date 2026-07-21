import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double width, height, radius;
  final bool isProfileImage;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;

  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.width = 80,
    this.height = 80,
    this.radius = 50,
    this.isProfileImage = false,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final String effectiveImageUrl =
        imageUrl ??
        (isProfileImage
            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRao_0xQcdcOVK9S6UuSGjkQGy4j2uPsZ0Uug&usqp=CAU'
            : '');

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit,
        imageUrl: effectiveImageUrl,
        placeholder:
            (context, url) => const Center(
              child: SizedBox(
                height: 8,
                width: 8,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        // errorWidget: (context, url, error) => const Icon(Icons.error, size: 20),
        errorWidget:
            (context, url, error) => Container(
              // color: Colors.grey.shade200,
              child: const Icon(Icons.photo, size: 28, color: Colors.grey),
            ),
      ),
    );
  }
}
