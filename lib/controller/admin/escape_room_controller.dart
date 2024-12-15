import 'package:escape_go_mobile/domain/escape_rooms/escape_room.dart';
import 'package:http/http.dart' as http;

class EscapeRoomController{
  Future<bool> create_escape_room(EscapeRoom escape_room) async {
    final Object body = {
      'title': escape_room.title,
      'description': escape_room.description,
      'solution': escape_room.solution,
      'difficulty': escape_room.difficulty,
      'price': escape_room.price,
      'maxSessionDuration': escape_room.maxSessionDuration,
      'location':{
        'country': escape_room.location.country,
        'city': escape_room.location.city,
        'street': escape_room.location.street,
        'street_number': escape_room.location.streetNumber,
        'coordinates': escape_room.location.coordinates,
        'info': escape_room.location.info
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
}