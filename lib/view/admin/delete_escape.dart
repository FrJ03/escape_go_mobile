import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../controller/participant/escape_room_data.dart';
import '../../controller/admin/escape_room_controller.dart';

class _DeleteEscapeRoomsScreenState extends State<DeleteEscapeRoomsScreen> {
  final EscapeRoomController controller = EscapeRoomController();
  int? selectedRowIndex; // Cambiado a un solo índice
  List<Map<String, String>> escapeRooms = [];
  bool isLoading = true; // Indica si estamos cargando datos
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEscapeRooms();
  }

  Future<void> _fetchEscapeRooms() async {
    try {
      final rooms = await controller.fetchEscapeRoomDetails();
      setState(() {
        escapeRooms = rooms;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error al cargar los escape rooms: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Escape Rooms',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: escapeRooms.length,
                        itemBuilder: (context, index) {
                          final room = escapeRooms[index];
                          final isSelected = selectedRowIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // Alterna selección única
                                if (isSelected) {
                                  selectedRowIndex = null; // Deselecciona
                                } else {
                                  selectedRowIndex = index; // Selecciona
                                }
                              });
                            },
                            child: Row1(
                              title: room['title']!,
                              description: room['description']!,
                              imagePath: room['imagePath']!,
                              isSelected: isSelected,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedRowIndex != null
                              ? Color(0xFFFFA1A1)
                              : Colors.grey,
                        ),
                        onPressed: selectedRowIndex != null
                            ? () => _showDeleteDialog(context)
                            : null,
                        child: Text('Eliminar'),
                      ),
                    ),
                  ],
                ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'AVISO',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFFFA1A1), fontWeight: FontWeight.bold),
        ),
        content: Text(
            'Vas a eliminar el Escape Room seleccionado. ¿Estás seguro?'),
        actions: [
          TextButton(
            onPressed: () async {
              if (selectedRowIndex != null) {
                try {
                  // Llama al controlador para eliminar el seleccionado
                  final selectedId = selectedRowIndex!;
                  await controller.deleteEscapeRoom([selectedId]);
                  // Actualiza el estado para eliminar visualmente
                  setState(() {
                    escapeRooms.removeAt(selectedRowIndex!);
                    selectedRowIndex = null;
                  });

                  // ÉXITO
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Escape Room eliminado con éxito')),
                  );
                } catch (e) {
                  // SI HUBO UN ERROR
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hubo un error desconocido')),
                  );
                }
              }
              Navigator.pop(context);
            },
            child: Text('Eliminar', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
