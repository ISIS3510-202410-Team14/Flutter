import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/core/app_export.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? formPath;
  String? motivationalLetterPath;
  String? familyLetterPath;
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  Future<void> pickFile(String documentType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.files.single.path!;
      setState(() {
        if (documentType == 'form') {
          formPath = filePath;
        } else if (documentType == 'motivationalLetter') {
          motivationalLetterPath = filePath;
        } else if (documentType == 'familyLetter') {
          familyLetterPath = filePath;
        }
      });
      await uploadFile(filePath, documentType);
    }
  }

  Future<void> uploadFile(String filePath, String documentType) async {
    String fileName = path.basename(filePath);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('documents/$documentType/$fileName');
    UploadTask uploadTask = storageReference.putFile(File(filePath));

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
      });
    });

    await uploadTask.whenComplete(() async {
      String fileURL = await storageReference.getDownloadURL();
      await saveFilePath(documentType, fileURL);
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
      });
    });
  }

  Future<void> saveFilePath(String documentType, String fileURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (documentType == 'form') {
      await prefs.setString('formURL', fileURL);
    } else if (documentType == 'motivationalLetter') {
      await prefs.setString('motivationalLetterURL', fileURL);
    } else if (documentType == 'familyLetter') {
      await prefs.setString('familyLetterURL', fileURL);
    }
  }

  Widget uploadBox(String documentType, String? filePath, String title) {
    return GestureDetector(
      onTap: () => pickFile(documentType),
      child: Container(
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            filePath == null ? 'Upload $title' : path.basename(filePath),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Image.asset(
            'assets/images/image.png',
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Text(
            'Move On Upload Documents',
            style: theme.textTheme.titleLarge!.copyWith(color: Colors.black),
          ),
          SizedBox(height: 16),
          if (_isUploading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(value: _uploadProgress),
            ),
          SizedBox(height: 16),
          uploadBox('form', formPath, 'Filled Form'),
          uploadBox('motivationalLetter', motivationalLetterPath, 'Motivational Letter'),
          uploadBox('familyLetter', familyLetterPath, 'Family Letter'),
        ],
      ),
    );
  }
}