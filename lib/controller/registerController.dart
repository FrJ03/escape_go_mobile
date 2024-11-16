import 'package:flutter/material.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Future<void> register(BuildContext context) async {
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || password.isEmpty || email.isEmpty) {
      _showDialog(context,'Error','Por favor, completa todos los campos.');
      return;
    }
    if (!isValidEmail(email)) {
      _showDialog(context,'Error','Por favor, introduce un correo válido de Gmail.');
      return;
    }

    //Esto es temporal, para probar que funciona correctamente
    bool success = await _checking(email);
    if (success) {
      //Esto luego se hace llamando al servidor, pero de forma provisional se queda asi
      //si checking return success significa que se ha encontrado el correo.
      //No se puede registrar otra cuenta con el mismo correo
      _showDialog(context,'Error','Este correo ya existe.');
    }

    else {
      //Igual esto
      _showSuccessDialog(context, 'Correcto',' $name registrado correctamente.');

    }
  }

  Future<bool> _checking(String email) async {
    // Aquí iría la lógica para comunicarse con el servidor, la cual no está implementada todavía
    await Future.delayed(Duration(seconds: 2));  // Simula un tiempo de espera
    return email == 'user@gmail.com';
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return regex.hasMatch(email);
  }


  void _showDialog(BuildContext context, String tittle, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tittle, style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold,)),
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

void _showSuccessDialog(BuildContext context, String tittle, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(tittle, style: TextStyle(color: Color(0xFFA2F1A5), fontWeight: FontWeight.bold,)),
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
