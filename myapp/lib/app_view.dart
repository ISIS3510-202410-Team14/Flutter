import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:myapp/screens/auth/views/welcome_screen.dart';
import 'package:myapp/screens/home/views/home_screen.dart';

import 'package:myapp/home/view/home_tab_container_page/home_tab_container_page.dart';
import 'package:myapp/screens/home/blocs/get_university_bloc.dart';
import 'package:university_repository/university_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Move On App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.light(background: Colors.grey.shade200, onBackground: Colors.black, primary: Colors.blue, onPrimary: Colors.white)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  //BlocProvider(
                    //create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
                  //),
                  BlocProvider(
                    create: (context) => GetUniversityBloc(
                      FirebaseUniversityRepo()
                      )..add(GetUniversity()),
                    ),
                ], 
                child: HomeTabContainerPage(),
                );
            } else {
              return HomeTabContainerPage();
            }
          }),
        ));
  }
}