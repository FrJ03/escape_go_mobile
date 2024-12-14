import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:escape_go_mobile/view/escaperoomsview.dart';

class LoginController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String baseUrl = 'http://192.168.18.72:3000'; // ¡Cambiar direccion IP!

  Future<void> login(BuildContext context) async {
    String email = nameController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showDialog(context,'Error','Por favor, completa todos los campos.');
      return;
    }

    if (!isValidEmail(email)) {
      _showDialog(context,'Error','Por favor, introduce un correo válido de Gmail.');
      return;
    }

    try {
      final response = await _loginWithServer(email, password);

      if (response.statusCode == 200) {
        // Login exitoso
        _showSuccessDialog(context, 'Correcto', 'Usuario logueado correctamente.');
        
        // Navega a la pantalla principal después de loguearse correctamente
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EscapeRoomsScreen()),
        );

      } else if (response.statusCode == 401) {
        // Credenciales incorrectas
        _showDialog(context, 'Error', 'Credenciales incorrectas. Inténtalo de nuevo.');
      } else {
        // Otro error
        _showDialog(context, 'Error', 'Error al iniciar sesión: ${response.body}');
      }
    } catch (e) {
      _showDialog(context, 'Error', 'Error al conectar con el servidor: $e');
    }
  }

  Future<http.Response> _loginWithServer(String email, String password) async {
    final url = Uri.parse('$baseUrl/account/signin'); // Ruta para el login
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    return await http.post(url, headers: headers, body: body);
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return regex.hasMatch(email);
  }

  void _showDialog(BuildContext context,String tittle, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tittle, style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  void _showSuccessDialog(BuildContext context,String tittle, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tittle, style: TextStyle(color: Color(0xFFA2F1A5), fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
