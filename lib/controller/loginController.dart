import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    String name = nameController.text;
    String password = passwordController.text;

    if (name.isEmpty || password.isEmpty) {
      _showDialog(context,'Error','Por favor, completa todos los campos.');
      return;
    }

    //Esto es temporal, para probar que funciona correctamente
    bool success = await _authenticate(name, password);
    if (success) {
      _showSuccessDialog(context,'Correcto',"Usuario logueado correctamente");
    }

    else {
      _showDialog(context,'Error','Credenciales incorrectas. Inténtalo de nuevo.');
    }
  }

  Future<bool> _authenticate(String name, String password) async {
    // Aquí iría la lógica para comunicarse con el servidor, la cual no está implementada todavía
    await Future.delayed(Duration(seconds: 2));  // Simula un tiempo de espera
    return name == 'user' && password == 'password';
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
