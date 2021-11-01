import 'package:flutter/material.dart';
import 'package:perceptron_multicapa/src/page/resultado_page.dart';

import 'src/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perceptron Multicapa',
      initialRoute: 'resultado',
      routes: {
        'home' : ( _ ) => HomePage(),
        'resultado' : ( _ ) => ResultadoPage(),
      },
    );
  }
}