import 'location.dart';

class EscapeRoomListItem{
  final id;
  final title;
  final location;

  const EscapeRoomListItem({
    required this.id,
    required this.title,
    required this.location
  });

  factory EscapeRoomListItem.fromJson(Map<String, dynamic> json){
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'location': Map<String, dynamic> location
      } =>
        EscapeRoomListItem(
          id: id,
          title: title,
          location: Location.fromJson(location)
        ),
      _ => throw const FormatException('Failed to load escape room list item.'),
      };
  }
}