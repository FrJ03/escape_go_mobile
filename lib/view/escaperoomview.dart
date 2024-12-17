import 'package:flutter/material.dart';
import '../controller/participant/escape_room_data.dart';

class EscapeRoomScreen extends StatelessWidget {
  final EscapeRoomController controller = EscapeRoomController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
	    // se piden los datos que se van a almacenar en future
      future: controller.fetchEscapeRoomDetails(),
      builder: (context, snapshot) {
	      // si está tardando en cargar
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Cargando...'),
              backgroundColor: Color(0xFFA2DAF1),
              centerTitle: true,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
		// si hay un error
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                data['title'], // Usa el título del escape room desde los datos obtenidos
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              backgroundColor: Color(0xFFA2DAF1),
              centerTitle: true,
            ),
            body: _buildEscapeRoomDetails(data), // Construye el body con los demás datos
          );
        } else {
		// si no se han podido obtener los datos
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
              backgroundColor: Color(0xFFA2DAF1),
              centerTitle: true,
            ),
            body: Center(child: Text('Hubo un error desconocido al obtener los datos del Escape Room')),
          );
        }
      },
    );
  }

  Widget _buildEscapeRoomDetails(Map<String, dynamic> data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(data['imagePath'], height: 150)),
          SizedBox(height: 30),
          Center(child: buildDetail(data['description'])),
          SizedBox(height: 30),
          Center(child: buildDetail('Objetivo: ${data['objective']}')),
          SizedBox(height: 30),
          Center(child: buildDetail('Nivel de dificultad: ${data['difficulty']}')),
          SizedBox(height: 30),
          Center(child: buildDetail('Advertencias: ${data['warnings']}')),
          SizedBox(height: 30),
          Center(child: buildDetail('Premio: ${data['prize']}')),
          SizedBox(height: 30),
          Center(child: buildDetail('Límite de tiempo: ${data['timeLimit']}')),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA2F1A5),
              ),
              onPressed: () {
                print('Inscribiéndose al escape room...');
              },
              child: Text('Inscribirse'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetail(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ],
    );
  }
}
