import 'package:flutter/material.dart';
import '../../domain/escape_rooms/escape_room.dart';
import '../../controller/participant/escape_room_info_view_controller.dart';

void main() {
  runApp(MaterialApp(
    home: EscapeRoomInfoView(id: ''),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));

}

class EscapeRoomInfoView extends StatelessWidget {
  EscapeRoomInfoView({super.key, required this.id});

  final String id;
  final EscapeRoomInfoViewController controller = EscapeRoomInfoViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Escape Room'),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true
      ),
      body: FutureBuilder<EscapeRoom>(
        future: controller.getEscapeRoomInfoById(id), // Método asíncrono para obtener datos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No se encontraron datos.'));
          } else {
            final escapeRoom = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Descripción:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(escapeRoom.description),
                  const SizedBox(height: 16.0),
                  Text(
                    'Dificultad:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('${escapeRoom.difficulty}'),
                  const SizedBox(height: 16.0),
                  Text(
                    'Precio:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('${escapeRoom.price.toStringAsFixed(2)}€'),
                  const SizedBox(height: 16.0),
                  Text(
                    'Duración máxima de la sesión:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('${escapeRoom.maxSessionDuration} horas'),
                  const SizedBox(height: 16.0),
                  Text(
                    'Información de Ubicación: \n',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('country: ${escapeRoom.location.country}\n'),
                  Text('city: ${escapeRoom.location.city}\n'),
                  Text('street: ${escapeRoom.location.street}\n'),
                  Text('street_number: ${escapeRoom.location.streetNumber}\n'),
                  Text('coordinates: ${escapeRoom.location.coordinates}')
                ],
              ),
            );
          }
        },
      ),
    );
  }
}