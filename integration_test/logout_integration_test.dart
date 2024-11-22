import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/profileview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Prueba de cierre de sesión cancelado', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Encuentra y presiona el botón de cerrar sesión
    final logoutButton = find.byKey(Key('logout_button'));
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump(); // Espera para asegurarte de que el diálogo está completamente cargado

    // Encuentra y presiona el botón de 'Cancelar' en el diálogo
    final cancelButton = find.widgetWithText(TextButton, 'Cancelar');
    expect(cancelButton, findsOneWidget); // Asegúrate de que el botón existe
    await tester.tap(cancelButton);
    await tester.pumpAndSettle(); // Espera hasta que la animación del diálogo termine

    // Verifica que sigues en la pantalla de perfil
    final perfil = find.text('Mi perfil');
    expect(perfil, findsOneWidget);
  });

}
