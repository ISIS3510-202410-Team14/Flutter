import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';

// ignore: must_be_immutable
class CarouselItemWidget extends StatelessWidget {
  const CarouselItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder28,
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgItem1,
          ),
          fit: BoxFit.cover,
        ),
      ),
      width: 149.h,
      child: Container(
        width: 149.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 15.v,
        ),
        decoration: AppDecoration.gradientWhiteAToBlack.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 154.v),
            Text(
              "USA",
              style: CustomTextStyles.titleMediumWhiteA700,
            ),
          ],
        ),
      ),
    );
  }
}
