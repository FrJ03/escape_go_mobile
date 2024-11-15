import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String value;
  final Color color;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.value,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Color de fondo del botón
          foregroundColor: Colors.black, // Color del texto
          padding: const EdgeInsets.all(12),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
