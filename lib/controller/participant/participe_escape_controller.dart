
import 'package:flutter/material.dart';

class ParticipateEscController {

  //En un futuro se llamara al servidor para pedir estos datos
  //Pero mientras utilizaremos estos datos de prueba
  final String tittle = 'Escapa de la mansión';
  final String description = '¡Escapa de una escalofriante mansión antes de morir congelado!';
  final  String level = 'Avanzado';
  final String solution = 'Solución ';
  final int price = 245;
  //Sesiones
  //Aqui iría la llamada a la API
  final List<DateTime> dates = [];
  // Constructor para inicializar la lista con una fecha
  ParticipateEscController() {
    dates.add(DateTime(2024, 1, 1));
    dates.add(DateTime(2024, 3, 23));
  }
  Widget buildSessionTile({
    required DateTime session,
    required DateTime? selectedSession,
    required ValueChanged<DateTime?> onSelected,
  }) {
    final formattedDate =
        "${session.year}-${session.month.toString().padLeft(2, '0')}-${session.day.toString().padLeft(2, '0')}";

    return ListTile(
      title: Text(formattedDate),
      leading: Radio<DateTime>(
        value: session,
        groupValue: selectedSession,
        onChanged: onSelected, // Se llama al callback al seleccionar
      ),
    );
  }


   Future <void> participe(BuildContext context) async{
     _showDialog(context, 'Participar', '¿Estás seguro de que quieres participar?');
  }





  void _showDialog(
      BuildContext context,
      String tittle,
      String message, {
        VoidCallback? onConfirm, // Callback opcional
      }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          tittle,
          style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          TextButton(
              //Si le da a que si se llevará al participante a la pantalla con la pista
                onPressed: () => Navigator.pop(context),
                //FocusScope.of(context).unfocus();
                //Navigator.pushAndRemoveUntil(
                  //context,
                  //MaterialPageRoute(builder: (context) => PanelScreen()),
                      //(route) => false,
                //);

              child: Text('SÍ', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            // Solo cierra el diálogo
            child: Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

