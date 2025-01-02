import 'package:flutter/material.dart';
import '../../domain/escape_rooms/escape_room.dart';
import '../../controller/participant/participe_escape_controller.dart';
import '../widgets/widgets.dart';
import 'dart:convert';
import '../../domain/escape_rooms/participation.dart';

void main() {
  runApp(MaterialApp(
    home: ParticipateScreen(id: ''),
    theme: ThemeData(
      fontFamily: 'Roboto',
      primaryColor: Color(0xFFA2DAF1),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color(0xFF66B2E8),
      ),
    ),
  ));
}

class ParticipateScreen extends StatelessWidget {
  ParticipateScreen({super.key, required this.id});

  final String id;
  final ParticipateEscController controller = ParticipateEscController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Participar Escape',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                  _buildInfoCard(
                      'Precio', '${escapeRoom.price.toStringAsFixed(2)}€'),
                  _buildInfoCard('Duración máxima de la sesión',
                      '${escapeRoom.maxSessionDuration} horas'),
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
                  const SizedBox(height: 16.0),
                  const Text(
                    'Participaciones',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ..._buildParticipationList(escapeRoom.participations),

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

  List<Widget> _buildParticipationList(List<Participation>? participations) {
    if (participations == null || participations.isEmpty) {
      return [
        const Text(
          'No hay participaciones registradas.',
          style: TextStyle(color: Colors.black54),
        ),
      ];
    }

    return participations.map((participation) {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ID
              Row(
                children: [
                  const Icon(Icons.confirmation_number, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'ID: ${participation.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Fecha de inicio
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    'Inicio: ${participation.startDate}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Fecha de fin
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    'Fin: ${participation.endDate}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Puntos
              Row(
                children: [
                  const Icon(Icons.score, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    'Puntos: ${participation.points ?? 'Sin datos'}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Botón de acción
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('Seleccionado participación ID: ${participation.id}');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color(0xFFA2DAF1),
                  ),
                  child: const Text(
                    'Seleccionar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}