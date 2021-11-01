import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:perceptron_multicapa/src/page/resultado_page.dart';

=======
import 'package:perceptron_multicapa/src/service/neurona_service.dart';
import 'package:perceptron_multicapa/src/utils/datos_convert.dart';
import 'package:provider/provider.dart';
>>>>>>> 08e2ca417e0c9f48f34c68a421ef587bb351cf73
import 'src/page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perceptron Multicapa',
      initialRoute: 'resultado',
      routes: {
        'home' : ( _ ) => HomePage(),
        'resultado' : ( _ ) => ResultadoPage(),
      },
=======
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
>>>>>>> 08e2ca417e0c9f48f34c68a421ef587bb351cf73
    );
  }
}