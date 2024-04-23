import 'package:myapp/screens/uinfo/views/uiinfo_screen.dart';
import 'package:myapp/screens/home/blocs/get_university_bloc/get_university_bloc.dart';


import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_repository/university_repository.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
                // width: 412.h,
                decoration: AppDecoration.outlineErrorContainer,
                child: Column(children: [
                  SizedBox(height: 18.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: BlocBuilder<GetUniversityBloc, GetUniversityState>(
                        builder: (context, state) {
                          if(state is GetUniversitySuccess){
                            return ListView.separated(
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0.v),
                                      child: SizedBox(
                                          width: 108.h,
                                          ));
                                },
                                itemCount: state.universitys.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        navigateToUInfo(context, state.universitys[index]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.h,
                                          vertical: 8.v,
                                        ),
                                        decoration: AppDecoration.fillOrangeC.copyWith(
                                          borderRadius: BorderRadiusStyle.roundedBorder16,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 48,
                                              width: 79,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Image.network(
                                                state.universitys[index].image,
                                                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 13.h,
                                                top: 11.v,
                                                bottom: 11.v,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.universitys[index].name,
                                                    style: theme.textTheme.labelLarge,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 2.h),
                                                    child: Text(
                                                      state.universitys[index].description,
                                                      style: CustomTextStyles.bodySmallRobotoBlack900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            CustomImageView(
                                              imagePath: ImageConstant.imgSignal,
                                              height: 19.v,
                                              width: 20.h,
                                              margin: EdgeInsets.only(
                                                top: 15.v,
                                                right: 17.h,
                                                bottom: 13.v,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                });
                          } else if(state is GetUniversityLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                          } else {
                            return const Center(
                              child: Text(
                                "An error has occured..."
                              ),
                            );
                          }
                        }
                      )
                    )
                ])
          )
        )
      );
    }

  /// Navigates to the uinfoScreen when the action is triggered.
  navigateToUInfo(BuildContext context, University university) {
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UinfoScreen(university)),
            );
  }
}
