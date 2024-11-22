import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'loginview.dart';

void main() {
	runApp(MaterialApp(
		home: ProfileScreen(),
		theme: ThemeData(
			fontFamily: 'Roboto',
		),
	));
}

class ProfileScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(
					'Mi perfil',
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
						Center(child: Image.asset('lib/view/assets/perfil.png', height: 150)),
						SizedBox(height: 30),
						Center(child: buildProfileDetail('Nombre de usuario:')),
						SizedBox(height: 30),
						Center(child: buildProfileDetail('Email:')),
						SizedBox(height: 30),
						Center(child: buildProfileDetail('Rango:')),
						SizedBox(height: 30),
						Center(child: buildProfileDetail('Puntos:')),
						SizedBox(height: 200),
						Center(
							child: Column(
								children: [
									CustomButton(
										key: Key('modify_profile_button'),
										value: 'Modificar perfil',
										color: Color(0xFFA2DAF1),
										onPressed: () {
											print('Modificar perfil presionado');
										},
									),
									SizedBox(height: 16),
									CustomButton(
										key: Key('delete_account_button'),
										value: 'Eliminar cuenta',
										color: Color(0xFFFFA1A1),
										onPressed: () => showDeleteAccountDialog(context),
									),
									SizedBox(height: 16),
									CustomButton(
										key: Key('logout_button'),
										value: 'Cerrar sesión',
										color: Color(0xFFFFA1A1),
										onPressed: () => showLogoutDialog(context),
									),
								],
							),
						),
					],
				),
			),
		);
	}

	Widget buildProfileDetail(String title) {
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

	void showDeleteAccountDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (context) => AlertDialog(
				title: Text(
					'¿Quieres borrar la cuenta?',
					textAlign: TextAlign.center,
					style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
				),
				content: Text('Si eliminas la cuenta no podrás recuperarla. ¿Continuar?'),
				actions: [
					TextButton(
						onPressed: () {
							FocusScope.of(context).unfocus();
							Navigator.pushAndRemoveUntil(
								context,
								MaterialPageRoute(builder: (context) => LoginScreen()),
										(route) => false,
							);
						},
						child: Text('Eliminar cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
					),
					TextButton(
						onPressed: () => Navigator.pop(context),
						child: Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
					),
				],
			),
		);
	}

	void showLogoutDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (context) => AlertDialog(
				title: Text(
					'¿Quieres cerrar sesión?',
					textAlign: TextAlign.center,
					style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
				),
				content: Text('Si pulsas cerrar sesión tendrás que volver a iniciar sesión.'),
				actions: [
					TextButton(
						onPressed: () {
							FocusScope.of(context).unfocus();
							Navigator.pushAndRemoveUntil(
								context,
								MaterialPageRoute(builder: (context) => LoginScreen()),
										(route) => false,
							);
						},
						child: Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.bold)),
					),
					TextButton(
						onPressed: () {
							FocusScope.of(context).unfocus();
							Navigator.pop(context);
						},
						child: Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
					),
				],
			),
		);
	}
}
