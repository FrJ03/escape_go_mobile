import 'package:flutter/material.dart';
import'../../controller/participant/ranking_controller.dart';
import 'package:escape_go_mobile/domain/user/user_ranking.dart';
import '../widgets/widgets.dart';
import 'escape_room_info_view.dart';

//Vista para listar todos los Escape Rooms por distancia en el participante

void main() {
  runApp(MaterialApp(
    home: RankingScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class RankingScreen extends StatelessWidget {
  final RankingController _controllerP = RankingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: _controllerP.getUsers(),
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
                'No se encontraron usuarios para el ranking.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final users = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              // nota la pulsación
              return GestureDetector(
                // ENVÍA EL ID DEL ESCAPE ROOM A LA VISTA SIGUIENTE, NECESARIO PARA PEDIR LAS PISTAS
                onTap: () {

                },
                child: UserRow(user: user),
              );
            },
          );
        },
      ),
    );
  }
}

class UserRow extends StatelessWidget {
  final User user;

  const UserRow({required this.user});

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
          Image.asset('lib/view/assets/perfil.png', height: 70),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username, // Muestra el título del escape room
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  user.points.toString(), // Muestra el título del escape room
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

