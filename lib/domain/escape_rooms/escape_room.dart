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

  factory EscapeRoom.fromJson(Map<String, dynamic> json) {
    try {
      final escapeRoomJson = json['escape_room'] as Map<String, dynamic>;
      return EscapeRoom(
        escapeRoomJson['id'] as int,
        escapeRoomJson['title'] as String,
        escapeRoomJson['description'] as String,
        escapeRoomJson['solution'] ?? '', // Opcional
        escapeRoomJson['difficulty'] as int,
        escapeRoomJson['price'] as int,
        escapeRoomJson['maxSessionDuration'] as int,
        Location.fromJson(escapeRoomJson['location'] as Map<String, dynamic>),
      );
    } catch (e) {
      throw FormatException('Failed to load escape room: $e');
    }
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