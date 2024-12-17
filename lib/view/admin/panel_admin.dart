import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../profileview.dart';
import 'statistics.dart';
void main() {
  runApp(MaterialApp(
    home: PanelScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class PanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Panel de administración',
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
                          key: Key('create_escape_button'),
                          value: 'Crear un escape room',
                          color: Color(0xFFA2DAF1),
                          onPressed: () {
                            print(
                                'Debe redireccionar a la página de crear un escape room');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      Image.asset(
                        'lib/view/assets/eliminar_escape.png', // Ruta de tu imagen
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10), // Espaciado entre imagen y botón
                      Expanded(
                        child: PanelButton(
                            key: Key('delete_escape_button'),
                            value: 'Eliminar un escape room',
                            color: Color(0xFFFFA1A1),
                            onPressed: () {
                              print('Debe redireccionar a la página de eliminar un escape room');
                            }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      Image.asset(
                        'lib/view/assets/modificar_escape.png', // Ruta de tu imagen
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10), // Espaciado entre imagen y botón
                      Expanded(
                        child: PanelButton(
                            key: Key('modify_escape_button'),
                            value: 'Modificar un escape room',
                            color: Color(0xFFA2DAF1),
                            onPressed: (){
                              print('Debe redireccionar a la página de modificar un escape room');
                            }
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
                              print('Debe redireccionar a mis Escape Rooms');

                            }
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'lib/view/assets/estadistica.png', // Ruta de tu imagen
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10), // Espaciado entre imagen y botón
                      Expanded(
                        child: PanelButton(
                            key: Key('statistics_button'),
                            value: 'Estadísticas',
                            color: Color(0xFFA2DAF1),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => StatisticsScreen()),
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
