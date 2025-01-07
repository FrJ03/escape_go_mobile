import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/loginview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  	IntegrationTestWidgetsFlutterBinding.ensureInitialized();

	testWidgets('Prueba de seguridad de acceso a contenido (sin introducir credenciales)', (WidgetTester tester) async {
		// Inicia la aplicación
		app.main();
		await tester.pumpAndSettle();

		final loginButton = find.byKey(Key('login_button'));
    		await tester.tap(loginButton);

		await tester.pumpAndSettle();

		final errorDialog = find.text('Error');
    		expect(errorDialog, findsOneWidget);

		final okButton = find.widgetWithText(TextButton, 'OK');
		await tester.tap(okButton);
    		await tester.pumpAndSettle();

		final page = find.text('Iniciar sesión');
		expect(page, findsOneWidget);
		// sigue en la página de login, acceso restringido
  	});

	testWidgets('Prueba de seguridad de acceso a contenido (introduciendo credenciales de usuario no registrado)', (WidgetTester tester) async {
		// Inicia la aplicación
		app.main();
		await tester.pumpAndSettle();

		// introduce credenciales
		final userField = find.byType(TextField).at(0);
    		await tester.enterText(userField, 'usuarionoexiste');
    		final passwordField = find.byType(TextField).at(1);
    		await tester.enterText(passwordField, 'noregistrado');

		final loginButton = find.byKey(Key('login_button'));
    		await tester.tap(loginButton);

		await tester.pumpAndSettle();

		final errorDialog = find.text('Error');
    		expect(errorDialog, findsOneWidget);

		final okButton = find.widgetWithText(TextButton, 'OK');
		await tester.tap(okButton);
    		await tester.pumpAndSettle();

		final page = find.text('Iniciar sesión');
		expect(page, findsOneWidget);
		// sigue en la página de login, acceso restringido porque el usuario no está registrado
  	});
}
