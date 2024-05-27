import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import '../../auth/views/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserRepository userRepository = FirebaseUserRepo();
  late MyUser _localUser;

  @override
  void initState() {
    super.initState();
    _loadLocalUser();
  }

  Future<void> _loadLocalUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId') ?? '';
      final name = prefs.getString('name') ?? '';
      final email = prefs.getString('email') ?? '';
      final gpa = prefs.getDouble('gpa') ?? 0.0;
      final certificateEnglish = prefs.getBool('certificateEnglish') ?? false;
      setState(() {
        _localUser = MyUser(
          userId: userId,
          name: name,
          email: email,
          gpa: gpa,
          certificateEnglish: certificateEnglish,
        );
      });
    } catch (e) {
      print('Error loading local user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyUser?>(
      stream: userRepository.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final user = snapshot.data ?? _localUser;
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
                  _buildProfileItem('Name', user.name),
                  _buildProfileItem('Email', user.email),
                  _buildProfileItem('English Certificate', user.certificateEnglish.toString()),
                  _buildProfileItem('GPA', user.gpa.toString()),
                  SizedBox(height: 20),
                  _buildProfileButton(context, 'Edit Profile', () {
                    _editProfile(context, user);
                  }),
                  _buildProfileButton(context, 'Sign Out', () {
                    _signOut(context);
                  }),
                ],
              ),
            ),
          );
        }
      },
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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.orange,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void _editProfile(BuildContext context, MyUser? user) {
    final _nameController = TextEditingController(text: _localUser.name);
    final _gpaController = TextEditingController(text: _localUser.gpa.toString());
    bool _certificateEnglish = _localUser.certificateEnglish;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Edit Profile'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: _gpaController,
                      decoration: InputDecoration(labelText: 'GPA'),
                    ),
                    CheckboxListTile(
                      title: Text('English Certificate'),
                      value: _certificateEnglish,
                      onChanged: (value) {
                        setState(() {
                          _certificateEnglish = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _saveProfile(context, _localUser.userId, _nameController, _gpaController, _certificateEnglish);
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _saveProfile(BuildContext context, String userId, TextEditingController _nameController,
      TextEditingController _gpaController, bool _certificateEnglish) async {
    try {
      final updatedUser = MyUser(
        userId: userId,
        name: _nameController.text,
        email: _localUser.email, // No cambia el email
        gpa: double.tryParse(_gpaController.text) ?? 0.0,
        certificateEnglish: _certificateEnglish,
      );
      await userRepository.setUserData(updatedUser); // Aquí actualizamos la información en Firebase
      setState(() {
        _localUser = updatedUser; // Actualizamos la información local
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      print('Error during profile update: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }
  }


  void _signOut(BuildContext context) {
    try {
      // Borrar datos de usuario local al cerrar sesión
      final prefs = SharedPreferences.getInstance();
      prefs.then((prefs) {
        prefs.remove('userId');
        prefs.remove('name');
        prefs.remove('gpa');
        prefs.remove('certificateEnglish');
      });
      userRepository.logOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false,
      );
    } catch (e) {
      print('Error during sign out: $e');
    }
  }
}
