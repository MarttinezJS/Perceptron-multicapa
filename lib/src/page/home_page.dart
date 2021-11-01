import 'package:flutter/material.dart';
import 'package:perceptron_multicapa/src/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('PERCEPTRON MULTICAPA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: size.height * 0.04),),
      ),
      body: BodyMenu(),
    );
  }
}

class BodyMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
        child: GridView.builder(
          itemCount: pageRoute.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1.1
          ),
          itemBuilder: (context, index) => _CardMenu(data: pageRoute[index],),
        ),
      ),
    );
  }
}

class _CardMenu extends StatelessWidget {
  
  final Rutas data;
  

  const _CardMenu({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => data.page));
        },
        
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( data.icon, size: 80, color: data.color, ),
                SizedBox(height: 10,),
                Text( data.titulo, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16), )
              ],
            ),
          ),
      ),
    );
  }
}