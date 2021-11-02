
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class DatosConvert extends ChangeNotifier{

  int nEntradas = 0;
  int nSalidas = 0;
  int nPatrones = 0;
  List<List<String>> entradas = [];
  List<List<String>> salidas = [];
  List<List<String>> _banco = [];


  DatosConvert(){
    cargarCSV();
  }

  cargarCSV() async {
    entradas.clear();
    salidas.clear();
    _banco.clear();
    nEntradas = 0;
    nSalidas = 0;
    FilePickerResult? picked;

    picked = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if( picked == null ) {
      return;
    }
    Uint8List? uploadfile = picked.files.first.bytes;
    _banco = const Utf8Decoder().convert(uploadfile!.toList()).split('\n').map((e) => e.split(',')).toList();
    print(_banco);
    _banco.removeAt(0).forEach((e) {
      if(e.toLowerCase().contains('y')){
        nSalidas++;
      }else{
        nEntradas++;
      }
    });
    nPatrones =  _banco.length;
    for (var e in _banco) {
      entradas.add(e.getRange(0, nEntradas).toList());
      salidas.add(e.getRange(nSalidas, _banco.length).toList());
    }

    notifyListeners();
  }
}