import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/screens/home/blocs/get_university_bloc/get_university_bloc.dart';
import 'package:myapp/screens/uinfo/views/uiinfo_screen.dart';
import 'package:university_repository/university_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.universityList}) : super(key: key);
  final List<University>? universityList;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {

  Set<University> clickedUniversityNames = Set<University>();
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<University> universities = widget.universityList ?? [];
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // Permite que el contenido interior se desplace si es necesario
          child: BlocBuilder<GetUniversityBloc, GetUniversityState>(
            builder: (context, state) {
              if (universities.length != 0){
                return _listaU(context, universities);
              } else{
                if (state is GetUniversitySuccess) {
                universities = state.universitys;
                return _listaU(context, universities);
              } else if (state is GetUniversityLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text("An error has occurred..."));
              }
              }

              
            },
          ),
        ),
      ),
    );
  }

  void navigateToUInfo(BuildContext context, University university) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UinfoScreen(university)),
    );
  }

  Widget _listaU(BuildContext context, List<University> universities){
    return Column(
                  children: [
                    SizedBox(height: 18.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento propio del ListView
                        shrinkWrap: true, // Permite que ListView ocupe solo el espacio de sus hijos
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0.v),
                          child: SizedBox(width: 108.h),
                        ),
                        itemCount: universities.length,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.v),
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
                                child:GestureDetector(
                                        onTap: () => navigateToUInfo(context, universities[index]), 
                                        child: Image.network(
                                  universities[index].image,
                                  fit: BoxFit.cover,
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 13.h, top: 11.v, bottom: 11.v),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => navigateToUInfo(context, universities[index]),
                                      child: Text(
                                        universities[index].name,
                                        style: theme.textTheme.labelLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.h),
                                      child: GestureDetector(
                                        onTap: () => navigateToUInfo(context, universities[index]),
                                        child: Text(
                                          universities[index].description,
                                          style: CustomTextStyles.bodySmallRobotoBlack900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                  setState(() {
                                  clickedUniversityNames.add(universities[index]);
                                  
                                  });
                                  await saveToFavorites(universities[index]);
                                  },
                                child:CustomImageView(
                                  imagePath: ImageConstant.imgSignal,
                                  height: 19.v,
                                  width: 20.h,
                                  margin: EdgeInsets.only(top: 15.v, bottom: 13.v),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    ),
                  ],
                );

  }
  Future<void> saveToFavorites(University university) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> favorites = prefs.getStringList('favorites') ?? [];
  
  // Deserializa las universidades para verificar duplicados por ID.
  List<University> favoriteUniversities = favorites.map((string) => University.fromJson(json.decode(string))).toList();
  
  // Verifica si la universidad ya está en favoritos.
  bool isAlreadyFavorite = favoriteUniversities.any((u) => u.universityId == university.universityId);
  
  if (!isAlreadyFavorite) {
    // Serializa la universidad a un string JSON y agrégalo si no está duplicado.
    String universityJson = json.encode(university.toJson());
    favorites.add(universityJson);
    await prefs.setStringList('favorites', favorites);
    print('University with ID ${university.universityId} will be added in the favorites list.');
  }
  else {
    // Imprime un mensaje en la consola si la universidad ya está en favoritos.
    print('University with ID ${university.universityId} is already in the favorites list and will not be added again.');
  }
}


Future<List<University>> loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> favorites = prefs.getStringList('favorites') ?? [];
  // Deserializa cada string JSON a un objeto University.
  return favorites.map((string) => University.fromJson(json.decode(string))).toList();
}

}
