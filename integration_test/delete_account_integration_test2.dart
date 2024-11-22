import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/profileview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Prueba de eliminar cuenta ', (WidgetTester tester) async {
  // Inicia la aplicación
  app.main();
  await tester.pumpAndSettle();

  // Encuentra y presiona el botón de eliminar cuenta
  final deleteButton = find.byKey(Key('delete_account_button'));
  expect(deleteButton, findsOneWidget);
  await tester.tap(deleteButton);
  await tester.pump(); // Espera para asegurarte de que el diálogo está completamente cargado

  // Encuentra y presiona el botón de 'Eliminar cuenta' en el diálogo
  final cancelButton = find.widgetWithText(TextButton, 'Eliminar cuenta');
  expect(cancelButton, findsOneWidget); // Asegúrate de que el botón existe
  await tester.tap(cancelButton);
  await tester.pumpAndSettle(); // Espera hasta que la animación del diálogo termine

  // Verifica que estás en la pantalla de iniciar sesión
  final tittle = find.byKey(Key('Tittle'));
  expect(tittle, findsOneWidget);
  });

}