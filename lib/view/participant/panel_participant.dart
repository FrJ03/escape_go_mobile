import 'package:escape_go_mobile/view/participant/ranking_view.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../profileview.dart';
import 'escaperoomsviewParticipant.dart';
//import 'ranking_view.dart';
void main() {
  runApp(MaterialApp(
    home: PanelParticipantScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class PanelParticipantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Panel del participante',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Center(child: Text('¿Qué desea hacer?',style:TextStyle(fontSize: 25))),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        'lib/view/assets/logo.png', // Ruta de tu imagen
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10), // Espaciado entre imagen y botón
                      Expanded(
                        child: PanelButton(
                          key: Key('Escape Rooms'),
                          value: 'Ranking global',
                          color: Color(0xFFA2DAF1),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RankingScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        'lib/view/assets/perfil.png', // Ruta de tu imagen
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10), // Espaciado entre imagen y botón
                      Expanded(
                        child: PanelButton(
                            key: Key('perfil_button'),
                            value: 'Mi perfil',
                            color: Color(0xFFA2DAF1),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfileScreen()),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        'lib/view/assets/logo.png', // Ruta de tu imagen
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10), // Espaciado entre imagen y botón
                      Expanded(
                        child: PanelButton(
                            key: Key('escape_button'),
                            value: 'Escape Rooms',
                            color: Color(0xFFA2DAF1),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EscapeRoomsScreen()),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




}
