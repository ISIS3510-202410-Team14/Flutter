import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/placeholder_image.png'),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileItem('Name', 'John Doe'),
            _buildProfileItem('Email', 'john.doe@example.com'),
            _buildProfileItem('University', 'Sample University'), // Añade el nombre de la universidad del usuario
            _buildProfileItem('GPA', '3.8'), // Añade el GPA del usuario
            SizedBox(height: 20),
            _buildProfileButton(context, 'Edit Profile', () {
              // Agrega la lógica de navegación a la pantalla de edición de perfil
            }),
            _buildProfileButton(context, 'Sign Out', () {
              // Agrega la lógica de cierre de sesión
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, String label, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Reducir el espacio horizontal
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.orange,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white), // Establece el color del texto en blanco
        ),
      ),
    );
  }
}
