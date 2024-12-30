import 'package:escape_go_mobile/view/participant/participe_escape.dart';
import 'package:flutter/material.dart';
import'../../controller/participant/escape_rooms_controller.dart';
import 'package:escape_go_mobile/domain/escape_rooms/escape_room_list_item.dart';
import '../widgets/widgets.dart';
import 'escape_room_info_view.dart';

//Vista para listar todos los Escape Rooms por distancia en el participante

void main() {
  runApp(MaterialApp(
    home: EscapeRoomsScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class EscapeRoomsScreen extends StatelessWidget {
  final EscapeRoomsController _controllerP = EscapeRoomsController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Escape Rooms',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: FutureBuilder<List<EscapeRoomListItem>>(
        future: _controllerP.getEscapeRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Indicador de carga
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No se encontraron escape rooms cerca.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final escapeRooms = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: escapeRooms.length,
            itemBuilder: (context, index) {
              final escapeRoom = escapeRooms[index];
              // nota la pulsación
              return GestureDetector(
                // ENVÍA EL ID DEL ESCAPE ROOM A LA VISTA SIGUIENTE, NECESARIO PARA PEDIR LAS PISTAS
                onTap: () {

                },
                child: EscapeRoomRow(escapeRoom: escapeRoom),
              );
            },
          );
        },
      ),
    );
  }
}

class EscapeRoomRow extends StatelessWidget {
  final EscapeRoomListItem escapeRoom;

  const EscapeRoomRow({required this.escapeRoom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('lib/view/assets/logo.png', height: 70),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  escapeRoom.title, // Muestra el título del escape room
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.info, color: Colors.blueAccent),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EscapeRoomInfoView(id: escapeRoom.id.toString())),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.play_arrow, color: Colors.greenAccent),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>ParticipateScreen(id: escapeRoom.id.toString())),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
