import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../domain/escape_rooms/escape_room.dart'; //escape_room model
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ParticipateEscController {
  final String baseUrl = dotenv.env['BASEURL'] ?? 'NO BASEURL FOUND';
  Future<EscapeRoom> getEscapeRoomInfoById(String id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
    }

    final url = Uri.parse('$baseUrl/escaperoom/participant/info/$id');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['escape_room'] == null) {
        throw Exception('Datos del escape room no encontrados.');
      }
      return EscapeRoom.fromJson(json);
    } else {
      throw Exception('Error<${response.statusCode}>: ${response.body}');
    }
  }


  Future <void> participe(BuildContext context) async {
    _showDialog(
        context, 'Participar', '¿Estás seguro de que quieres participar?');
  }
}


  void _showDialog(BuildContext context,
      String tittle,
      String message, {
        VoidCallback? onConfirm, // Callback opcional
      }) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(
              tittle,
              style: TextStyle(
                  color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
            ),
            content: Text(message),
            actions: [
              TextButton(
                //Si le da a que si se llevará al participante a la pantalla con la pista
                onPressed: () => Navigator.pop(context),
                //FocusScope.of(context).unfocus();
                //Navigator.pushAndRemoveUntil(
                //context,
                //MaterialPageRoute(builder: (context) => PanelScreen()),
                //(route) => false,
                //);

                child: Text(
                    'SÍ', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                // Solo cierra el diálogo
                child: Text(
                    'NO', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
    );
  }
Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}



