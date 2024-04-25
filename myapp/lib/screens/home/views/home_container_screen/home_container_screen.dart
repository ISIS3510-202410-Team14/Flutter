import 'package:flutter/material.dart';
import 'package:myapp/screens/home/views/home_tab_container_page/home_tab_container_page.dart';
import 'package:myapp/screens/search/SearchPage.dart';
import 'package:myapp/widgets/custom_bottom_bar.dart';
import 'package:myapp/core/app_export.dart';

class HomeContainerScreen extends StatefulWidget {
  HomeContainerScreen({Key? key}) : super(key: key);

  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          initialRoute: AppRoutes.homeTabContainerPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => Directionality(
              textDirection: TextDirection.ltr, 
              child: _getCurrentPage(routeSetting.name!)
              ) ,
            transitionDuration: Duration(seconds: 0)
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      )
    );
  }

  Widget _buildBottomBar() {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      setState(() {
        _navigatorKey.currentState!.pushNamed(_getCurrentRoute(type));
      });
    });
  }

  String _getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Homegray5001:
        return AppRoutes.homeTabContainerPage;
      case BottomBarEnum.Locationon:
        return AppRoutes.searchPage; // Assuming there is a location page
      case  BottomBarEnum.Documentscanner:
        return AppRoutes.searchPage; // Assuming there is a document scanner page
      case BottomBarEnum.Lock:
        return AppRoutes.searchPage; // Assuming there is a lock page
      default:
        return AppRoutes.homeTabContainerPage;
    }
  }

  Widget _getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeTabContainerPage:
        return HomeTabContainerPage();
      case AppRoutes.searchPage:
        return SearchPage();
      // Add other cases as necessary
      default:
        return DefaultWidget(); // Default to home page if no match is found
    }
  }
}
