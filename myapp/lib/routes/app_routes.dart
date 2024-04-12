import 'package:flutter/material.dart';
import 'package:university_repository/university_repository.dart';
import '../home/view/home_page/home_page.dart';
import '../UniversityInfo/view/uiinfo_screen.dart';
import '../home/view/home_container_screen/home_container_screen.dart';
import '../home/view/home_tab_container_page/home_tab_container_page.dart';


class AppRoutes {

  static const String homePage = '/home_page'; 

  static const String uinfoScreen = '/uiinfo_screen';

  static const String homeContainerScreen = '/home_container_screen';
  
  static const String homeTabContainerPage = '/home_tab_container_page';

  static Map<String, WidgetBuilder> routes = {

    homeContainerScreen: (context) => HomeContainerScreen(),

  };
}
