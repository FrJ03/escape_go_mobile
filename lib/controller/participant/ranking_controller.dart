import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:escape_go_mobile/domain/user/user_ranking.dart';


class RankingController{
  final String baseUrl = dotenv.env['BASEURL'] ?? 'NO BASEURL FOUND';
  Future<List<User>> getUsers() async {
    try {
      final token = await _getToken(); // Recupera el token almacenado
      if (token == null) {
        throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
      }

      final url = Uri.parse('$baseUrl/ranking/'); // Ruta completa
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token, // Token para autenticación
      };

      final response = await http.get(url, headers: headers); // Realiza el request
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('JSON recibido: $json'); // Log para depuración

        List<User> list = [];
        for (final user in json) {
          // Cambiado para manejar el JSON como una lista
          list.add(User.fromJson(user as Map<String, dynamic>));
        }

        return list;
      } else if (response.statusCode == 400 || response.statusCode == 500) {
        return Future.error('Error<${response.statusCode}>: get escape rooms by distance');
      } else {
        return Future.error('Error<unknown>: get escape rooms by distance');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }


}
Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}