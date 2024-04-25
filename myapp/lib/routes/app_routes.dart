import 'package:flutter/material.dart';
import 'package:university_repository/university_repository.dart';

import '../screens/uinfo/views/uiinfo_screen.dart';
import '../screens/home/views/home_page/home_page.dart';
import '../screens/home/views/home_page/home_page.dart';
import '../screens/home/views/home_container_screen/home_container_screen.dart';
import '../screens/home/views/home_tab_container_page/home_tab_container_page.dart';
import '../screens/map/views/map_screen.dart';


class AppRoutes {

  static const String homePage = '/home_page'; 

  static const String uinfoScreen = '/uiinfo_screen';

  static const String homeContainerScreen = '/home_container_screen';
  
  static const String homeTabContainerPage = '/home_tab_container_page';

  static const String map = '/map_screen';

  static Map<String, WidgetBuilder> routes = {

    homeContainerScreen: (context) => HomeContainerScreen(),
    map: (context) => MapScreen(),

  };
}
