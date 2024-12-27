import 'package:flutter/material.dart';
import '../../view/admin/panel_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModifyEscapeController {
  final String baseUrl = 'http://192.168.0.15:3000'; // Cambia la IP si es necesario.

  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController solutionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  List<Map<String, dynamic>> infoEscape = [];

  // Variables iniciales
  String id = '';
  String tittle = '';
  String description = '';
  String level = '';
  String solution = '';
  String price = '';

  Future<void> recoger(BuildContext context, String id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
    }

    // Capturar valores reales desde los controladores
    tittle = tittleController.text.trim();
    description = descriptionController.text.trim();
    solution = solutionController.text.trim();
    level = levelController.text.trim();
    price = priceController.text.trim();



    // Convertir valores
    int? difficulty = int.tryParse(level);
    double? parsedPrice = double.tryParse(price);
    int? identify = int.tryParse(id);

    final escapeRoomData = {
      'id': identify,
      'title': tittle,
      'description': description,
      'solution': solution,
      'difficulty': difficulty,
      'price': parsedPrice,
    };

    await _modifyEscapeRoom(context, escapeRoomData);

    // Limpiar controladores
    tittleController.clear();
    descriptionController.clear();
    solutionController.clear();
    levelController.clear();
    priceController.clear();
  }

  Future<void> _modifyEscapeRoom(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final token = await _getToken(); // Recupera el token almacenado
      if (token == null) {
        throw Exception(
            'No se encontró un token válido. Inicia sesión nuevamente.');
      }

      final url = Uri.parse('$baseUrl/escaperoom/admin/modify'); // Ruta completa
      final headers = {
        'Authorization': token, // Token para autenticación
        'Content-Type': 'application/json', // Especifica que el cuerpo es JSON
      };

      final body = json.encode(data);
      print(body); // Para depuración
      final response =
      await http.put(url, headers: headers, body: body); // Realiza el request

      if (response.statusCode == 200) {
        _showSuccessDialog(context, 'Éxito', 'Escape Room modificado con éxito.');
      } else {
        _showDialog(context, 'Error',
            'Error al modificar el Escape Room: ${response.body}');
      }
    } catch (e) {
      _showDialog(
          context, 'Error de conexión', 'Hubo un problema con la conexión: $e');
    }
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

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
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

  void _showSuccessDialog(BuildContext context, String tittle, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          tittle,
          style: TextStyle(color: Color(0xFFA2F1A5), fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
