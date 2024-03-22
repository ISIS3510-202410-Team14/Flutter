import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/widgets/app_bar/custom_app_bar.dart';
import 'package:myapp/widgets/app_bar/appbar_leading_image.dart';

import '../../UniversityInfo/view/uiinfo_screen.dart';


class UReqScreen extends StatelessWidget {
  const UReqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.v),
              padding: EdgeInsets.symmetric(horizontal: 18.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 801.v,
                    width: 375.h,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: AppDecoration.fillWhiteA,
                            child: Container(
                              height: 18.v,
                              width: 375.h,
                              decoration: BoxDecoration(
                                color: appTheme.whiteA700,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 12.h,
                              right: 12.h,
                              bottom: 7.v,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildFortySeven(context),
                                SizedBox(height: 12.v),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 47.h,
                                    right: 22.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UinfoScreen(),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 30.adaptSize,
                                              width: 30.adaptSize,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.h,
                                                vertical: 2.v,
                                              ),
                                              decoration: AppDecoration.fillBluegray10001.copyWith(
                                                borderRadius: BorderRadiusStyle.roundedBorder16,
                                              ),
                                              child: CustomImageView(
                                                imagePath: ImageConstant.imgUniversity,
                                                height: 25.v,
                                                width: 19.h,
                                                alignment: Alignment.topLeft,
                                              ),
                                            ),
                                            SizedBox(height: 5.v),
                                            Text(
                                              "University Info",
                                              style: theme.textTheme.bodySmall!.copyWith(
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(flex: 49),
                                      Column(
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.imgGroup,
                                            height: 31.v,
                                            width: 30.h,
                                            onTap: () {
                                              onTapImgImage(context);
                                            },
                                          ),
                                          SizedBox(height: 3.v),
                                          Text(
                                            "Requirements",
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      Spacer(flex: 50),
                                      Column(
                                        children: [
                                          Container(
                                            height: 30.adaptSize,
                                            width: 30.adaptSize,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 3.h,
                                              vertical: 2.v,
                                            ),
                                            decoration: AppDecoration.fillBluegray10001.copyWith(
                                              borderRadius: BorderRadiusStyle.roundedBorder16,
                                            ),
                                            child: CustomImageView(
                                              imagePath: ImageConstant.imgGeography,
                                              height: 26.v,
                                              width: 23.h,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          SizedBox(height: 4.v),
                                          Text(
                                            "Internationalization",
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.v),
                                RequirementsChecklist(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.v),
                  SizedBox(width: 108.h, child: Divider()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 26.v,
        leadingWidth: 412.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVectorBlack900,
            margin: EdgeInsets.only(left: 35.h, right: 361.h),
            onTap: () {
              onTapVector(context);
            }));
  }

  /// Section Widget
  Widget _buildFortySeven(BuildContext context) {
    return SizedBox(
        height: 338.v,
        width: 349.h,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          CustomImageView(
              imagePath: ImageConstant.imgImage1,
              height: 318.v,
              width: 349.h,
              radius: BorderRadius.circular(15.h),
              alignment: Alignment.topCenter),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 276.v),
                  padding: EdgeInsets.symmetric(vertical: 11.v),
                  decoration: AppDecoration.fillBlueGray.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBL15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgLinkedin,
                            height: 28.v,
                            width: 22.h,
                            margin: EdgeInsets.only(top: 5.v, bottom: 4.v)),
                        Padding(
                            padding: EdgeInsets.only(bottom: 3.v),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("University of Melbourne",
                                      style: CustomTextStyles
                                          .bodyLargePoppinsGray900),
                                  Padding(
                                      padding: EdgeInsets.only(left: 9.h),
                                      child: Text(
                                          "Melbourne, Victoria, Australia",
                                          style: CustomTextStyles
                                              .bodySmallGray900))
                                ])),
                        CustomImageView(
                            imagePath: ImageConstant.imgContrast,
                            height: 20.v,
                            width: 17.h,
                            radius: BorderRadius.circular(8.h),
                            margin: EdgeInsets.only(top: 10.v, bottom: 7.v)),
                        Padding(
                            padding: EdgeInsets.only(top: 9.v, bottom: 16.v),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "5.0 ",
                                      style:
                                      CustomTextStyles.bodySmallff000000),
                                  TextSpan(
                                      text: "(99+ review)",
                                      style: CustomTextStyles.bodySmallff4b4949)
                                ]),
                                textAlign: TextAlign.left))
                      ])))
        ]));
  }

  /// Common widget
  Widget _buildSixtyEight(
      BuildContext context, {
        required String faculty,
      }) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(faculty,
              style: theme.textTheme.titleLarge!
                  .copyWith(color: appTheme.black900)),
          CustomImageView(
              imagePath: ImageConstant.imgShape,
              height: 5.v,
              width: 10.h,
              margin: EdgeInsets.only(top: 10.v, bottom: 14.v))
        ]);
  }

  /// Navigates back to the previous screen.
  onTapVector(BuildContext context) {
    Navigator.pop(context);
  }

  onTapImgImage(BuildContext context) {
    // TODO: implement Actions
  }
}


class RequirementsChecklist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, bool> requirements = {
      'Valid Passport': true,
      'Proof of English proficiency': false,
      'GPA > 4': false,
      'Health insurance': true,
      'Academic transcripts': true,
      'Visa': true,
      'Local language certificate': true,
    };

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: requirements.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Icon(
                    entry.value ? Icons.check : Icons.close,
                    color: entry.value ? Colors.green : Colors.red,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}