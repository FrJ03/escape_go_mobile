import 'dart:convert';
import 'package:escape_go_mobile/domain/escape_rooms/escape_room.dart';
import 'package:escape_go_mobile/domain/escape_rooms/escape_room_list_item.dart';
import 'package:escape_go_mobile/domain/escape_rooms/participation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class EscapeRoomsController{
  final String baseUrl = dotenv.env['BASEURL'] ?? 'NO BASEURL FOUND';

  Future<List<EscapeRoomListItem>> getEscapeRooms() async {
    try {
      Position position = await _getLocation();
      String coordinates = _positionToString(position);

      print(coordinates);
      //Tenemos que saber parsear las coordenadas
      final token = await _getToken(); // Recupera el token almacenado
      if (token == null) {
        throw Exception('No se encontró un token válido. Inicia sesión nuevamente.');
      }

      final url = Uri.parse('$baseUrl/escaperoom/participant/proximity'); // Ruta completa
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token, // Token para autenticación
      };
      final body = jsonEncode({
        'coordinates': coordinates, // Enviar coordenadas en el cuerpo

      });
      print(body);

      final response = await http.post(url, headers: headers, body: body); //Se está mandando el request y esperando el response
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      List<EscapeRoomListItem> list = [];

      for (final escapeRoom in json['escape_rooms']) {
        list.add(EscapeRoomListItem.fromJson(escapeRoom as Map<String, dynamic>));
      }

      return list;
    }
    else if(response.statusCode == 400 || response.statusCode == 500){ //Error 400 es error por coordenadas
      return Future.error('Error<${response.statusCode}>: get escape rooms by distance');
    }
    else{
      return Future.error('Error<unknown>: get escape rooms by distance');
    }
  }
    catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }






  Future<(EscapeRoom, List<Participation>)> getEscapeRoom(int id) async {
    http.Response response = await http.get(Uri.parse('$baseUrl/escaperoom/info?id=$id'));

    if(response.statusCode == 200){
      final escapeRoom = EscapeRoom.fromJson(jsonDecode(response.body).escape_room as Map<String, dynamic>);
      List<Participation> participationList = [];

      final json = jsonDecode(response.body);

      for (final participation in json.participations){
        participationList.add(Participation.fromJson(participation as Map<String, dynamic>));
      }

      return (escapeRoom, participationList);
    }
    else if(response.statusCode == 400 || response.statusCode == 404){
      return Future.error('Error<${response.statusCode}>: get escape rooms by distance');
    }
    else{
      return Future.error('Error<unknown>: get escape rooms by distance');
    }
  }
  String _positionToString(Position position){
    double pos_lat = (position.latitude > 0) ? position.latitude : 0 - position.latitude;
    double pos_lon = (position.longitude > 0) ? position.longitude : 0 - position.longitude;
    
    String quotes = utf8.decode([0x22]);

    String latDir = (position.latitude > 0) ? 'N' : 'S';
    String longDir = (position.longitude > 0) ? 'E' : 'W';

    String str = "${pos_lat.toInt()}º ${_getMinutes(pos_lat)}'${_getSeconds(pos_lat)}${quotes} $latDir, ${pos_lon.toInt()}º ${_getMinutes(pos_lon)}'${_getSeconds(pos_lon)}${quotes} $longDir";

    return str;
  }
  int _getMinutes(double value){
    double diff = value - value.toInt();

    return (diff * 60).toInt();
  }
  int _getSeconds(double value){
    double diffMinutes = value - value.toInt();
    double minutes = diffMinutes * 60;
    double diffSeconds = minutes - minutes.toInt();

    return (diffSeconds * 60).toInt();
  }
  Future<Position> _getLocation() async{
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable){
      return Future.error('Error: Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Location permissions are permanenty denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
  /// Obtener el token almacenado
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

}
