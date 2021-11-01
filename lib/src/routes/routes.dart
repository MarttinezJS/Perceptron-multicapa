import 'package:flutter/material.dart';
import 'package:perceptron_multicapa/src/page/entrenamiento/datos_entrenamiento.dart';
<<<<<<< HEAD
import 'package:perceptron_multicapa/src/page/resultado_page.dart';
import 'package:perceptron_multicapa/src/page/simulacion/listaDatos.dart';
=======
import 'package:perceptron_multicapa/src/page/simulacion/lista_datos.dart';
>>>>>>> 08e2ca417e0c9f48f34c68a421ef587bb351cf73


final pageRoute = <Rutas> [
  
  Rutas( icon: Icons.document_scanner_outlined, titulo: 'Entrenamiento', color: Colors.blue, page: DatosEntrenamientoPage()),
  Rutas( icon: Icons.download_rounded, titulo: 'Simulacion', color: Colors.green, page: ListaDatosPage()),
  Rutas( icon: Icons.download_rounded, titulo: 'resultado', color: Colors.black, page: ResultadoPage())


];


class Rutas {

  final IconData icon;
  final String titulo;
  final Color color;
  final Widget page;

  Rutas({required this.icon, required this.titulo, required this.color, required this.page});

}