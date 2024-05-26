import 'package:flutter/material.dart';
import 'package:myapp/screens/upload/views/docsview.dart';


import '../screens/uinfo/views/uiinfo_screen.dart';
import '../screens/UChatbot/views/chatbot_screen.dart';
import '../screens/home/views/home_page/home_page.dart';
import '../screens/home/views/home_page/home_page.dart';
import '../screens/home/views/home_container_screen/home_container_screen.dart';
import '../screens/home/views/home_tab_container_page/home_tab_container_page.dart';
import '../screens/map/views/map_screen.dart';

import 'package:myapp/screens/home/views/home_page/home_page.dart';
import 'package:myapp/screens/home/views/home_container_screen/home_container_screen.dart';
import 'package:myapp/screens/home/views/home_tab_container_page/home_tab_container_page.dart';



import '../screens/home/views/home_container_screen/home_container_screen.dart';


import 'package:myapp/screens/search/searchpage.dart';

class AppRoutes {
  static const String homePage = '/home_page';
  static const String uinfoScreen = '/uiinfo_screen';
  static const String homeContainerScreen = '/home_container_screen';
  static const String homeTabContainerPage = '/home_tab_container_page';
  static const String chatbotScreen = '/chatbot_screen';
  static const String map = '/map_screen';
  static const String searchPage = '/search_page';
  static const String uploadScreen = '/upload_screen';
  static final Map<String, WidgetBuilder> routes = {
    homePage: (context) => HomePage(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    homeTabContainerPage: (context) => HomeTabContainerPage(),
    searchPage: (context) => SearchPage(),
    map: (context) => MapScreen(),
    chatbotScreen: (context) => ChatbotScreen(),
    uploadScreen: (context) => UploadScreen(),

  };
}
