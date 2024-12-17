import 'package:flutter/material.dart';

class EscapeRoomController {
  // SIMULACION DE SOLICITAR DATOS A LA API
  Future<Map<String, dynamic>> fetchEscapeRoomDetails() async {
    // SIMULA UN RETRASO PARA DAR TIEMPO
    await Future.delayed(Duration(seconds: 2));

    // SIMULACION DE DATOS OBTENIDOS DEL BACKEND, DUMMY TEXT
    return [
      {
        'id': 1,
        'title': 'Escapa de la mansión',
        'description': 'Descripción del Escape Room 1 muy larga para ver como funciona lo de cortar las descripciones largas porque si el texto es muy largo llena mucho la pantalla asi que se deja como maximo que la descripcion ocupe 3 lineas asi que a ver si recorta esta descripcion y como se ve',
        'imagePath': 'lib/view/assets/logo.png',
      },
      {
        'id': 2,
        'title': 'Escape Room 2',
        'description': 'Descripción del Escape Room 2 más cortita',
        'imagePath': 'lib/view/assets/logo.png',
      },
    ];
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
