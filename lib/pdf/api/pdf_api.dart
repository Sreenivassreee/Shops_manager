import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }
  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
    print(url);
  }
  static Future<String> uploadFile(File file2,{path,date,CustomerMobile}) async {
    final url = file2.path;
    var downloadURL="";
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('/notes.txt');
    File file = File(url);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(path??"ErrorPath/"+CustomerMobile +date)
          .putFile(file).then((p) async => {
        downloadURL = await firebase_storage.FirebaseStorage.instance
         .ref(path??"ErrorPath/"+CustomerMobile +date)
         .getDownloadURL()
     });
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print(e);
      return "Error";
      // e.g, e.code == 'canceled'
    }
  }
}
