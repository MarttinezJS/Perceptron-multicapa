import 'package:flutter/material.dart';
import 'package:perceptron_multicapa/src/models/error_model.dart';
import 'package:perceptron_multicapa/src/widgets/widgets.dart';

class ResultadoPage extends StatefulWidget {
  ResultadoPage({Key? key}) : super(key: key);

  @override
  _ResultadoPageState createState() => _ResultadoPageState();
}


class _ResultadoPageState extends State<ResultadoPage> {

  List<ErrorModel>listError = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PERCEPTRON MULTICAPA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu_open, size: 32,),
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height:20),
              GraficaError(errorModel: listError,)
            ],
          ),
        ),
      ),
    );
  }
}