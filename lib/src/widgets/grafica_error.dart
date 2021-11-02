
import 'package:flutter/material.dart';

import 'package:perceptron_multicapa/src/models/error_model.dart';
import 'package:perceptron_multicapa/src/service/neurona_service.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class GraficaError extends StatefulWidget {
  

  final List<ErrorModel> errorModel;

  const GraficaError({Key? key, required this.errorModel}) : super(key: key);


  @override
  _GraficaErrorState createState() => _GraficaErrorState();
}

class _GraficaErrorState extends State<GraficaError> {

  List<ErrorModel> _error = [];

  final neuronalservice = NeuronaService();

  @override
  void initState() {
    _error = getErrorGrafi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final List<double> iteraciones = List.generate(neuronalservice.redNeuronal.errors.length, (index) => (index++).toDouble());
    print(iteraciones);
    
    final List<double> errorGrafica = neuronalservice.redNeuronal.errors;

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
              dataSource: neuronalservice.redNeuronal.errors,
              xValueMapper: (  iteraciones, _) => iteraciones,
              yValueMapper: ( errorGrafica, _) => errorGrafica,
              dataLabelSettings: DataLabelSettings(isVisible: true,),
            ),
          ],
          primaryXAxis: CategoryAxis(),
        ),
      ),
    );
  }



  List<ErrorModel> getErrorGrafi(){
    final List<ErrorModel> error = widget.errorModel;
    return error;
  }


}