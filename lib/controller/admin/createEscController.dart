import 'package:flutter/material.dart';
import '../../view/admin/panel_admin.dart';
import '../../view/admin/create_escape2.dart';
class CreateEscController {
  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController solutionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<Map<String, dynamic>> infoEscape = [];

  Future<void> recoger(BuildContext context) async {
    String tittle = tittleController.text;
    String description = descriptionController.text;
    String level = levelController.text;
    String solution = solutionController.text;
    String price = priceController.text;



    if (tittle.isEmpty || description.isEmpty || level.isEmpty ||
        solution.isEmpty || price.isEmpty ) {
      _showDialog(context, 'Error', 'Por favor, completa todos los campos.');
      return;
    }
    else {
      infoEscape.add({
        'title': tittle,
        'description': description,
        'solution': solution,
        'difficulty':level,
        'price':price,
      }
      );
      tittleController.clear();
      descriptionController.clear();
      solutionController.clear();
      levelController.clear();
      priceController.clear();
      // Navega a la pantalla principal después de loguearse correctamente
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CreateEscapeRoomScreen()),
      );
    }
    }



  void _showDialog(
      BuildContext context,
      String tittle,
      String message, {
        VoidCallback? onConfirm, // Callback opcional
      }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          tittle,
          style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          if (onConfirm != null) // Muestra este botón solo si hay callback
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PanelScreen()),
                      (route) => false,
                );
              },
              child: Text('SÍ', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
             // Solo cierra el diálogo
            child: Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void confirmCancel(BuildContext context) {
    _showDialog(
      context,
      'Cancelar',
      '¿Estás seguro de que quieres cancelar el proceso?',
      onConfirm: () {
        Navigator.pop(context); // Cierra la pantalla
      },
    );
  }



  void _showSuccessDialog(BuildContext context, String tittle, String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(tittle, style: TextStyle(
                color: Color(0xFFA2F1A5), fontWeight: FontWeight.bold)),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                    'OK', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
    );
  }

}