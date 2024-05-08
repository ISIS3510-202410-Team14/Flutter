import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:myapp/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:myapp/core/utils/size_utils.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/screens/home/views/home_container_screen/home_container_screen.dart';
import 'package:myapp/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:myapp/screens/auth/views/welcome_screen.dart';

import 'package:myapp/screens/search/SearchPage.dart';
import 'package:myapp/screens/home/views/home_tab_container_page/home_tab_container_page.dart';
import 'package:myapp/screens/home/blocs/get_university_bloc/get_university_bloc.dart';
import 'package:myapp/screens/map/views/map_screen.dart';
import 'package:myapp/screens/uinfo/views/expansion_panel.dart';
import 'package:myapp/screens/uinfo/views/uiinfo_screen.dart';
import 'package:university_repository/university_repository.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({Key? key}) : super(key: key);

  @override
  _MyAppViewState createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move On App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: Colors.orange,
          onPrimary: Colors.white,
        ),
      ),
      routes: AppRoutes.routes,
      home: _showSplash
          ? SplashScreen() // Your splash screen widget
          : LayoutBuilder(
              builder: (context, constraints) {
                // Call setScreenSize before accessing width
                SizeUtils.setScreenSize(
                  constraints,
                  MediaQuery.of(context).orientation,
                );

                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: ((context, state) {
                    if (state.status == AuthenticationStatus.authenticated) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => SignInBloc(
                              context.read<AuthenticationBloc>().userRepository,
                            ),
                          ),
                          BlocProvider(
                            create: (context) => GetUniversityBloc(
                              FirebaseUniversityRepo(),
                            )..add(GetUniversity()),
                          ),
                        ],
                        child: HomeContainerScreen(),
                        //child: HomeTabContainerPage(),
                      );
                    } else {
                      return WelcomeScreen();
                    }
                  }),
                );
              },
            ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set background color to orange
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/img_move_on.svg', // Path to your SVG asset
              height: 150, // Set the height here
              width: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Move On!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
