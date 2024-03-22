import 'package:myapp/UniversityInfo/view/uiinfo_screen.dart';

import 'widgets/home_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: 412.h,
                decoration: AppDecoration.outlineErrorContainer,
                child: Column(children: [
                  SizedBox(height: 18.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0.v),
                                child: SizedBox(
                                    width: 108.h,
                                    ));
                          },
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return HomeItemWidget(navigateToUInfo: () {
                              navigateToUInfo(context);
                            });
                          }))
                ]))));
  }

  /// Navigates to the uinfoScreen when the action is triggered.
  navigateToUInfo(BuildContext context) {
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UinfoScreen()),
            );
  }
}
