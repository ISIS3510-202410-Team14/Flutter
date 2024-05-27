import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/core/app_export.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';



class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? formPath;
  String? motivationalLetterPath;
  String? familyLetterPath;
  String? formURL;
  String? motivationalLetterURL;
  String? familyLetterURL;
  double _uploadProgress = 0.0;
  bool _isUploading = false;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    loadFilePaths();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
        if (_isConnected) {
          uploadPendingFiles();
        }
      });
    });
  }

  Future<void> loadFilePaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      formPath = prefs.getString('formLocalPath');
      motivationalLetterPath = prefs.getString('motivationalLetterLocalPath');
      familyLetterPath = prefs.getString('familyLetterLocalPath');
      formURL = prefs.getString('formURL');
      motivationalLetterURL = prefs.getString('motivationalLetterURL');
      familyLetterURL = prefs.getString('familyLetterURL');
    });
  }

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
      if (_isConnected) {
        await uploadFile(filePath, documentType);
      } else {
        await saveFileLocally(filePath, documentType);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No internet connection. Your document will be uploaded when the connection is restored.'),
          ),
        );
      }
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
      await saveFilePath(documentType, fileURL, filePath);
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
      });
    });
  }

  Future<void> saveFileLocally(String filePath, String documentType) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = path.basename(filePath);
    final localFile = File('${directory.path}/$documentType/$fileName');
    await localFile.create(recursive: true);
    await localFile.writeAsBytes(await File(filePath).readAsBytes());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('$documentType-local', localFile.path);
    await prefs.setString('$documentType-local-path', localFile.path);
  }

  Future<void> uploadPendingFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final documentTypes = ['form', 'motivationalLetter', 'familyLetter'];

    for (var documentType in documentTypes) {
      final localFilePath = prefs.getString('$documentType-local');
      if (localFilePath != null) {
        await uploadFile(localFilePath, documentType);
        await prefs.remove('$documentType-local');
      }
    }
  }

  Future<void> removeFile(String documentType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fileURL;
    if (documentType == 'form') {
      fileURL = prefs.getString('formURL');
    } else if (documentType == 'motivationalLetter') {
      fileURL = prefs.getString('motivationalLetterURL');
    } else if (documentType == 'familyLetter') {
      fileURL = prefs.getString('familyLetterURL');
    }

    if (fileURL != null) {
      Reference storageReference = FirebaseStorage.instance.refFromURL(fileURL);
      await storageReference.delete();

      setState(() {
        if (documentType == 'form') {
          formPath = null;
          formURL = null;
        } else if (documentType == 'motivationalLetter') {
          motivationalLetterPath = null;
          motivationalLetterURL = null;
        } else if (documentType == 'familyLetter') {
          familyLetterPath = null;
          familyLetterURL = null;
        }
      });

      await prefs.remove(documentType == 'form' ? 'formURL' : documentType == 'motivationalLetter' ? 'motivationalLetterURL' : 'familyLetterURL');
      await prefs.remove(documentType == 'form' ? 'formLocalPath' : documentType == 'motivationalLetter' ? 'motivationalLetterLocalPath' : 'familyLetterLocalPath');
    }
  }

  Future<void> saveFilePath(String documentType, String fileURL, String localFilePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (documentType == 'form') {
      await prefs.setString('formURL', fileURL);
      await prefs.setString('formLocalPath', localFilePath);
    } else if (documentType == 'motivationalLetter') {
      await prefs.setString('motivationalLetterURL', fileURL);
      await prefs.setString('motivationalLetterLocalPath', localFilePath);
    } else if (documentType == 'familyLetter') {
      await prefs.setString('familyLetterURL', fileURL);
      await prefs.setString('familyLetterLocalPath', localFilePath);
    }
  }

  Widget uploadBox(String documentType, String? filePath, String title, String? fileURL) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => pickFile(documentType),
          child: Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    filePath == null ? 'Upload $title' : path.basename(filePath),
                    style: TextStyle(fontSize: 16),
                  ),
                  if (fileURL != null)
                    Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),
          ),
        ),
        if (fileURL != null)
          Column(
            children: [
              Text(
                'Your document is already uploaded.',
                style: TextStyle(color: Colors.green),
              ),
              ElevatedButton(
                onPressed: () => removeFile(documentType),
                child: Text('Remove $title'),
              ),
            ],
          ),
        if (filePath != null && fileURL == null)
          ElevatedButton(
            onPressed: () => removeFile(documentType),
            child: Text('Remove $title'),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            uploadBox('form', formPath, 'Filled Form', formURL),
            uploadBox('motivationalLetter', motivationalLetterPath, 'Motivational Letter', motivationalLetterURL),
            uploadBox('familyLetter', familyLetterPath, 'Family Letter', familyLetterURL),
          ],
        ),
      ),
    );
  }
}