import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_loading.dart'; // Ensure this file exists and has your loading indicator

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final AlignmentGeometry? alignment;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.padding,
    this.fit,
    this.borderRadius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 2.h, vertical: 6),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(14),
          child: SizedBox(
            height: height ?? 100.sp,
            width: width ?? 100.sp,
            child: GestureDetector(
              onTap: () {
                // Navigate to the full-screen image on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImageViewer(imageUrl: imageUrl),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                fit: fit ?? BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                  height: height ?? 100.sp,
                  width: width ?? 100.sp,
                  child:
                      myLoadingIndicator(context), // Custom loading indicator
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen image viewer widget
class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Interactive image for zooming and panning
          InteractiveViewer(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
          ),
          // Close button at the top-right corner
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
