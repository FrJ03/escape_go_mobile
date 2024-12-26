import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../controller/participant/participe_escape_controller.dart';

void main() {
  runApp(MaterialApp(
    home: ParticipateEscapeScreen(escapeRoomId: 0),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class ParticipateEscapeScreen extends StatefulWidget {
  final int escapeRoomId; // RECIBE EL INT DEL ESCAPE ROOM
  const ParticipateEscapeScreen({Key? key, required this.escapeRoomId}) : super(key: key);
  @override
  _ParticipateEscapeScreenState createState() =>
      _ParticipateEscapeScreenState();
}

class _ParticipateEscapeScreenState extends State<ParticipateEscapeScreen> {
  final ParticipateEscController controller = ParticipateEscController();
  DateTime? selectedSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.tittle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Image.asset(
                      'lib/view/assets/logo.png', // Ruta de tu imagen
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 16),
                    Text(
                      controller.description,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Nivel de dificultad:',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      controller.level,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Precio',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '${(controller.price / 100).toString()}€',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Sesiones',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              // Usamos el método del controlador para generar los ListTile
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.dates.length,
                itemBuilder: (context, index) {
                  return controller.buildSessionTile(
                    session: controller.dates[index],
                    selectedSession: selectedSession,
                    onSelected: (DateTime? value) {
                      setState(() {
                        selectedSession = value;
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    key: Key('participe_esc_button'),
                    value: 'INICIAR',
                    color: Color(0xFFA2F1A5),
                    onPressed: () {
                      if (selectedSession != null) {
                        controller.participe(context);
                        // PASAMOS EL ID DEL ESCAPE ROOM A LA VISTA DEL JUEGO CUANDO SE ACEPTA PARTICIPAR
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameEscapeScreen(
                              escapeRoomId: widget.escapeRoomId,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Por favor, selecciona una sesión."),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
