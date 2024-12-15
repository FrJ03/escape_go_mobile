import 'package:escape_go_mobile/domain/escape_rooms/escape_room.dart';
import 'package:http/http.dart' as http;

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
    
    final response = await http.post(Uri.parse('http://localhost:3000/escaperoom/create'), body: body);

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> deleteEscapeRoom(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:3000/escaperoom/create?id=$id'));

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
}