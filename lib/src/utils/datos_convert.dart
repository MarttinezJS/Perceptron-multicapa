
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class DatosConvert extends ChangeNotifier{

  int nEntradas = 0;
  int nSalidas = 0;
  int nPatrones = 0;
  List<String> entradas = [];
  List<String> salidas = [];


  DatosConvert();

  cargarCSV() async {
    FilePickerResult? picked;

    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if( picked == null ) {
      return;
    }
    Uint8List? uploadfile = picked.files.first.bytes;
    final banco = const Utf8Decoder().convert(uploadfile!.toList()).split('\n').map((e) => e.split(',')).toList();

    banco.removeAt(0).forEach((e) {
      if(e.toLowerCase().contains('y')){
        nSalidas++;
      }else{
        nEntradas++;
      }
    });

    for (var e in banco) {
      entradas = entradas.followedBy(e.getRange(0, nEntradas)).toList();
      salidas = salidas.followedBy(e.getRange(nSalidas, banco.length)).toList();
    }

    notifyListeners();
  }
}