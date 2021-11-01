import 'package:http/http.dart' as http;
import 'package:perceptron_multicapa/src/global/enviroment.dart';

class NeuronaService {
  

  inicializarNeurona(data) async{
    final res = await http.post(Uri.parse('${Enviroment.uri}/init'),
      body: data
    );
    print(res.body);
  }

}