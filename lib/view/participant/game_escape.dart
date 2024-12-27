import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import './participe_escape.dart';
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
  final int escapeRoomId; // RECIBE EL ID DEL ESCAPE ROOM
  const GameEscapeScreen({Key? key, required this.escapeRoomId}) : super(key: key);
  
  @override
  _GameEscapeScreenState createState() =>
      _GameEscapeScreenState();
}

class _GameEscapeScreenState extends State<GameEscapeScreen> {
  final GameController controller = GameController();
  List<int> cluesIds = []; // Lista para almacenar los IDs de las pistas encontradas
  late int escapeRoomId; // toma el id para conseguir las pistas del escape room correcto
  String currentClueText = ''; // vamos a rellenar esto con la primera pista

// en cuanto se inicia la vista se pide la primera pista para comenzar el juego
  @override
  void initState() {
    super.initState();
    escapeRoomId = widget.escapeRoomId;
    _initializeFirstClue();
  }
	
  // OBTIENE LA PRIMERA PISTA EN CUANTO COMIENZA EL JUEGO
  Future<void> _initializeFirstClue() async {
    try {
      Clue firstClue = await controller.getNextClue(cluesIds, escapeRoomId);
      setState(() {
        cluesIds.add(firstClue.id); // ACTUALIZA LA LISTA CON LA PRIMERA PISTA
        currentClueText = firstClue.info; // ACTUALIZA EL TEXTO QUE MUESTRA LA PISTA ACTUAL
      });
    } catch (e) {
      setState(() {
        currentClueText = 'No se pudo obtener la pista.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.title,
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
          	      text: currentClueText,
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
			  onPressed: () async {
			    try {
			      // Llama al backend con getNextClue
			      Clue nextClue = await controller.getNextClue(cluesIds, escapeRoomId);
			      // actualiza la lista con la nueva pista
			      setState(() {
			        cluesIds.add(nextClue.id);
				currentClueText = nextClue.info;
			      });
			      // Muestra el pop-up con la pista
			      showDialog(
			        context: context,
			        builder: (BuildContext context) {
			          return AlertDialog(
			            title: Text('Pista: ${nextClue.title}'),
			            content: Text(nextClue.info),
			            actions: [
			              TextButton(
			                onPressed: () {
			                  Navigator.of(context).pop();
			                },
			                child: Text('Cerrar'),
			              ),
			            ],
			          );
			        },
			      );
			    } catch (e) {
		                ScaffoldMessenger.of(context).showSnackBar(
		                  SnackBar(
		                    content: Text("Hubo un error: ${e.toString()}"),
		                  ),
		                );
		              } // Fin del error
			  }, // Fin de onPressed
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
                      _showExitDialog(context);
                    },
                  ),
		  CustomButton(
		    key: Key('pistas_button'),
		    value: 'PISTAS',
		    color: Color(0xFFA2DAF1),
		    onPressed: () {
		      Navigator.push(context, MaterialPageRoute(
		        builder: (context) => CluesScreen(
          		  cluesIds: cluesIds, // lista de cluesIds
          		  escapeRoomId: escapeRoomId, // escapeRoomId
        		),
		      ),
		      );
		    }
		  ),
		  CustomButton(
		    key: Key('continue_button'),
		    value: 'CONTINUAR',
		    color: Color(0xFFA2F1A5),
		    onPressed: () {
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
	     // SALIR DEL ESCAPE ROOM, SE TIENE QUE BORRAR ALGO MÁS ??
             onPressed: () {
		     // vacia la lista de pistas
		setState(() {
    		  cluesIds.clear();
  		});
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
