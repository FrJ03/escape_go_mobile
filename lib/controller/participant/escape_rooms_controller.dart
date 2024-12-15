import 'dart:convert';
import 'package:escape_go_mobile/domain/escape_room_list_item.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class EscapeRoomsController{
  Future<List<EscapeRoomListItem>> getEscapeRooms() async {
    Position position = await _getLocation();

    String coordinates = _positionToString(position);

    Object body = {
      coordinates: coordinates
    };

    http.Response response = await http.post(Uri.parse('http://localhost:3000/escaperoom/proximity'), body: body);

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      List<EscapeRoomListItem> list = [];

      for (final escapeRoom in json.escape_rooms){
        list.add(EscapeRoomListItem.fromJson(escapeRoom as Map<String, dynamic>));
      }

      return list;
    }
    else if(response.statusCode == 400 || response.statusCode == 500){
      return Future.error('Error<${response.statusCode}>: get escape rooms by distance');
    }
    else{
      return Future.error('Error<unknown>: get escape rooms by distance');
    }
  }
  String _positionToString(Position position){
    String latDir = (position.latitude > 0) ? 'N' : 'S';
    String longDir = (position.longitude > 0) ? 'E' : 'W';
    String str = "${position.latitude.toInt()}º ${_getMinutes(position.latitude)}'${_getSeconds(position.latitude)}\" $latDir, ${position.longitude.toInt()}º ${_getMinutes(position.longitude)}'${_getSeconds(position.longitude)}\" $longDir";

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
      return Future.error('Location permissions are permanentñy denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}