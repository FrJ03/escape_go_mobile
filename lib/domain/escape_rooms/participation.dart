import 'package:escape_go_mobile/domain/escape_rooms/escape_room.dart';

class Participation{
  final int _id;
  final EscapeRoom _escapeRoom;
  final _startDate;
  final _endDate;
  final int _points;

  const Participation(
      this._id,
      this._escapeRoom,
      this._startDate,
      this._endDate,
      this._points
      );

  factory Participation.fromJson(Map<String, dynamic> json){
    return switch (json) {
      {
      'id': int id,
      'escape_room': Map<String, dynamic> escapeRoom,
      'start_date': String startDate,
      'end_date': String endDate,
      'points': int points
      } =>
          Participation(
              id,
              EscapeRoom.fromJson(escapeRoom),
              startDate,
              endDate,
              points
          ),
      _ => throw const FormatException('Failed to load participation.'),
    };
  }

  int get id => _id;
  EscapeRoom get title => _escapeRoom;
  String get description => _startDate;
  String get solution => _endDate;
  int get difficulty => _points;
}