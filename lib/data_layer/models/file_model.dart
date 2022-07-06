import 'dart:io';

import 'package:dio/dio.dart';

class FilesModel {
  FilesModel({
    File? file,
  }) {
    _file = file;
  }

  File? _file;

  MultipartFile? get multiPartFile {
    if (_file != null) {
      return MultipartFile.fromFileSync(_file!.path,
          filename: _file!.path.split('/').last);
    }
    return null;
  }

  File? get file => _file;

  set file(File? file) {
    _file = file;
  }
}
