import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:perceptron_multicapa/src/global/enviroment.dart';
import 'package:perceptron_multicapa/src/models/red_neuronal_model.dart';

class NeuronaService extends ChangeNotifier{
  
  RedNeurona _red = RedNeurona(errors: [], layers: [], numInputs: 0, numLayers: 0);

  RedNeurona get redNeuronal => _red;
  set redNeuronal(RedNeurona value){
    _red = value;
    notifyListeners();
  }

  NeuronaService(){
    getRed();
  }

  getRed() async {
    http.Response res;
    try {
      res = await http.get(Uri.parse('${Enviroment.uri}/'));
    } catch (e) {
      res = http.Response(e.toString(), 500);
    }

    return _neuronaResponse(res);
  }

  inicializarNeurona(data) async {

    http.Response res;
    try {
      res = await http.post(Uri.parse('${Enviroment.uri}/init'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );
    } catch (e) {
      res = http.Response(e.toString(), 500);
    }

    return _neuronaResponse(res);
  }

  entrenarNeurona(data) async {

    http.Response res;
    try {
      res = await http.post(Uri.parse('${Enviroment.uri}/fit'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );
    } catch (e) {
      res = http.Response(e.toString(), 500);
    }

    return _neuronaResponse(res);
  }

  simular(data) async {

    http.Response res;
    try {
      res = await http.patch(Uri.parse('${Enviroment.uri}/eval'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
      );
    } catch (e) {
      res = http.Response(e.toString(), 500);
    }

    return _neuronaResponse(res);
  }

  _neuronaResponse(http.Response res){
    if(res.statusCode == 200) {
      redNeuronal = neuronaResponseFromMap(res.body);
      return redNeuronal;
    }else{
      return false;
    }
  }



}