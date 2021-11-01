import 'package:flutter/material.dart';

import 'package:perceptron_multicapa/src/models/error_model.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class GraficaError extends StatefulWidget {
  

  final List<ErrorModel> errorModel;

  const GraficaError({Key? key, required this.errorModel}) : super(key: key);


  @override
  _GraficaErrorState createState() => _GraficaErrorState();
}

class _GraficaErrorState extends State<GraficaError> {

  List<ErrorModel> _error = [];

  @override
  void initState() {
    _error = getErrorGrafi();
    super.initState();
  }


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
            LineSeries<ErrorModel, double>(
              dataSource: _error,
              xValueMapper: (ErrorModel data, _) => data.interaciones.toDouble(),
              yValueMapper: (ErrorModel data, _) => data.error,
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