import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/screens/uinfo/views/expansion_panel.dart';
import 'package:myapp/screens/uinfo/views/Requeriments_panel.dart';
import 'package:myapp/widgets/app_bar/custom_app_bar.dart';
import 'package:myapp/widgets/app_bar/appbar_leading_image.dart';
import 'package:university_repository/university_repository.dart';

import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';


class UinfoScreen extends StatefulWidget {
  final University university;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  UinfoScreen(this.university, {Key? key}) : super(key: key);

  @override
  _UinfoScreenState createState() => _UinfoScreenState();
}

class _UinfoScreenState extends State<UinfoScreen> {
  bool showRequirements = false;
  bool showExpansionPanel = true;

  @override
  Widget build(BuildContext context) {
    widget.analytics.logEvent(name: 'uinfo_screen_entered', parameters: {
      'university_id': widget.university.universityId,
    });
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            widget.analytics.logEvent(name: 'uinfo_screen_abandoned', parameters: {
              'university_id': widget.university.universityId,
            });
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xffffffff),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(1),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 17, 17, 17),
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(widget.university.image), // Changed to dynamic image URL
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20), // Add space above the text
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.university.name, // Changed to dynamic university name
                            style: theme.textTheme.titleMedium!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                widget.university.country,
                                style: theme.textTheme.titleMedium!.copyWith(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.analytics.logEvent(name: 'requirements_clicked', parameters: {
                      'university_id': widget.university.universityId,
                    });
                    setState(() {
                      showRequirements = true;
                      showExpansionPanel = false;
                    });
                  },
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup,
                        height: 31.v,
                        width: 30.h,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "Requirements",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showRequirements = false;
                      showExpansionPanel = true;
                    });
                  },
                  child: Column(
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
                          imagePath: ImageConstant.imgUniversity,
                          height: 26.v,
                          width: 23.h,
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "University Info",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
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
            Expanded(
              child: showRequirements
                  ? RequerimentsPanel()
                  : (showExpansionPanel ? AccordionPage() : Container()),
            ),
          ],
        ),
      ),
    );
  }
}