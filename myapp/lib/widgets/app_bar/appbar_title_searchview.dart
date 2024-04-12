import 'package:myapp/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  AppbarTitleSearchview({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        width: 360.h,
        controller: controller,
        hintText: "Find your exchange",
        autofocus:  false,
      ),
    );
  }
}
