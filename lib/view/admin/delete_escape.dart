import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: DeleteEscapeRoomsScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

// stateful para cambiar el estado y que se muestren seleccionados
class DeleteEscapeRoomsScreen extends StatefulWidget {
  @override
  _DeleteEscapeRoomsScreenState createState() => _DeleteEscapeRoomsScreenState();
}

class _DeleteEscapeRoomsScreenState extends State<DeleteEscapeRoomsScreen> {
  // Lista para rastrear los IDs seleccionados
  final Set<int> selectedRows = {};

  // Lista con DATOS DE EJEMPLO de escape rooms, tomar datos de los escape rooms que hayan sido creados por el usuario
  final List<Map<String, String>> escapeRooms = [
    {
      'title': 'Escape Room 1',
      'description': 'Descripción del Escape Room aqui se pone la descripcion y si hay mucho texto lo limita para que no se pase la pantalla porque si hay mucho texto es un rollo',
      'imagePath': 'lib/view/assets/logo.png',
    },
    {
      'title': 'Escape Room 2',
      'description': 'Descripción del Escape Room 2 más cortita',
      'imagePath': 'lib/view/assets/logo.png',
    },
  ];

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: escapeRooms.length,
              itemBuilder: (context, index) {
                final room = escapeRooms[index];
                final isSelected = selectedRows.contains(index);
                // detecta que se ha seleccionado un escape room
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
            'Vas a eliminar el Escape Room seleccionado. ¿Estás seguro?'),
        actions: [
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                selectedRows.clear();
              });
              // ELIMINAR EL ESCAPE ROOM
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
                  overflow: TextOverflow.ellipsis, // Limita texto largo
                  maxLines: 3, // Número máximo de líneas visibles
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
