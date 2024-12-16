import 'package:flutter/material.dart';
import '../../view/admin/panel_admin.dart';

class ModifyEscapeController {


  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController solutionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<Map<String, dynamic>> infoEscape = [];

  //Simulamos que estos son los datos que hemos cogido al llamar al backend
  String tittle = 'Escapa de la mansión';
  String description = 'Escapa de la mansión en menos de media hora para conseguir un premio';
  String level = 'Intermedio';
  String solution = 'Se ha escapado de la mansión correctamente';
  String price = '492';


  Future<void> recoger(BuildContext context) async {

    if(tittleController.text.isNotEmpty) {
      tittle = tittleController.text;
    }
    if(descriptionController.text.isNotEmpty) {
      description = descriptionController.text;
    }
    if(levelController.text.isNotEmpty) {
      level = levelController.text;
    }
    if(solutionController.text.isNotEmpty) {
      solution = solutionController.text;
    }
    if(priceController.text.isNotEmpty) {
      price = priceController.text;
    }

      infoEscape.add({
        'title': tittle,
        'description': description,
        'solution': solution,
        'difficulty':level,
        'price':price,
      }
      );
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





