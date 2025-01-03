import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import './participe_escape.dart';
import 'found_clues.dart';
import '../../controller/participant/game_controller.dart';
import 'escaperoomsviewParticipant.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: GameEscapeScreen(escapeRoomId: 0, escTitle: "", escDescripcion: "", participationId: 0, startDate: DateTime.parse("2025-01-01T16:00:00Z>"), endDate: DateTime.parse("20250101T190000Z")),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class GameEscapeScreen extends StatefulWidget {
  final int escapeRoomId; // RECIBE EL ID DEL ESCAPE ROOM
  final String escTitle; // RECIBE EL NOMBRE DEL ESCAPE ROOM
	final String escDescripcion;
	final int participationId;
	final DateTime startDate;
	final DateTime endDate;
	Timer timer = new Timer(const Duration(minutes: 20), () => {});
  GameEscapeScreen({
    Key? key,
    required this.escapeRoomId,
    required this.escTitle,
		required this.escDescripcion,
		required this.participationId,
		required this.startDate,
		required this.endDate,
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
	late int participationId;
	late String escDescripcion;
	late DateTime startDate;
	late DateTime endDate;
	late String escTitle;
	late Duration remainingTime; // tiempo que queda para resolver el juego
	late Timer timer; // temporizador de la vista
	late Timer nextClueTimer;

// en cuanto se inicia la vista se pide la primera pista para comenzar el juego
	@override
	void initState() {
		super.initState();
		escapeRoomId = widget.escapeRoomId;
		participationId = widget.participationId;
		escDescripcion = widget.escDescripcion;
		startDate = widget.startDate;
		endDate = widget.endDate;
		escTitle = widget.escTitle;
		remainingTime = widget.endDate.difference(DateTime.now());
		_startTimer();
		_initializeDesc();
		nextClueTimer = widget.timer;
	}

	// Pone la descripcion en el cuadro de texto
	Future<void> _initializeDesc() async {
		setState(() {
			currentClueText = escDescripcion;
		});
	}

	// Inicia el temporizador de la vista
	void _startTimer() {
		timer = Timer.periodic(Duration(seconds: 1), (_) {
			final now = DateTime.now();
			setState(() {
				remainingTime = widget.endDate.difference(now); // ACTUALIZA EL TIEMPO RESTANTE
				if (remainingTime.isNegative || remainingTime == Duration.zero) {
					timer.cancel(); // PARAR TEMPORIZADOR
					_showTimeUpDialog(); // AVISAR AL USER
				}
			});
		});
	}

	// AVISA AL USER DE QUE HA ACABADO EL TIEMPO
	void _showTimeUpDialog() {
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text('Se acabó el tiempo'),
					content: Text('Te has quedado sin tiempo.'),
					actions: [
						TextButton(
							onPressed: () {
								Navigator.of(context).pop();
								cluesIds.clear();
								Navigator.pushReplacement(
									context,
									MaterialPageRoute(
										builder: (context) => ParticipateScreen(id: escapeRoomId.toString()),
									),
								);
							},
							child: Text('¿Volver a jugar?', style: TextStyle(fontWeight: FontWeight.bold)),
						),
					],
				);
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(
					escTitle,
					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
				),
				automaticallyImplyLeading: false,
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
											// Muestra el tiempo restante para que se acabe la participación
											_formatDuration(remainingTime),
											style: TextStyle(fontSize: 20),
										),
										SizedBox(height: 16),
										RoundedTextBox(
											text: currentClueText,
											// Pista actual
											borderColor: Color(0xFFA2DAF1),
											// Color del borde
											borderWidth: 4.0,
											// Ancho del borde
											padding: EdgeInsets.all(16),
											// Espaciado alrededor del texto
											borderRadius: BorderRadius.circular(
													12), // Esquinas redondeadas
										),
										SizedBox(height: 16),
										CustomButton(
											key: Key('obtener_pista_button'),
											value: 'OBTÉN UNA PISTA',
											color: Color(0xFFA2DAF1),
											onPressed: () async {
												if(nextClueTimer.isActive){
													showDialog(
														context: context,
														builder: (BuildContext context) {
															return AlertDialog(
																title: Text('Error'),
																content: Text('No se puede solicitar una pista.\nTemporizador: ${nextClueTimer.toString()}'),
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
												}
												else{
													try {
														// Llama al backend con getNextClue
														Clue ?nextClue = await controller.getNextClue(context,
																cluesIds, escapeRoomId, participationId);
														print(nextClue);
														if(nextClue!=null) {
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
														}
													} catch (e) {
														ScaffoldMessenger.of(context).showSnackBar(
															SnackBar(
																content: Text("Hubo un error: ${e.toString()}"),
															),
														);
													} // Fin del error
												}

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
																	style: TextStyle(color: Color(0xFFA2DAF1),
																			fontWeight: FontWeight.bold),
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
																		child: Text('CANCELAR', style: TextStyle(
																				fontWeight: FontWeight.bold)),
																	),
																	TextButton( // selecciona ENVIAR la solucion
																		onPressed: () async {
																			Navigator.pop(
																					context); // cierra el pop-up que le pide ingresar la solucion
																			final solution = solutionController.text
																					.trim(); // consigue el texto del cuadro de texto
																			if (solution.isNotEmpty) {
																				try {
																					// obtiene los puntos
																					final points = await controller.solve(solution, escapeRoomId, participationId);

																					showDialog(
																						context: context,
																						builder: (BuildContext context) {
																							return AlertDialog(
																								title: Text(
																									'Tu puntuación ha sido',
																									style: TextStyle(
																											color: Color(0xFFA2DAF1),
																											fontWeight: FontWeight
																													.bold),
																								),
																								content: Text('$points puntos'),
																								actions: [
																									TextButton(
																										onPressed: () {
																											Navigator.of(context)
																													.pop(); // cerrar dialogo
																											Navigator.pushReplacement(context,
																												MaterialPageRoute(
																														builder: (
																																context) =>
																														EscapeRoomsScreen()),
																											); // sacarlo del juego y redirigir a la pagina de participacion por si quiere jugar otra vez
																										},
																										child: Text('SALIR',
																												style: TextStyle(
																														fontWeight: FontWeight
																																.bold)),
																									),
																								],
																							);
																						},
																					);
																				} catch (e) {
																					ScaffoldMessenger.of(context)
																							.showSnackBar(
																						SnackBar(
																							content: Text("Hubo un error: ${e
																									.toString()}"),
																						),
																					);
																				}
																			} else {
																				ScaffoldMessenger.of(context)
																						.showSnackBar(
																					SnackBar(
																						content: Text(
																								"Introduce la solución"),
																					),
																				);
																			}
																		},
																		child: Text('ENVIAR', style: TextStyle(
																				fontWeight: FontWeight.bold)),
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
										) // FIN DEL BOTON PARA RESOLVER ESCAPE ROOM
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
													builder: (context) =>
															CluesScreen(
																cluesIds: cluesIds, // lista de cluesIds
																escapeRoomId: escapeRoomId, // escapeRoomId
																participationId: participationId,
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
											try {
												// Activa el modo NFC
												bool isAvailable = await NfcManager.instance.isAvailable();
												if (!isAvailable) {
													ScaffoldMessenger.of(context).showSnackBar(
														SnackBar(content: Text("NFC no está disponible en este dispositivo.")),
													);
													return;
												}

												// Lee el tag
												await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
													try {
														// Extrae el contenido del tag NFC
														final ndef = Ndef.from(tag);
														if (ndef == null) {
															throw Exception("El tag NFC no es compatible con NDEF.");
														}

														// Obtener el mensaje
														final ndefMessage = ndef.cachedMessage;
														if (ndefMessage == null || ndefMessage.records.isEmpty) {
															throw Exception("El tag contiene datos inválidos.");
														}
														// Extrae el ID de la pista que está guardado en el tag
														final clueId = int.parse(
															String.fromCharCodes(ndefMessage.records.first.payload),
														);
														// Obtiene la pista entera
														Clue clue = await controller.getClue(clueId, escapeRoomId, participationId);
														// Actualiza la pista actual
														setState(() {
															currentClueText = clue.info;
															cluesIds.add(clue.id);
														});
														// Cierra la sesión NFC
														await NfcManager.instance.stopSession();
														// Regresa al usuario a la vista del juego
														ScaffoldMessenger.of(context).showSnackBar(
															SnackBar(content: Text("Pista encontrada: ${clue.title}")),
														);
														nextClueTimer = new Timer(Duration(minutes: 20), () => {});
													} catch (e) {
														await NfcManager.instance.stopSession(errorMessage: e.toString());
														ScaffoldMessenger.of(context).showSnackBar(
															SnackBar(content: Text("Error al leer el tag NFC: ${e.toString()}")),
														);
													}
												});
											} catch (e) {
												ScaffoldMessenger.of(context).showSnackBar(
													SnackBar(content: Text("Hubo un error al activar lector NFC: ${e.toString()}")),
												);
											}
										},
									)

								],
							),
						],
					),
				),
			),
		);
	}

  // PARA MOSTRAR UN FORMATO AMIGABLE AL USUARIO
	String _formatDuration(Duration duration) {
		final minutes = duration.inMinutes % 60;
		final seconds = duration.inSeconds % 60;
		return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
	}


	void _showExitDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (context) =>
					AlertDialog(
						title: Text(
							'SALIR',
							style: TextStyle(
									color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
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
									Navigator.pushReplacement(context, MaterialPageRoute(
											builder: (context) =>
													ParticipateScreen(id: escapeRoomId.toString())
									));
								},
								child: Text(
										'SÍ', style: TextStyle(fontWeight: FontWeight.bold)),
							),
							TextButton(
								onPressed: () => Navigator.pop(context),
								child: Text(
										'NO', style: TextStyle(fontWeight: FontWeight.bold)),
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
