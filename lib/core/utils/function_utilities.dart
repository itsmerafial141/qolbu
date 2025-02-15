import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class AppFunctions {
  AppFunctions._();
  static Future<String> createFileFromString({
    required String base64file,
    required String extension,
  }) async {
    Uint8List bytes = base64.decode(base64file);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
      "$dir/${DateTime.now().millisecondsSinceEpoch}.$extension",
    );
    await file.writeAsBytes(bytes);
    return file.path;
  }

  static Future<String> createFileFromUint8List({
    required Uint8List unit8List,
    required String extension,
  }) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
      "$dir/${DateTime.now().millisecondsSinceEpoch}.$extension",
    );
    await file.writeAsBytes(unit8List);
    return file.path;
  }
}
