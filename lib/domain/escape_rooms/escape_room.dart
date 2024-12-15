import 'location.dart';

class EscapeRoom{
  final _id;
  final _title;
  final _description;
  final _solution;
  final _difficulty;
  final _price;
  final _maxSessionDuration;
  final _location;

  const EscapeRoom(
      this._id,
      this._title,
      this._description,
      this._solution,
      this._difficulty,
      this._price,
      this._maxSessionDuration,
      this._location
  );

  factory EscapeRoom.fromJson(Map<String, dynamic> json){
    return switch (json) {
      {
      'id': int id,
      'title': String title,
      'description': String description,
      'solution': String solution,
      'difficulty': int difficulty,
      'price': int price,
      'max_session_duration': int maxSessionDuration,
      'location': Map<String, dynamic> location
      } =>
          EscapeRoom(
              id,
              title,
              description,
              solution,
              difficulty,
              price,
              maxSessionDuration,
              Location.fromJson(location)
          ),
      _ => throw const FormatException('Failed to load escape room.'),
    };
  }

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get solution => _solution;
  int get difficulty => _difficulty;
  int get price => _price;
  int get maxSessionDuration => _maxSessionDuration;
  Location get location => _location;
}