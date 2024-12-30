import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/escape_rooms/escape_room.dart'; //escape_room model
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EscapeRoomInfoViewController{

  final String baseUrl = dotenv.env['BASEURL'] ?? 'NO BASEURL FOUND';

  Future<EscapeRoom>getEscapeRoomInfoById(String id) async { //una funcion para devolver el escape_room con toda su info y luego mostrarlo en el view

    final token = await _getToken();
    if(token == null){
      throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
    }


    final url = Uri.parse('$baseUrl/escaperoom/participant/info/$id'); //URL endpoint getInfo APIparticipant

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token, // Token para autenticación
    };

    final response = await http.get(url, headers: headers);

    if(response.statusCode == 200){ //si se obtiene correctamente lo retornamos a la vista para mostrar la info

      final json = jsonDecode(response.body);
      final escapeRoom = EscapeRoom.fromJson(json);

      return escapeRoom;

    }
    else{

      return Future.error('Error<${response.statusCode}>: getEscapeRoomInfoById');

    }

  }

}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}