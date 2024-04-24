import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    
    return Scaffold(
  
      body: Container(
        child: Container(
      height: 40, // Ajusta la altura según necesidad
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Find Your Exchange',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          border: InputBorder.none, // Elimina el borde subrayado del TextField
        ),
      ),
    ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


}
