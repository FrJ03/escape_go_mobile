import 'package:escape_go_mobile/view/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:escape_go_mobile/view/loginview.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('Prueba cierre de sesión exitoso', (WidgetTester tester) async {
    //inicia app y entra al perfil
    app.main();
    final perfil = find.text('mi perfil');
    await tester.tap(perfil);

    await tester.pumpAndSettle();
    //encuentra y presiona el boton de cerrar sesion
    final logoutButton = find.byKey(Key('logout_button'));
    await tester.tap(logoutButton);
    //encuentra y presiona el boton que sale en el alert dialog
    final logoutButton2 = find.widgetWithText(TextButton, 'Cerrar sesión');
    await tester.tap(logoutButton2);
    //tiempo 3 segundos
    await tester.pumpAndSettle(Duration(seconds: 3));
    //si obtiene este texto, ha cerrado sesion correctamente
    final successDialog = find.text('Sesión cerrada');
    expect(successDialog, findsOneWidget)
  });

  testWidgets('Prueba de cierre de sesión cancelado', (WidgetTester tester) async {
    //inicia app y entra al perfil
    app.main();
    final perfil = find.text('mi perfil');
    await tester.tap(perfil);

    await tester.pumpAndSettle();
    //encuentra y presiona el boton de cerrar sesion
    final logoutButton = find.byKey(Key('logout_button'));
    await tester.tap(logoutButton);
    //encuentra y presiona el boton que sale en el alert dialog
    final logoutButton2 = find.widgetWithText(TextButton, 'Cancelar');
    await tester.tap(logoutButton2);
    //tiempo 3 segundos
    await tester.pumpAndSettle(Duration(seconds: 3));
    //si obtiene este texto, no ha cancelado el cierre de sesion y falla la prueba
    final errorDialog = find.text('Sesión cerrada');
    expect(errorDialog, findsOneWidget)
  });
}
