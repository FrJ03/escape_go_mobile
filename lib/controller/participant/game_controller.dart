import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class GameController{
  final String baseUrl = dotenv.env['BASEURL'] ?? 'NO BASEURL FOUND';
  Future<bool> register(String userEmail, int participationId, int escapeRoomId) async {
    final Object body = {
      'user_email': userEmail,
      'participation_id': participationId,
      'escape_room_id': escapeRoomId
    };

    final response = await http.post(Uri.parse('$baseUrl/game/register'), body: body);

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

// pide la siguiente pista del escape room
  Future<Clue?> getNextClue(BuildContext context,List<int> cluesIds, int escapeRoomId, int participationId) async {
    try {
      // Obtener el token del usuario autenticado
      final token = await _getToken();
      if (token == null) {
        throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
      }
      // URL del endpoint
      final url = Uri.parse('http://192.168.0.15:3000/game/clue');
      // Cuerpo de la solicitud
      final Object body = {
        'clues_ids': cluesIds,
        'escape_room_id': escapeRoomId,
        'participation_id': participationId,
      };
      // Encabezados para la autenticación y el contenido
      final headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };
      // Realizar la solicitud POST y convertir a JSON
      final response = await http.post(url,headers: headers,body: jsonEncode(body),
      );
      print(response.body);
      switch (response.statusCode) {
        case 200:
          // Decodifica el cuerpo de la respuesta porque la solicitud ha sido correcta
          final json = jsonDecode(response.body);
          return Clue.fromJson(json as Map<String, dynamic>);
        case 400:
          _showDialog(context,'Error','Error en solicitud: ${response.body}');
        case 401:
          _showDialog(context, 'Error', 'No eres participante.');

        case 404:
          _showDialog(context, 'Error', 'Escape Room no existe.');
        case 204:
          _showDialog(context, 'Error', 'No hay más pistas que mostrar.');


        default:
          _showDialog(context,'Error','Error inesperado: ${response.statusCode}');
      }
    } catch (e) {
      _showDialog(context,'Error','Hubo un error de conexión: $e');
    }
  }


  // Obtiene pista específica a partir de ID
  Future<Clue> getClue(int clueId, int escapeRoomId, int participationId) async {
    try {
      // Obtener el token del usuario autenticado
      final token = await _getToken();
      if (token == null) {
        throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
      }
      // ENDPOINT
      final url = Uri.parse('$baseUrl/game/clue/$clueId');
      // Cuerpo de la solicitud
      final Object body = {
        'clue_id': clueId,
        'escape_room_id': escapeRoomId,
        'participation_id': participationId,
      };
      // Encabezados
      final headers = {
        'Authorization': token,
        'Content-Type': 'application/json',
      };
      // SOLICITUD POST
      final response = await http.post(url,headers: headers,body: jsonEncode(body),
      );
      // RESPUESTAS
      switch (response.statusCode) {
        case 200:
          // CORRECTO
          final json = jsonDecode(response.body);
          return Clue.fromJson(json as Map<String, dynamic>);
        case 400:
          throw Exception('Error en solicitud: ${response.body}');
        case 401:
          throw Exception('No eres admin.');
        case 404:
          throw Exception('Escape Room no existe.');
        case 204:
          throw Exception('No hay más pistas que mostrar');
        default:
          throw Exception('Hubo un error inesperado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Hubo un error de conexión: $e');
    }
  }


  // Resuelve el escape room
    Future<int> solve(String solution, int escapeRoomId, int participationId) async {
      try {
        // Obtener el token del usuario autenticado
        final token = await _getToken();
        if (token == null) {
          throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
        }
        // ENDPOINT
        final url = Uri.parse('$baseUrl/game/solve');
        // Cuerpo de la solicitud
        final Object body = {
          'solution': solution,
          'escape_room_id': escapeRoomId,
  	      'participation_id': participationId,
        };
        // Encabezados
        final headers = {
          'Authorization': token,
          'Content-Type': 'application/json',
        };
        // SOLICITUD POST
        final response = await http.post(url,headers: headers,body: jsonEncode(body),
        );
        // RESPUESTAS
        print(response.body);
        switch (response.statusCode) {
          case 200:
            // CORRECTO
            final json = jsonDecode(response.body);
            return json['points'] as int;
          case 400:
            throw Exception('Error en solicitud: ${response.body}');
          case 401:
            throw Exception('No eres admin.');
          case 404:
            throw Exception('Escape Room no existe.');
  	      case 423:
            throw Exception('Participacion no iniciada o finalizada.');
          default:
            throw Exception('Hubo un error inesperado: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Hubo un error: $e');
      }
    }
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold)),
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

  
  /// Obtener el token almacenado
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}



// REPRESENTAR UNA CLUE
class Clue {
  final int id;
  final String title;
  final String info;

  Clue({
    required this.id,
    required this.title,
    required this.info,
  });

  // CREAR CLUE A PARTIR DE JSON
  factory Clue.fromJson(Map<String, dynamic> json) {
    return Clue(
      id: json['id'] as int,
      title: json['title'] as String,
      info: json['info'] as String,
    );
  }

}

