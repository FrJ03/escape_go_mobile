import 'package:flutter/material.dart';

class EscapeRoomController {
  // SIMULACION DE SOLICITAR DATOS A LA API
  Future<Map<String, dynamic>> fetchEscapeRoomDetails() async {
    // SIMULA UN RETRASO PARA DAR TIEMPO
    await Future.delayed(Duration(seconds: 2));

    // SIMULACION DE DATOS OBTENIDOS DEL BACKEND, DUMMY TEXT
    return {
      'title': 'Escapa de la mansión',
      'description': 'Escapa de la mansión antes de que termine el tiempo.',
      'objective': 'Escapar.',
      'difficulty': 'Intermedio',
      'warnings': 'Nada.',
      'prize': '20 puntos.',
      'timeLimit': '60 minutos',
      'imagePath': 'lib/view/assets/logo.png',
    };
  }
}


/**
EJEMPLO DE LLAMADA A LA API USANDO UNA URL, BORRAR CUANDO SE AÑADA LA LLAMADA REAL

import 'dart:convert';
import 'package:http/http.dart' as http;

class EscapeRoomController {
  Future<Map<String, dynamic>> fetchEscapeRoomDetails() async {
    final response = await http.get(Uri.parse('https://api.example.com/escape-room/1'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}

**/
