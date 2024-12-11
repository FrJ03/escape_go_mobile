import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: EscapeRoomScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class EscapeRoomScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //PLACEHOLDER PARA EL NOMBRE DEL ESCAPE ROOM
          'Nombre EscapeRoom',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,
        child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Center(child: Image.asset('lib/view/assets/logo.png', height: 150)),
// PLACEHOLDER PARA LA IMAGEN DEL ESCAPE ROOM tomado de la api
						SizedBox(height: 30),
						Center(child: buildDetail('Esta es la descripcion del escape room, aqui se describe el escape room datos tomados de la api')),
						SizedBox(height: 30),
						Center(child: buildDetail('Objetivo:')),
// AQUI SE PONE EL OBJETIVO tomado de la api
						SizedBox(height: 30),
						Center(child: buildDetail('Nivel de dificultad:')),
// AQUI SE PONE EL NIVEL DE DIFICULTAD tomado de la api
						SizedBox(height: 30),
						Center(child: buildDetail('Advertencias:')),
// AQUI SE PONEN ADVERTENCIAS tomado de la api
						SizedBox(height: 30),
						Center(child: buildDetail('Premio:')),
// AQUI SE PONE EL PREMIO tomado de la api
						SizedBox(height: 30),
						Center(child: buildDetail('Limite de tiempo:')),
// AQUI SE PONE EL LIMITE DE TIEMPO tomado de la api
						SizedBox(height: 200),
						Center(
							child: Column(
								child:
									CustomButton(
										key: Key('start_button'),
										value: 'Inscribirse',
										color: Color(0xFFA2F1A5),
										onPressed: () {
											print('Le has dado al botón de inscribirse en un escape room');
                      // EL USUARIO SE INSCRIBE EN EL ESCAPE ROOM
										},
									),
							),
						),
					],
				),
      ),
    );
  }
}


Widget buildDetail(String title) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisSize: MainAxisSize.min,
			children: [
				Text(
					title,
					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
				),
			],
		);
	}
