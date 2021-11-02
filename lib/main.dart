import 'package:flutter/material.dart';
import 'package:perceptron_multicapa/src/service/neurona_service.dart';
import 'package:perceptron_multicapa/src/utils/datos_convert.dart';
import 'package:provider/provider.dart';
import 'src/page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatosConvert(), lazy: false,),
        ChangeNotifierProvider(create: (_) => NeuronaService(), lazy: false,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Perceptron Multicapa',
        initialRoute: 'home',
        routes: {
          'home' : ( _ ) => HomePage(),
        },
      ),
    );
  }
}