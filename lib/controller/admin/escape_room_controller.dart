import 'package:escape_go_mobile/domain/escape_rooms/escape_room.dart';
import 'package:http/http.dart' as http;
import 'package:escape_go_mobile/domain/escape_rooms/escape_room_list_item.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class EscapeRoomController{
  final String baseUrl = 'http://192.168.0.15:3000'; // Cambia la IP si es necesario.
  Future<bool> createEscapeRoom(EscapeRoom escapeRoom) async {
    final Object body = {
      'title': escapeRoom.title,
      'description': escapeRoom.description,
      'solution': escapeRoom.solution,
      'difficulty': escapeRoom.difficulty,
      'price': escapeRoom.price,
      'maxSessionDuration': escapeRoom.maxSessionDuration,
      'location':{
        'country': escapeRoom.location.country,
        'city': escapeRoom.location.city,
        'street': escapeRoom.location.street,
        'street_number': escapeRoom.location.streetNumber,
        'coordinates': escapeRoom.location.coordinates,
        'info': escapeRoom.location.info
      }
    };
    
    final response = await http.post(Uri.parse('http://192.168.18.72:3000/escaperoom/create'), body: body);

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> deleteEscapeRoom(int id) async {
    final response = await http.delete(Uri.parse('http://192.168.18.72:3000/escaperoom/admin/create?id=$id'));

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

  Future<List<EscapeRoomListItem>> getEscapeRooms() async {
    try {
      final token = await _getToken(); // Recupera el token almacenado
      if (token == null) {
        throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
      }

      final url = Uri.parse('$baseUrl/escaperoom/admin/'); // Ruta completa
      final headers = {
        'Authorization': token, // Token para autenticación
      };


      final response = await http.get(url, headers: headers); //Se está mandando el request y esperando el response

        final json = jsonDecode(response.body);
        List<EscapeRoomListItem> list = [];

        for (final escapeRoom in json['escape_rooms']) {
          list.add(EscapeRoomListItem.fromJson(escapeRoom as Map<String, dynamic>));
        }

        return list;

    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Obtener el token almacenado
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}