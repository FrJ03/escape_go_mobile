import 'package:flutter/material.dart';
import '../../view/admin/panel_admin.dart';
//Voy a probar un mismo controlador para las dos vistas
class ModifyEscapeController {


  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController solutionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<Map<String, dynamic>> infoEscape = [];


  //Simulamos que estos son los datos que hemos cogido al llamar al backend
  //Hay que pasarle el id por url
  String id = '';
  String tittle = '';
  String description = '';
  String level = '';
  String solution = '';
  String price = '';


  Future<void> recoger(BuildContext context) async {
    tittle = tittleController.toString();
    description = descriptionController.toString();
    solution = solutionController.toString();
    level = levelController.toString();
    price = priceController.toString();

    //Esto es solo para ver si se modifica bien en el frontend
    _showDialog(context, 'Información del Escape', infoEscape.toString());
    tittleController.clear();
    descriptionController.clear();
    solutionController.clear();
    levelController.clear();
    priceController.clear();
    infoEscape.clear();
    //Falta la otra página de modificar
    //Navigator.push(context, route)

  }

  void confirmCancel(BuildContext context) {
    _showDialog(
      context,
      'Cancelar',
      '¿Estás seguro de que quieres cancelar el proceso?',
      onConfirm: () {
        Navigator.pop(context);
      },
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
              onPressed: () => Navigator.pop(context),
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







