import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(
					'Mi perfil',
					style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
				),
				backgroundColor: Color(0xFFA2DAF1), // Color corregido
				centerTitle: true,
			),
			body: Container(
				width: double.infinity,
				padding: const EdgeInsets.all(10.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Center(child:Image.asset('lib/view/assets/perfil.png',height: 150)),
						SizedBox(height: 30),
						Center(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisSize: MainAxisSize.min,
								children: [
									Text(
										'Nombre de usuario:',
										style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
									),
								],
							),
						),
						SizedBox(height: 30),
						Center(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisSize: MainAxisSize.min,
								children: [
									Text(
										'Email:',
										style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
									),
								],
							),
						),
						SizedBox(height: 30),
						Center(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisSize: MainAxisSize.min,
								children: [
									Text(
										'Rango:',
										style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
									),
								],
							),
						),
						SizedBox(height: 30),
						Center(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisSize: MainAxisSize.min,
								children: [
									Text(
										'Puntos:',
										style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
									),
								],
							),
						),
						SizedBox(height: 200),
						Center(
							child: Column(
								children: [
									CustomButton(
										value: 'Modificar perfil',
										color: Color(0xFFA2DAF1),
										onPressed: () {
											print('Modificar perfil presionado');
										},
									),
									SizedBox(height: 16),
									CustomButton(
										value: 'Eliminar cuenta',
										color: Color(0xFFFFA1A1),
										onPressed: () {
											showDialog(
												context: context,
												builder: (context) => AlertDialog(
													title: Text(
														'¿Quieres borrar la cuenta?',
														textAlign: TextAlign.center,
														style: TextStyle(
															color: Color(0xFFFFA1A1),
															fontWeight: FontWeight.bold,
														),
													),
													content: Text(
															'Si eliminas la cuenta no podrás recuperarla. ¿Continuar?'),
													actions: [
														TextButton(
															onPressed: () {
																// Aquí se borra la cuenta
																Navigator.pop(context);
																print('Cuenta eliminada');
															},
															child: Text(
																'Eliminar cuenta',
																style: TextStyle(fontWeight: FontWeight.bold),
															),
														),
														TextButton(
															onPressed: () => Navigator.pop(context),
															child: Text(
																'Cancelar',
																style: TextStyle(fontWeight: FontWeight.bold),
															),
														),
													],
												),
											);
										},
									),
									SizedBox(height: 16),
									CustomButton(
										value:'Cerrar sesión',
										color: Color(0xFFFFA1A1),
										onPressed: () {
											showDialog(
												context: context,
												builder: (context) => AlertDialog(
													title: Text(
														'¿Quieres cerrar sesión?',
														textAlign: TextAlign.center,
														style: TextStyle(
															color: Color(0xFFFFA1A1),
															fontWeight: FontWeight.bold,
														),
													),
													content:
													Text('¿Cerrar sesión en el dispositivo?'),
													actions: [
														TextButton(
															onPressed: () {
																Navigator.pop(context);
																print('Sesión cerrada');
															},
															child: Text(
																'Cerrar sesión',
																style: TextStyle(fontWeight: FontWeight.bold),
															),
														),
														TextButton(
															onPressed: () => Navigator.pop(context),
															child: Text(
																'Cancelar',
																style: TextStyle(fontWeight: FontWeight.bold),
															),
														),
													],
												),
											);
										},
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
