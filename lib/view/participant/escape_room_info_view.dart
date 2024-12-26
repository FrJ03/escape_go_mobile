import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../controller/participant/escape_room_info_view_controller.dart';

void main() {
  runApp(MaterialApp(
    home: EscapeRoomInfoView(id: ''),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class EscapeRoomInfoView extends StatelessWidget{

  final String id;
  final EscapeRoomInfoViewController controller = EscapeRoomInfoViewController();

  EscapeRoomInfoView({super.key, required this.id});

  @override
  Widget build(BuildContext context){

    return Scaffold();

  }

}