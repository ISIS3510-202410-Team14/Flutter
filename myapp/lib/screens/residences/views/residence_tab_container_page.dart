import 'dart:convert';
import 'dart:io';
import 'package:myapp/widgets/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/screens/residences/get_residence_bloc/get_residence_bloc.dart';
import 'package:myapp/screens/home/views/home_page/home_page.dart';
import 'package:myapp/screens/search/searchpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:residence_repository/residence_repository.dart';  // Asegúrate de que la ruta es correcta
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class TabResidencePage extends StatefulWidget {
  const TabResidencePage({Key? key, required this.countriesToShow}) : super(key: key);
  final List<String> countriesToShow;

  @override
  TabResidencePageState createState() => TabResidencePageState();
}

class TabResidencePageState extends State<TabResidencePage> with TickerProviderStateMixin {
  
  
  late Trace userInteractionTrace;
  final ImageService _imageService = ImageService();
 

  @override
  void initState() {
    super.initState();
 // Iniciar el rastro cuando la vista se carga

  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarousel(context),
          ],
        ),
      ),
    );
  }


Widget _buildCarousel(BuildContext context) {
    return Column(
      children: widget.countriesToShow.map((country) => _buildCountryCarousel(context, country)).toList(),
    );
  }

Widget _buildCountryCarousel(BuildContext context, String country) {
    return BlocBuilder<GetResidenceBloc, GetResidenceState>(
      builder: (context, state) {
        if (state is GetResidenceSuccess) {
          var filteredResidences = state.residences.where((residence) => residence.country == country).toList();
          if (filteredResidences.isNotEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Text(country, style: CustomTextStyles.titleSmallPoppins),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 200, // Set a fixed height for the ListView
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 10.h, right: 16.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 8.h),
                      itemCount: filteredResidences.length,
                      itemBuilder: (context, index) {
                        String localFileName = 'uni_${filteredResidences[index].residenceId}.jpg';
                        return FutureBuilder<File>(
                          future: _imageService.loadImage(filteredResidences[index].image, localFileName),
                          builder: (context, snapshot) {
                            return _buildResidenceItem(snapshot, filteredResidences[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(); // Return an empty container if there are no residences
          }
        } else if (state is GetResidenceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("An error has occurred..."));
        }
      },
    );
  }





  Widget _buildResidenceItem(AsyncSnapshot<File> snapshot, Residence residence) {
    Widget imageWidget;
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      imageWidget = Image.file(snapshot.data!, fit: BoxFit.cover);
    } else if (snapshot.hasError || !snapshot.hasData) {
      imageWidget = Image.network(residence.image, fit: BoxFit.cover);
    } else {
      imageWidget = CircularProgressIndicator();
    }
    return Container(
      width: 149,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageWidget,
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
                  residence.name,
                  style: CustomTextStyles.titleMediumWhiteA700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
