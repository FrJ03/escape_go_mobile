import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import './participe_escape.dart';
import 'found_clues.dart';
import '../../controller/participant/game_controller.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(MaterialApp(
    home: GameEscapeScreen(escapeRoomId: 0, escTitle: ""),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class GameEscapeScreen extends StatefulWidget {
  final int escapeRoomId; // RECIBE EL ID DEL ESCAPE ROOM
  final String escTitle; // REDIBE EL NOMBRE DEL ESCAPE ROOM
  const GameEscapeScreen({
    Key? key,
    required this.escapeRoomId,
    required this.escTitle,
  }) : super(key: key);
  
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
          widget.escTitle,
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
		     SizedBox(height: 16),
		     // Boton para resolver el escape room
		     CustomButton(
			  key: Key('resolver_button'),
			  value: 'RESOLVER ESCAPE ROOM',
			  color: Color(0xFFA2DAF1),
			  onPressed: () async {
			    // controlador para el campo de texto de la solucion
			    TextEditingController solutionController = TextEditingController();
			    try {
			      // muestra el pop-up para introducir la solución
			      showDialog(
			        context: context,
			        builder: (BuildContext context) {
			          return AlertDialog(
			            title: Text(
			              'RESOLVER',
			              style: TextStyle(color: Color(0xFFA2DAF1), fontWeight: FontWeight.bold),
			            ),
			            content: Column(
			              mainAxisSize: MainAxisSize.min,
			              children: [
			                Text('¿Cuál es la solución?'),
			                SizedBox(height: 10),
			                TextField(
			                  controller: solutionController,
			                  decoration: InputDecoration(
			                    border: OutlineInputBorder(),
			                    hintText: 'Introduce la solución',
			                  ),
			                ),
			              ],
			            ),
			            actions: [
			              TextButton( // selecciona NO ENVIAR la solucion
			                onPressed: () => Navigator.pop(context),
			                child: Text('CANCELAR', style: TextStyle(fontWeight: FontWeight.bold)),
			              ),
			              TextButton( // selecciona ENVIAR la solucion
			                onPressed: () async {
			                  Navigator.pop(context); // cierra el pop-up que le pide ingresar la solucion
			                  final solution = solutionController.text.trim(); // consigue el texto del cuadro de texto
			                  if (solution.isNotEmpty) {
			                    try {
					      // obtiene los puntos
			                      // final points = await controller.solve(solution, escapeRoomId, participationId); // de donde saco participationId ???
						    // VALOR DE PRUEBA PARA VER SI FUNCIONA ??
						    final points = 5;
			                      // pop up con puntos
			                      showDialog(
			                        context: context,
			                        builder: (BuildContext context) {
			                          return AlertDialog(
			                            title: Text(
			                              'Tu puntuación ha sido',
			                              style: TextStyle(color: Color(0xFFA2DAF1), fontWeight: FontWeight.bold),
			                            ),
			                            content: Text('$points puntos'),
			                            actions: [
			                              TextButton(
			                                onPressed: () {
			                                  Navigator.of(context).pop(); // cerrar dialogo
							  Navigator.push(context, MaterialPageRoute(
							    builder: (context) => ParticipateEscapeScreen()),
							  ); // sacarlo del juego y redirigir a la pagina de participacion por si quiere jugar otra vez
			                                },
			                                child: Text('SALIR', style: TextStyle(fontWeight: FontWeight.bold)),
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
			                    }
			                  } else {
			                    ScaffoldMessenger.of(context).showSnackBar(
			                      SnackBar(
			                        content: Text("Introduce la solución"),
			                      ),
			                    );
			                  }
			                },
			                child: Text('ENVIAR', style: TextStyle(fontWeight: FontWeight.bold)),
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
			    }
			  },
			); // FIN DEL BOTON PARA RESOLVER ESCAPE ROOM
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
		    key: Key('scan_button'),
		    value: 'ESCANEAR',
		    color: Color(0xFFA2F1A5),
		    onPressed: () async {
		    // escanea el nfc, obtiene el texto del nfc que es el siguiente fragmento que poner en el cuadro de texto
		      try{
			bool isAvailable = await NfcManager.instance.isAvailable();
			if (isAvailable) {
			  await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
			    final tagData = await NfcInferenceManager.instance.infer(tag);
			    setState(() {
			      // actualiza el cuadro de texto para que en vez de mostrar la PISTA, muestre el NUEVO FRAGMENTO encontrado
			      currentClueText = tagData;
			    });
			    // detiene la sesion NFC cuando obtiene los datos correctamente
			    await NfcManager.instance.stopSession();
			  });
			} else {
			  // NO TIENE ACTIVADO PARA LEER NFC
			  ScaffoldMessenger.of(context).showSnackBar(
			    SnackBar(content: Text("Activa el ajuste NFC para poder usar esta acción y avanzar en el juego."),),
			  );
			}
		      } catch (e) {
			ScaffoldMessenger.of(context).showSnackBar(
			  SnackBar(content: Text("Hubo un error al leer el tag NFC: ${e.toString()}"),),
			);
		      }
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
    showDialog(
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
		// cierra el dialog y redirige a la página de participate para salir
		Navigator.pop(context);
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
