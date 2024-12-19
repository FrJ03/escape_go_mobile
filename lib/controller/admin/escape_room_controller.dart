import 'package:escape_go_mobile/domain/escape_rooms/escape_room.dart';
import 'package:http/http.dart' as http;
import 'package:escape_go_mobile/domain/escape_rooms/escape_room_list_item.dart';
import 'dart:convert';


class EscapeRoomController{
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
      final response = await http.get(Uri.parse('http://192.168.18.72:3000/escaperoom/admin'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Mapea la respuesta a objetos de tipo EscapeRoomListItem
        return data.map((json) => EscapeRoomListItem.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener escape rooms: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }


}