import 'package:flutter/material.dart';
import '../../controller/admin/statisticsController.dart';

void main() {
  runApp(MaterialApp(
    home: StatisticsScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class StatisticsScreen extends StatelessWidget {
  final StatisticsController controller = StatisticsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Estadísticas ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
                child: Image.asset('lib/view/assets/estadistica.png', height: 150)),
            SizedBox(height: 30),
            Center(child: Text('Tasa de conversión',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
            SizedBox(height: 30),
            Center(child:Text(controller.conversion.toString(),style: TextStyle(fontSize: 18))),
            SizedBox(height: 30),
            Center(child: Text('Tasa de crecimiento de usuarios:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
            SizedBox(height: 30),
            Center(child:Text(controller.session.toString(),style: TextStyle(fontSize: 18))),
            SizedBox(height: 30),
            Center(child: Text('Intervalo de la sesión:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
            SizedBox(height: 30),
            Center(child:Text(controller.growth.toString(),style: TextStyle(fontSize: 18))),
            SizedBox(height: 30),



          ],
        ),
      ),
    );
  }
}


