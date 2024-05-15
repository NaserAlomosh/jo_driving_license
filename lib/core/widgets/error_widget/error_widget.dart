import 'package:flutter/material.dart';

import '../../constants/image_path.dart';
import '../../helper/spacing.dart';
import '../general/custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? msg;
  final bool removePadding;
  const CustomErrorWidget({
    super.key,
    this.onPressed,
    this.msg,
    this.removePadding = false,
  });
  @override
  Widget build(BuildContext context) {
    // showErrorSnakbar(context, msg: msg);
    return Center(
      child: Column(
        children: [
          removePadding
              ? const SizedBox.shrink()
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
          Image.asset(
            AppImage.error,
            height: 50,
            width: 50,
          ),
          heightSpace(20),
          CustomText(text: msg ?? 'Cheak your intenet'),
          IconButton(
            onPressed: onPressed,
            icon: Image.asset(
              AppImage.tryAgain,
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
