import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../controller/participant/escape_room_data.dart';
import '../../controller/admin/deleteEscController.dart';

class DeleteEscapeRoomsScreen extends StatefulWidget {
  @override
  _DeleteEscapeRoomsScreenState createState() => _DeleteEscapeRoomsScreenState();
}

class _DeleteEscapeRoomsScreenState extends State<DeleteEscapeRoomsScreen> {
  final EscapeRoomController controller = EscapeRoomController();
  final Set<int> selectedRows = {};
  List<Map<String, String>> escapeRooms = [];
  bool isLoading = true; // Indica si estamos cargando datos
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEscapeRooms();
  }

  Future<void> _fetchEscapeRooms() async {
    // intenta tomar los datos de los escape rooms
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
      // se pone un simbolo de carga para simular que esta cargando los datos
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
                          final isSelected = selectedRows.contains(index);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedRows.remove(index);
                                } else {
                                  selectedRows.add(index);
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
                          backgroundColor: selectedRows.isNotEmpty
                              ? Color(0xFFFFA1A1)
                              : Colors.grey,
                        ),
                        onPressed: selectedRows.isNotEmpty
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
            'Vas a eliminar el Escape Room(s) seleccionado(s). ¿Estás seguro?'),
        actions: [
          TextButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
              try {
                // Obtiene IDS de seleccionados
                List<int> selectedIds = selectedRows.toList();
                // Llama al controlador para eliminar los seleccionados
                await controller.deleteEscapeRooms(selectedIds);
                // Actualiza el estado para eliminar visualmente
                setState(() {
                  escapeRooms.removeWhere((_, index) => selectedRows.contains(index));
                  selectedRows.clear();
                });
                // ÉXITO
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Escape Rooms eliminados con éxito')),
                );
              } catch (e) {
                // SI HUBO UN ERROR
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hubo un error desconocido')),
                );
              }
              setState(() {
                selectedRows.clear();
              });
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

class Row1 extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isSelected;

  Row1({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 70),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
