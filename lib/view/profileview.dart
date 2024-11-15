import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

@override
Widget build(BuildContext context) {
	return Scaffold(
		appBar: AppBar(
			title: Text('Mi perfil',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
			backgroundColor: Color(0xFFA2DAG1),
			centerTitle: true,
		),
		body: Container(
			width: double.infinity,
			padding: const EdgeInsets.all(10.0),
			color: const Color(0xFFE7E03C),
			child:
			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					SizedBox(height:30),
					Center(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisSize: MainAxisSize.min,
							children: [
								Text('Nombre de usuario:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
							]
						),
					),
					SizedBox(height:30),
					Center(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisSize: MainAxisSize.min,
							children: [
								Text('Email:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
							]
						),
					),
					SizedBox(height:30),
					Center(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisSize: MainAxisSize.min,
							children: [
								Text('Rango:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
							]
						),
					),
					SizedBox(height:30),
					Center(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisSize: MainAxisSize.min,
							children: [
								Text('Puntos:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
							]
						),
					),
					SizedBox(height: 100),
					Center(
						CustomButton(
							value: 'Modificar perfil',
							color: Color(0xFFA2DAF1),
							onPressed: (){
								//lo lleva a la pagina de modificar perfil
							}
						),
						CustomButton(
							value: 'Eliminar cuenta',
							color: Color(0xFFFFA1A1),
							onPressed: (){
								showDialog(
									context: context,
									builder: (context) => AlertDialog(
										title: Text('¿Quieres borrar la cuenta?',textAlign: TextAlign.center,style: TextStyle(color: Color(0xFFFFA1A1),fontWeight:FontWeight.bold ),
									),
									content: Text('Si eliminas la cuenta no podrás recuperarla. ¿Continuar?'),
									actions: [
                          							TextButton(
                            							onPressed: () => Navigator.pop(context),
                            							child: Text('Eliminar cuenta',style: TextStyle(fontWeight: FontWeight.bold)),
										                      // borrar cuenta
                          							),
                        						],
								);
							}
						),
					),
				],
			),
		),
	);
}
