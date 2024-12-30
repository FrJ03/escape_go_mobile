import 'package:flutter/material.dart';
import '../../domain/escape_rooms/escape_room.dart';
import '../../controller/participant/escape_room_info_view_controller.dart';

void main() {
  runApp(MaterialApp(
    home: EscapeRoomInfoView(id: ''),
    theme: ThemeData(
      fontFamily: 'Roboto',
      primaryColor: Color(0xFFA2DAF1),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color(0xFF66B2E8),
      ),
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
        title: const Text('Detalles Escape Room',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: FutureBuilder<EscapeRoom>(
        future: controller.getEscapeRoomInfoById(id),
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
                  _buildInfoCard('Descripción', escapeRoom.description),
                  _buildInfoCard('Dificultad', '${escapeRoom.difficulty}'),
                  _buildInfoCard('Precio', '${escapeRoom.price.toStringAsFixed(2)}€'),
                  _buildInfoCard('Duración máxima de la sesión', '${escapeRoom.maxSessionDuration} horas'),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Información de Ubicación',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildInfoCard('País', escapeRoom.location.country),
                  _buildInfoCard('Ciudad', escapeRoom.location.city),
                  _buildInfoCard('Calle', escapeRoom.location.street),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
