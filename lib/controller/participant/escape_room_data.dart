import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EscapeRoomController {
  final String baseUrl = 'http://192.168.0.15:3000'; // Cambia la IP si es necesario.

  /// Fetch escape rooms by proximity
  Future<List<Map<String, dynamic>>> fetchEscapeRoomsByProximity(
      String coordinates) async {
    coordinates='0º 30\'30\" N, 0º 30\'30\" N';
    try {
      final token = await _getToken(); // Recupera el token almacenado
      if (token == null) {
        throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
      }

      final url =
      Uri.parse('$baseUrl/escaperoom/participant/proximity'); // Ruta completa
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token', // Token para autenticación
      };
      final body = jsonEncode({
        'coordinates': coordinates, // Enviar coordenadas en el cuerpo

      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data['escape_rooms'] is List) {
          return List<Map<String, dynamic>>.from(data['escape_rooms']); // Extrae escape_rooms
        } else {
          throw Exception('Respuesta inválida del servidor.');
        }
      } else {
        throw Exception(
            'Error al obtener los Escape Rooms por cercanía: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }

  /// Obtener el token almacenado
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}


