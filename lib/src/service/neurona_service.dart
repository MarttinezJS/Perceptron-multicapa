import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:perceptron_multicapa/src/global/enviroment.dart';

class NeuronaService {
  
  NeuronaService();

  inicializarNeurona(data) async{
    print(jsonEncode(data));
    final res = await http.post(Uri.parse('${Enviroment.uri}/init'),
      body: jsonEncode(data)
    );
    // print(res.body);
  }

}