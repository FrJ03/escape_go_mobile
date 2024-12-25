import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'participate_escape.dart';
import 'found_clues.dart';
import '../../controller/participant/game_controller.dart';

void main() {
  runApp(MaterialApp(
    home: GameEscapeScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class GameEscapeScreen extends StatefulWidget {
  @override
  _GameEscapeScreenState createState() =>
      _GameEscapeScreenState();
}

class _GameEscapeScreenState extends State<GameEscapeScreen> {
  final GameEscController controller = GameController();
  //DateTime? selectedSession;

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
                    Text(
                      'Tiempo:',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
		      // tiempo que le queda al user para resolver el escape room
                      '5 minutos',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 16),
		    RoundedTextBox(
		      // EN ESTE TEXTO SE PONE LA PISTA ACTUAL
          	      text: 'Te despiertas en esta habitación y no recuerdas nada. Encuentra una forma de escapar de la mansión.',
          	      borderColor: Color(0xFFA2DAF1), // Color del borde
          	      borderWidth: 4.0, // Ancho del borde
          	      padding: EdgeInsets.all(16), // Espaciado alrededor del texto
          	      borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
        	    ),
		    SizedBox(height: 16),
		    CustomButton(
		      key: Key('obtener_pista_button'),
		      value: 'OBTÉN UNA PISTA',
		      color: Color(0xFFA2DAF1),
		      onPressed: () {
		        // SACA UN POP-UP CON LA SIGUIENTE PISTA
		      }
		    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    key: Key('exit_button'),
                    value: 'SALIR',
                    color: Color(0xFFFFA1A1),
                    onPressed: () {
                      _showExitDialog(context),
                    },
                  ),
		  CustomButton(
		    key: Key('pistas_button'),
		    value: 'PISTAS',
		    color: Color(0xFFA2DAF1),
		    onPressed: () {
		      Navigator.push(context, MaterialPageRoute(
		        builder: (context) => CluesScreen()),
		      );
		    }
		  ),
		  CustomButton(
		    key: Key('continue_button'),
		    value: 'CONTINUAR',
		    color: Color(0xFFA2F1A5),
		    onPressed. () {
		      // CONTINUAR
		    }
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


void _showExitDialog(
  BuildContext context) {
    showExitDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'SALIR',
          style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
        ),
        content: Text('¿Salir del Escape Room?'),
        actions: [
          TextButton(
	     // SALIR DEL ESCAPE ROOM, SE TIENE QUE BORRAR ALGO ??
             onPressed: () {
		Navigator.push(context, MaterialPageRoute(
		  builder: (context) => ParticipateEscapeScreen()),
		);
	     },
             child: Text('SÍ', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}


class RoundedTextBox extends StatelessWidget {
  final String text;
  final Color borderColor; // Color del borde
  final double borderWidth; // Ancho del borde
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  const RoundedTextBox({
    required this.text,
    this.borderColor = Colors.blue, // Por defecto azul
    this.borderWidth = 1.0, // Por defecto más fino
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
