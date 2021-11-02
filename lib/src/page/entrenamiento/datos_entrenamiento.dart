import 'dart:js';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import 'package:perceptron_multicapa/src/models/datosRNA_model.dart';
import 'package:perceptron_multicapa/src/service/neurona_service.dart';
import 'package:perceptron_multicapa/src/utils/datos_convert.dart';
import 'package:perceptron_multicapa/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DatosEntrenamientoPage extends StatefulWidget {
  DatosEntrenamientoPage({Key? key}) : super(key: key);

  @override
  _DatosEntrenamientoPageState createState() => _DatosEntrenamientoPageState();
}

class _DatosEntrenamientoPageState extends State<DatosEntrenamientoPage> {

  String _opcionEntrenamiento = 'Regla delta';
  String _opcionActSalida = 'sigmoid';
  String _opcionActCapa = 'sigmoid';
  List<String> _aEntrenamiento = ['Regla delta', 'Regla delta Modificada' ];
  List<String> _funcionesSalida = ['sigmoid', 'tanh', 'linear'];
  List<String> _funcionesCapa = ['sigmoid','tanh'];
  String numeroCapas = '';
  String capa = '';

  final neuronaService = NeuronaService();
  final datosRna = DatosRNA();

  @override
  Widget build(BuildContext context) {

    final csvConvert = Provider.of<DatosConvert>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Entrenamiento', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.file_present_rounded, size: 32,),
            onPressed: (){
              csvConvert.cargarCSV();
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            ConfiguracionRNA(size),
            Entrenamiento(size, csvConvert),
          ],
        ),
      ),
    );
  }

  Expanded ConfiguracionRNA(Size size) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black) 
            ),
            width: size.width*0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Configuración de la red', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                SizedBox(height: 20,),
                Text('Funcion de activasion de la capa de salida',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                _crearDropdown(_funcionesSalida, funcionActSalida, _opcionActSalida ),
                SizedBox(height: 20,),
                Text('Capas ocultas',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                SizedBox(height: 20,),
                SizedBox(height: 20,),
                Text('Agragar informacion de las capas',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            capa = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Capa ',
                          labelText: 'Numero de neuronas',
                          helperText: 'Valor numerico',
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    _crearDropdown(_funcionesCapa, funcionActCapa, _opcionActCapa ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 18),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text('Agregar capa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                    onPressed: (){
                      if(capa != ''){
                        print('paso');
                        setState(() {
                          datosRna.neuronaPorCapa.add(int.parse(capa));
                          datosRna.funcionActCapa.add(_opcionActCapa);
                        });
                      }
                    },
                  ),
                ),
                (datosRna.neuronaPorCapa.isNotEmpty) ? Column(
                  children: [
                    Table(
                      border: TableBorder.all(width: 1.0),
                      children: [
                        TableRow(
                          children: datosRna.neuronaPorCapa.map((e){
                            return Center(
                              child: Text(e.toString(), style: TextStyle(fontSize: 20),),
                            );
                          }).toList()
                        )
                      ],
                    ),
                    Table(
                      border: TableBorder.all(width: 1.0),
                      children: [
                        TableRow(
                          children: datosRna.funcionActCapa.map((e){
                            return Center(
                              child: Text(e, style: TextStyle(fontSize: 20),),
                            );
                          }).toList()
                        )
                      ],
                    ),
                  ],
                ) : Container(),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 18),
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blue,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text('Configurar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              onPressed: () async{
                datosRna.neuronaPorCapa.add(datosRna.nSalida);
                datosRna.funcionActCapa.add(datosRna.funActSalida);
                final data = {
                  "num_inputs": datosRna.nEntrada,
                  "num_layers": datosRna.nCapa,
                  "nodes_per_layer": datosRna.neuronaPorCapa,
                  "activation_functions_names": datosRna.funcionActCapa
                };
                await neuronaService.inicializarNeurona(data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container Entrenamiento(Size size, DatosConvert csvConvert) {
    return Container(
      width: size.width*0.5,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black) 
            ),
            child: Column(
              children: [
                Text('PARAMETROS DE ENTRADA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 10,),
                DatosCsv(neuronaEntrada: csvConvert.nEntradas, neuronaSalida: csvConvert.nSalidas, nPatrones: csvConvert.nPatrones),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black) 
            ),
            child: Column(
              children: [
                Text('Algoritmo de entrenamiento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 10,),
                _crearDropdown(_aEntrenamiento, cambioEntrenamiento, _opcionEntrenamiento )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black) 
            ),
            child: Column(
              children: [
                Text('Parametro de entrenamiento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            datosRna.iteraciones = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Numero de iteraciones',
                          labelText: 'Iteraciones',
                          helperText: 'Numero entero'
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            datosRna.rata = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Rata de aprendizaje',
                          labelText: 'Rata',
                          helperText: 'Numero de 0 a 1'
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            datosRna.errorMP = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Error maximo permitido',
                          labelText: 'IRMS',
                          helperText: 'Valor de 0 a 1',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 18),
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blue,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text('Enviar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              onPressed: () async{
                
                final data = {
                  "inputs": csvConvert.entradas,
                  "outputs": csvConvert.salidas,
                  "learning_rate": datosRna.rata,
                  "tolerance": datosRna.errorMP,
                  "epochs": datosRna.iteraciones
                };
                 await neuronaService.entrenarNeurona(data);
                 print('${neuronaService.redNeuronal.errors}');
              },
            ),
          ),
        ],
      ),
    );
  }

  

  entrada(List entrada){
    
    List tipoValor = [];
    

    datosRna.nEntrada = 0;
    datosRna.nSalida = 0;
    tipoValor = entrada[0];
    entrada.removeAt(0);
    datosRna.patrones = entrada;
    datosRna.numeroPatrones = datosRna.patrones.length;

    int x = tipoValor.length;
    print(x);
    for(int j = 0; j <= x-1; j++){
      String dato = tipoValor[j];
      if(dato[0] == 'x'){
        datosRna.nEntrada++;
      }else if(dato[0] == 'y'){
        datosRna.nSalida++;
      }
    }

    setState(() {
      datosRna.nEntrada;
      datosRna.nSalida;
      datosRna.patrones;
    });

  }

  cambioEntrenamiento(opt){
    setState(() {
      _opcionEntrenamiento = opt.toString();
      datosRna.entrenamiento = _opcionEntrenamiento;
      print(datosRna.entrenamiento);
    });
  }

  funcionActSalida(opt){
    setState(() {
      _opcionActSalida = opt.toString();
      datosRna.funActSalida = _opcionActSalida;
      print(datosRna.funActSalida);
    }); 
  }

  funcionActCapa(opt){
    setState(() {
      _opcionActCapa = opt.toString();
      print(_opcionActCapa);
    }); 
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown( List listDrop) {

      List<DropdownMenuItem<String>> lista = [];

      listDrop.forEach( (e){

        lista.add( DropdownMenuItem(
          child: Text(e),
          value: e,
        ));
      });

    return lista;
  }

   Widget _crearDropdown(List listDrop, Function cambio, variable ) {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),   
        Container(
          child: DropdownButton(
            value: variable,
            items: getOpcionesDropdown(listDrop),
            onChanged: (opt) {
              cambio(opt);
            },
          ),
        )
      ],
    );
  }

}