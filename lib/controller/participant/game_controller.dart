import 'package:http/http.dart' as http;

class GameController{
  Future<bool> register(String userEmail, int participationId, int escapeRoomId) async {
    final Object body = {
      'user_email': userEmail,
      'participation_id': participationId,
      'escape_room_id': escapeRoomId
    };

    final response = await http.post(Uri.parse('http://localhost:3000/game/register'), body: body);

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
}