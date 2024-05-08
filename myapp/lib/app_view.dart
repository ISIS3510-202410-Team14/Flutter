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
import 'package:myapp/screens/uinfo/views/expansion_panel.dart';
import 'package:myapp/screens/uinfo/views/uiinfo_screen.dart';
import 'package:university_repository/university_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key});

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
      home: LayoutBuilder(
        builder: (context, constraints) {
          // Llama a setScreenSize antes de acceder a width
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
                    create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
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
