import 'package:escape_go_mobile/view/admin/modify_escape.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
//Este test de integración es solo para modificar la información del Escape

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Prueba de modificar informacion exitoso', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Busca el campo de titulo y escribe texto
    final tittleField = find.byType(TextField).at(0);
    await tester.enterText(tittleField, 'tittle');

    // Busca el campo de descripción y escribe texto
    final descriptionField = find.byType(TextField).at(1);
    await tester.enterText(descriptionField, 'description');

    // Busca el campo de nivel de dificultad y escribe texto
    final levelField = find.byType(TextField).at(2);
    await tester.enterText(levelField, 'level');

    // Busca el campo de solución y escribe texto
    final solutionField = find.byType(TextField).at(3);
    await tester.enterText(solutionField, 'solution');

    // Busca el campo de solución y escribe texto
    final priceField = find.byType(TextField).at(4);
    await tester.enterText(priceField, '234');
    // Presiona el botón de siguiente
    final modifyButton = find.byKey(Key('modify_esc_button'));
    await tester.tap(modifyButton);
    await tester.pumpAndSettle(Duration(seconds: 3));
    // Verifica si el diálogo de éxito aparece
    final successDialog = find.text('Información del Escape');
    expect(successDialog, findsOneWidget);

  });

  testWidgets('Prueba de modificar informacion cancelado', (WidgetTester tester) async {
    // Inicia la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Busca el campo de titulo y escribe texto
    final tittleField = find.byType(TextField).at(0);
    await tester.enterText(tittleField, 'tittle');

    // Busca el campo de descripción y escribe texto
    final descriptionField = find.byType(TextField).at(1);
    await tester.enterText(descriptionField, 'description');

    // Busca el campo de nivel de dificultad y escribe texto
    final levelField = find.byType(TextField).at(2);
    await tester.enterText(levelField, 'level');

    // Busca el campo de solución y escribe texto
    final solutionField = find.byType(TextField).at(3);
    await tester.enterText(solutionField, 'solution');

    // Busca el campo de solución y escribe texto
    final priceField = find.byType(TextField).at(4);
    await tester.enterText(priceField, '234');
    // Presiona el botón de cancelar
    final modifyButton = find.byKey(Key('cancel_esc_button'));
    await tester.tap(modifyButton);
    await tester.pumpAndSettle(Duration(seconds: 3));
    // Verifica si el diálogo de cancelar aparece
    final cancelDialog = find.text('Cancelar');
    expect(cancelDialog, findsOneWidget);



  });

}