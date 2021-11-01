import 'package:flutter/material.dart';
import 'package:perceptron_multicapa/src/service/neurona_service.dart';

class ListaDatosPage extends StatefulWidget {

  @override
  _ListaDatosPageState createState() => _ListaDatosPageState();
}

class _ListaDatosPageState extends State<ListaDatosPage> {

  NeuronaService neuronaService = NeuronaService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          child: const Text('Simular'),
          onPressed: () async {
            neuronaService.simular({
              "inputs": [0.1,0.1,0.1]
            });
          },
        ),
      ),
    );
  }
}