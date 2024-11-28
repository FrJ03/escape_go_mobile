import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: EscapeRoomsScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class EscapeRoomsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Escape Rooms',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),



      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          children: [
            Row1(),
          ]
        ),
      ),
    );
  }
}

class Row1 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Image.asset('lib/view/assets/logo.png', height: 70),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título de Escape Room',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Descripción del Escape Room aqui se pone la descripcion y si hay mucho texto lo limita para que no se pase la pantalla porque si hay mucho texto es un rollo',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis, // Limita texto largo
                  maxLines: 3, // Número máximo de líneas visibles
                ),
              ],
            ),
          ),
        ],
      )
    // POR CADA ESCAPE ROOM QUE EXISTA SE CREA UN ROW DONDE SE PONEN SUS DATOS
    );
  }
}
