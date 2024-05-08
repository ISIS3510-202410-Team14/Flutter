// image_service.dart
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class ImageService {
  final Map<String, File> _cache = {};

  Future<File> downloadAndStoreImage(String imageUrl, String fileName) async {
    if (_cache.containsKey(fileName)) {
      return _cache[fileName]!;
    }
    var response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      _cache[fileName] = file;  // Guarda en caché
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }

   Future<File> loadImage(String imageUrl, String fileName) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File localFile = File('${dir.path}/$fileName');

    if (await localFile.exists()) {
      return localFile;
    } else {
      return await downloadAndStoreImage(imageUrl, fileName);
    }
  }
}
