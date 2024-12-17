import 'dart:async';

class EscapeRoomController {
  // Simula una llamada para eliminar escape rooms en el backend
  // SUSTITUIR POR LLAMADA REAL A LA API
  Future<void> deleteEscapeRooms(List<int> roomIds) async {
    // SIMULACION DE TARDAR EN RECIBIR LOS DATOS PARA QUE PAREZCA REAL
    await Future.delayed(Duration(seconds: 1));
    print('Se han eliminado los escape rooms con IDs: $roomIds');
  }
}
