import 'package:flutter/material.dart';
import '../controller/participant/escape_room_data.dart';

class EscapeRoomScreen extends StatelessWidget {
  final EscapeRoomController controller = EscapeRoomController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.fetchEscapeRoomsByProximity(""), // Coordenadas de ejemplo
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Cargando...'),
              backgroundColor: Color(0xFFA2DAF1),
              centerTitle: true,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final escapeRooms = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Escape Rooms Cercanos'),
              backgroundColor: Color(0xFFA2DAF1),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: escapeRooms.length,
              itemBuilder: (context, index) {
                final room = escapeRooms[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      room['title'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      'Ubicación: ${room['location']['city']}, ${room['location']['country']}\n'
                          'Calle: ${room['location']['street']} ${room['location']['street_number']}',
                    ),
                    onTap: () {
                      _showEscapeRoomDetails(context, room);
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Escape Rooms'),
              backgroundColor: Color(0xFFA2DAF1),
              centerTitle: true,
            ),
            body: Center(
              child: Text('No se encontraron Escape Rooms cercanos.'),
            ),
          );
        }
      },
    );
  }

  void _showEscapeRoomDetails(BuildContext context, Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(room['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('País: ${room['location']['country']}'),
              Text('Ciudad: ${room['location']['city']}'),
              Text('Calle: ${room['location']['street']} ${room['location']['street_number']}'),
              Text('Coordenadas: ${room['location']['coordinates']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
