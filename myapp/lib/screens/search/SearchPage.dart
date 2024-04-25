import 'dart:convert';
import 'package:university_repository/university_repository.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/UniversityInfo/view/uiinfo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/screens/home/blocs/get_university_bloc/get_university_bloc.dart';

class SearchPage extends StatefulWidget {

  const SearchPage( {Key? key}) : super(key: key);
  

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  Set<University> clickedUniversityNames = Set<University>();
  List<University> universities= [];

 @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView( // Permite que el contenido interior se desplace si es necesario
          child: _listaU(context, universities),
          ),
        );
  }





  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40,  // Ajusta la altura según necesidad
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: TextField(
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Find Your Exchange',
              icon: Icon(Icons.search, color: Colors.grey),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
          onChanged: searchUni,
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                                  print("Added to fav");
                                  });
                                  await saveToFavorites(universities[index]);
                                  },
                                child:CustomImageView(
                                  imagePath: ImageConstant.imgSignal,
                                  height: 19.v,
                                  width: 20.h,
                                  margin: EdgeInsets.only(top: 15.v, right: 17.h, bottom: 13.v),
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
    // Serializa la universidad a un string JSON y guárdalo.
    String universityJson = json.encode(university.toJson());
    favorites.add(universityJson);
    await prefs.setStringList('favorites', favorites);
}

Future<List<University>> loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> favorites = prefs.getStringList('favorites') ?? [];
  // Deserializa cada string JSON a un objeto University.
  return favorites.map((string) => University.fromJson(json.decode(string))).toList();
}

  void searchUni(String query) {
    final suggestions = universities.where((university) { 
      final uniName = university.name.toLowerCase();
      final input = query.toLowerCase();
      return uniName.contains(input);
    }).toList();

    setState(() => universities = suggestions);
  }
}
