import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:escape_go_mobile/view/participant/escaperoomsview.dart';
import 'package:escape_go_mobile/view/admin/escaperoomsview.dart';


class LoginController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String baseUrl = 'http://192.168.0.15:3000'; // ¡Cambiar direccion IP!

  Future<void> login(BuildContext context) async {
    String email = nameController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showDialog(context, 'Error', 'Por favor, completa todos los campos.');
      return;
    }

    if (!isValidEmail(email)) {
      _showDialog(context, 'Error', 'Por favor, introduce un correo válido de Gmail.');
      return;
    }

    try {
      final response = await _loginWithServer(email, password);

      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodifica el JSON
        final token = data['token']; // Obtén el token
        final role = data['role'];
        if (token != null) {
          // Almacena el token de manera segura
          await saveToken(token);
          _showSuccessDialog(context, 'Correcto', 'Usuario logueado correctamente.');
          if(role=='participant'){
          // Navega a la pantalla principal
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EscapeRoomsScreen()),
          );}
          else if(role=='admin'){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EscapeRoomScreen()),
            );}

        } else {
          _showDialog(context, 'Error', 'No se recibió un token válido.');
        }
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

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return regex.hasMatch(email);
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold)),
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

  void _showSuccessDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: Color(0xFFA2F1A5), fontWeight: FontWeight.bold)),
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
