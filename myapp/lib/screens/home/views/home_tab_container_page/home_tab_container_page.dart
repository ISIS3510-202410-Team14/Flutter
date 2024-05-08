import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/screens/home/blocs/get_university_bloc/get_university_bloc.dart';
import 'package:myapp/screens/home/views/home_page/home_page.dart';
import 'package:myapp/screens/search/searchpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_repository/university_repository.dart';  // Asegúrate de que la ruta es correcta
import 'package:firebase_performance/firebase_performance.dart';

class HomeTabContainerPage extends StatefulWidget {
  const HomeTabContainerPage({Key? key}) : super(key: key);

  @override
  HomeTabContainerPageState createState() => HomeTabContainerPageState();
}

class HomeTabContainerPageState extends State<HomeTabContainerPage> with TickerProviderStateMixin {
  late TabController tabviewController;
  List<University> favoriteUniversities = [];
  late Trace userInteractionTrace;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 5, vsync: this);
    tabviewController.addListener(_handleTabSelection);
    userInteractionTrace = FirebasePerformance.instance.newTrace("tab_interaction_time");
    userInteractionTrace.start();  // Iniciar el rastro cuando la vista se carga
    loadFavorites().then((loadedFavorites) {
      setState(() {
        favoriteUniversities = loadedFavorites;
      });
    });
  }

  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildArchiveCoun(context),
            SizedBox(height: 26),
            _buildCarousel(context),
            SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text("Top Universities!", style: CustomTextStyles.titleSmallPoppins),
              ),
            ),
            SizedBox(height: 6),
            _buildTabview(context),
            _buildTabBarView(context, favoriteUniversities),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        child: Container(
          height: 40,  // Ajusta la altura según necesidad
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 10),
              Text('Find Your Exchange', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
    );
  }



  Widget _buildArchiveCoun(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.h, right: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLinkedin,
            height: 28.v,
            width: 23.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 7.h, top: 4.v, bottom: 5.v),
            child: Text(
              "Countries",
              style: theme.textTheme.labelLarge,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.v),
            child: Text(
              "See all",
              style: CustomTextStyles.labelMediumOrange700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return SizedBox(
      height: 210.v,
      child: BlocBuilder<GetUniversityBloc, GetUniversityState>(
        builder: (context, state) {
          if (state is GetUniversitySuccess) {
            return ListView.separated(
              padding: EdgeInsets.only(left: 10.h, right: 16.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8.h),
              itemCount: state.universitys.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 149,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        state.universitys[index].image,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        decoration: AppDecoration.gradientWhiteAToBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder28,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              state.universitys[index].country,
                              style: CustomTextStyles.titleMediumWhiteA700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GetUniversityLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("An error has occurred..."),
            );
          }
        },
      ),
    );
  }

  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 18.v,
      width: 379.h,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.orange700,
        unselectedLabelColor: appTheme.black900,
        tabs: [
          Tab(child: Text("All")),
          Tab(child: Text("Popular")),
          Tab(child: Text("Recom")),
          Tab(child: Text("Viewed")),
          Tab(child: Text("Fav")),
        ],
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context, List<University> favoriteUniversities) {
    return SizedBox(
      height: 275.v,
      child: TabBarView(
        controller: tabviewController,
        children: [
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(universityList: favoriteUniversities),
        ],
      ),
    );
  }

  Future<List<University>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    // Utiliza un Set para eliminar duplicados.
    Set<University> uniqueFavorites = {};
    for (String string in favorites) {
      uniqueFavorites.add(University.fromJson(json.decode(string)));
    }
    // Convierte el Set a una lista antes de devolverla.
    return uniqueFavorites.toList();
  }


 void _handleTabSelection() {
    if (tabviewController.indexIsChanging) {
      userInteractionTrace.stop();  // Detener y enviar el rastro cuando se selecciona una pestaña
    }
  }
}
