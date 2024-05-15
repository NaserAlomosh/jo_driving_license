import 'package:flutter/material.dart';

import '../../constants/image_path.dart';
import 'custom_text.dart';

class ImageNotFoundWidget extends StatelessWidget {
  const ImageNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImage.imageNotFound,
            fit: BoxFit.cover,
            color: const Color.fromARGB(255, 205, 14, 0),
          ),
          const CustomText(text: 'text'),
        ],
      ),
    );
  }
}
