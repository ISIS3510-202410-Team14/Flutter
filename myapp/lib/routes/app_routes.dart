import 'package:flutter/material.dart';
import '../UniversityInfo/view/uiinfo_screen.dart';


class AppRoutes {
 
  static const String uinfoScreen = '/uiinfo_screen';

  

  static Map<String, WidgetBuilder> routes = {

    uinfoScreen: (context) => UinfoScreen(),

  };
}
