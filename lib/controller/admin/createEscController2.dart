import 'package:flutter/material.dart';


class EscapeRoomController {
  final TextEditingController storyController = TextEditingController();
  bool requiresNFC = false;
  List<Map<String, dynamic>> fragments = [];

  void addFragment(Function showError) {
    if (storyController.text.isNotEmpty) {
      fragments.add({
        'story': storyController.text,
        'requiresNFC': requiresNFC,
      });
      storyController.clear();
      requiresNFC = false;
    } else {
      showError();
    }
  }
}
