
import 'package:flutter/material.dart';

import 'package:perceptron_multicapa/src/models/error_model.dart';
import 'package:perceptron_multicapa/src/service/neurona_service.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';


class GraficaError extends StatelessWidget {

  final List<double> errorGrafica;

  const GraficaError({Key? key, required this.errorGrafica}) : super(key: key); 

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.8,
        height: size.height*0.6,
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Grafica de Error'
          ),
          legend: Legend(isVisible: true),
          series: <LineSeries>[
            LineSeries<double, double>(
              dataSource: errorGrafica,
              xValueMapper: (  errorGrafica, contador) => contador.toDouble(),
              yValueMapper: ( errorGrafica, _) => errorGrafica,
              dataLabelSettings: DataLabelSettings(isVisible: true,),
            ),
          ],
          primaryXAxis: CategoryAxis(),
        ),
      ),
    );
  }
}




// class GraficaError extends StatefulWidget {

//   const GraficaError({Key? key}) : super(key: key);


//   @override
//   _GraficaErrorState createState() => _GraficaErrorState();
// }

// class _GraficaErrorState extends State<GraficaError> {

//   List<ErrorModel> _error = [];

//   NeuronaService neuronalservice = NeuronaService();

//   @override
//   Widget build(BuildContext context) {
    
//     neuronalservice = Provider.of<NeuronaService>(context);

//     final List<double> errorGrafica = neuronalservice.redNeuronal.errors;
//     final List<double> iteraciones = neuronalservice.redNeuronal.errors;
    

//     final size = MediaQuery.of(context).size;
//     return Center(
//       child: Container(
//         width: size.width * 0.8,
//         height: size.height*0.6,
//         child: SfCartesianChart(
//           title: ChartTitle(
//             text: 'Grafica de Error'
//           ),
//           legend: Legend(isVisible: true),
//           series: <LineSeries>[
//             LineSeries<double, double>(
//               dataSource: neuronalservice.redNeuronal.errors,
//               xValueMapper: (  iteraciones, nombre) => nombre.toDouble(),
//               yValueMapper: ( errorGrafica, _) => errorGrafica,
//               dataLabelSettings: DataLabelSettings(isVisible: true,),
//             ),
//           ],
//           primaryXAxis: CategoryAxis(),
//         ),
//       ),
//     );
//   }
// }