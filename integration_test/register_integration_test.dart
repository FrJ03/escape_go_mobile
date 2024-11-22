import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/registerview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de registrarse correctamente', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();


    // Busca el campo de usuario y escribe texto
    final userField = find.byType(TextField).at(0);
    await tester.enterText(userField, 'usuario');

    // Busca el campo de contraseña y escribe texto
    final emailField = find.byType(TextField).at(1);
    await tester.enterText(emailField, 'usuario@gmail.com');


    // Busca el campo de contraseña y escribe texto
    final passwordField = find.byType(TextField).at(2);
    await tester.enterText(passwordField, 'password');

    // Presiona el botón de inicio de sesión
    final registerButton = find.byKey(Key('register_button'));
    await tester.tap(registerButton);


    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verifica si el diálogo de éxito aparece
    final successDialog = find.text('Correcto');
    expect(successDialog, findsOneWidget);
  });
  testWidgets('Prueba de registrarse con un email que ya está registrado', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();


    // Busca el campo de usuario y escribe texto
    final userField = find.byType(TextField).at(0);
    await tester.enterText(userField, 'usuario');

    // Busca el campo de contraseña y escribe texto
    final emailField = find.byType(TextField).at(1);
    await tester.enterText(emailField, 'user@gmail.com');


    // Busca el campo de contraseña y escribe texto
    final passwordField = find.byType(TextField).at(2);
    await tester.enterText(passwordField, 'password');

    // Presiona el botón de inicio de sesión
    final registerButton = find.byKey(Key('register_button'));
    await tester.tap(registerButton);


    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verifica si el diálogo de éxito aparece
    final successDialog = find.text('Error');
    expect(successDialog, findsOneWidget);
  });

  testWidgets('Prueba de registrarse con un nombre que ya está registrado', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();


    // Busca el campo de usuario y escribe texto
    final userField = find.byType(TextField).at(0);
    await tester.enterText(userField, 'user');

    // Busca el campo de contraseña y escribe texto
    final emailField = find.byType(TextField).at(1);
    await tester.enterText(emailField, 'ejemplo@gmail.com');


    // Busca el campo de contraseña y escribe texto
    final passwordField = find.byType(TextField).at(2);
    await tester.enterText(passwordField, 'password');

    // Presiona el botón de inicio de sesión
    final registerButton = find.byKey(Key('register_button'));
    await tester.tap(registerButton);


    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verifica si el diálogo de éxito aparece
    final successDialog = find.text('Error');
    expect(successDialog, findsOneWidget);
  });


}