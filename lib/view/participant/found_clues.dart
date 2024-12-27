import 'package:flutter/material.dart';
import'../../controller/participant/game_controller.dart';

void main() {
  runApp(MaterialApp(
    home: CluesScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class CluesScreen extends StatelessWidget {
  // _controllerC for clues
  final GameController _controllerC = GameController();
  final List<int> cluesIds;  // Recibe la lista de IDs de pistas
  final int escapeRoomId; // Recibe el escapeRoomId
  // Constructor que recibe cluesIds y escapeRoomId
  CluesScreen({
    Key? key,
    required this.cluesIds,
    required this.escapeRoomId,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
	leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),    // botón para ir a la página anterior (sale de las pistas y vuelve al juego)
        title: Text(
          'Pistas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFFCCB50),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: cluesIds.length,
        itemBuilder: (context, index) {
          // Para cada clueId en cluesIds -> obtiene la pista con getClue
          return FutureBuilder<Clue>(
            future: _controllerC.getClue(cluesIds[index], escapeRoomId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // SIMULA CARGA
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
                    'Hubo un error. No se pudieron cargar las pistas.',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
              final clue = snapshot.data!; // pista obtenida
              return pistaRow(pista: clue); // pista renderizada
            },
          );
        },
      ),
    );
  }
}

class pistaRow extends StatelessWidget {
  final Clue pista;

  const pistaRow({required this.pista});

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
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pista.title, // Muestra el título de la pista (pista 1 pista 2 etc)
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  pista.info, // Muestra la info de la pista ("busca un digito de 4 numeros" etc)
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
