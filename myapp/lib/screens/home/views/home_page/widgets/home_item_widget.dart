import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';

// ignore: must_be_immutable
class HomeItemWidget extends StatelessWidget {
  HomeItemWidget({
    Key? key,
    this.navigateToUInfo,
  }) : super(
          key: key,
        );

  VoidCallback? navigateToUInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToUInfo!.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 8.v,
        ),
        decoration: AppDecoration.fillOrangeC.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle10,
              height: 48.v,
              width: 79.h,
              radius: BorderRadius.circular(
                6.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 13.h,
                top: 11.v,
                bottom: 11.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "University of Melbourne",
                    style: theme.textTheme.labelLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      "Inspiring Minds, Shaping Futures",
                      style: CustomTextStyles.bodySmallRobotoBlack900,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgSignal,
              height: 19.v,
              width: 20.h,
              margin: EdgeInsets.only(
                top: 15.v,
                right: 17.h,
                bottom: 13.v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
