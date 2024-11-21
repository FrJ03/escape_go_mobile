import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/loginview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de inicio de sesión exitoso', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Busca el campo de usuario y escribe texto
    final userField = find.byType(TextField).at(0);
    await tester.enterText(userField, 'user');

    // Busca el campo de contraseña y escribe texto
    final passwordField = find.byType(TextField).at(1);
    await tester.enterText(passwordField, 'password');

    // Presiona el botón de inicio de sesión
    final loginButton = find.byKey(Key('login_button'));
    await tester.tap(loginButton);


    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verifica si el diálogo de éxito aparece
    final successDialog = find.text('Correcto');
    expect(successDialog, findsOneWidget);
  });

  testWidgets('Prueba de inicio de sesión incorrecto porque el usuario no está registrado', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Busca el campo de usuario y escribe texto
    final userField = find.byType(TextField).at(0);
    await tester.enterText(userField, 'usuario');

    final passwordField = find.byType(TextField).at(1);
    await tester.enterText(passwordField, 'password');

    // Al haber dentro de la vista varios textos 'iniciar sesión' tenemos que poner el botón con una key
    final loginButton = find.byKey(Key('login_button'));
    await tester.tap(loginButton);

    //Establecemos una duración para esperar a la animación
    await tester.pumpAndSettle(Duration(seconds: 3));


    final errorDialog = find.text('Error');
    expect(errorDialog, findsOneWidget);
  });

  testWidgets('Prueba de inicio de sesión incorrecto porque el usuario ha introducido mal la contraseña', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Busca el campo de usuario y escribe texto
    final userField = find.byType(TextField).at(0);
    await tester.enterText(userField, 'user');

    // Busca el campo de contraseña y escribe texto
    final passwordField = find.byType(TextField).at(1);
    await tester.enterText(passwordField, 'contraseña');

    // Presiona el botón de inicio de sesión
    final loginButton = find.byKey(Key('login_button'));
    await tester.tap(loginButton);

    // Espera hasta que la animación termine
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verifica si el diálogo de error aparece
    final errorDialog = find.text('Error');
    expect(errorDialog, findsOneWidget);
  });

}
