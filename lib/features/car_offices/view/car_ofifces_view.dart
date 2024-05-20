import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_driving_license/core/constants/dimentions.dart';
import 'package:jo_driving_license/core/widgets/general/custom_text.dart';

class CarOfficesView extends StatelessWidget {
  const CarOfficesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GeneralConst.horizontalPadding,
          vertical: 20.h,
        ),
        child: GridView.builder(
          itemCount: 7,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return CarOfficeItem();
          },
        ),
      ),
    );
  }
}

class CarOfficeItem extends StatelessWidget {
  const CarOfficeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_taxi),
          Row(
            children: [
              const Icon(Icons.label_important_outline),
              CustomText(
                text: 'Training centre',
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              CustomText(
                text: 'Sport city',
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
