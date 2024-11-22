import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/profileview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de cierre de sesión correcto', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Encuentra y presiona el botón de cerrar sesión
    final logoutButton = find.byKey(Key('logout_button'));
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump(); // Espera para asegurarte de que el diálogo está completamente cargado


    final cancelButton = find.widgetWithText(TextButton, 'Cerrar sesión');
    expect(cancelButton, findsOneWidget); // Asegúrate de que el botón existe
    await tester.tap(cancelButton);
    await tester.pumpAndSettle(); // Espera hasta que la animación del diálogo termine

    // Verifica que sigues en la pantalla de perfil
    final tittle = find.byKey(Key('Tittle'));
    expect(tittle, findsOneWidget);
  });

}