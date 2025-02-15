import 'dart:convert';
import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:qolbu/app/data/models/document_file_model.dart';

extension XFileExtension on XFile {
  String get fileName => name;

  File get file {
    var documentFile = File(path);
    return documentFile;
  }

  String get documentEncode => base64Encode(file.readAsBytesSync());

  String get fileType {
    var documentTypes = name.split(".");
    var documentType = documentTypes.last;
    return documentType;
  }

  DocumentFile get documentFile {
    return DocumentFile.request(
      name: fileName,
      file: documentEncode,
      fileType: fileType,
    );
  }
}

extension FileExtension on File {
  String get fileName {
    var name = path.split('/').lastOrNull ?? '';
    return name;
  }

  File get file {
    var documentFile = File(path);
    return documentFile;
  }

  String get documentEncode => base64Encode(file.readAsBytesSync());

  String get fileType {
    var documentTypes = fileName.split(".");
    var documentType = documentTypes.last;
    return documentType;
  }

  DocumentFile get documentFile {
    return DocumentFile.request(
      name: fileName,
      file: documentEncode,
      fileType: fileType,
    );
  }
}
