import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../controller/admin/createEscController2.dart';

void main() {
  runApp(MaterialApp(
    home: CreateEscapeRoomScreen(),
    theme: ThemeData(fontFamily: 'Roboto'),
  ));
}


class CreateEscapeRoomScreen extends StatefulWidget {
  @override
  _CreateEscapeRoomScreenState createState() => _CreateEscapeRoomScreenState();
}

class _CreateEscapeRoomScreenState extends State<CreateEscapeRoomScreen> {
  final EscapeRoomController controller = EscapeRoomController();
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    controller.storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Escape Room',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Historia:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: controller.storyController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Escribe la historia del fragmento...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: controller.requiresNFC,
                    onChanged: (value) {
                      setState(() {
                        controller.requiresNFC = value!;
                      });
                    },
                  ),
                  Text('¿Es necesario escanear un tag NFC?'),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: CustomButton(
                  value: 'GUARDAR FRAGMENTO',
                  color: Color(0xFFA2F1A5),
                  onPressed: () => setState(() {
                    controller.addFragment(() {
                      _showDialog('Error', 'El campo de historia está vacío.');
                    });
                  }),
                ),
              ),

              SizedBox(height: 16),
              Text(
                'Fragmentos creados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...controller.fragments.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> fragment = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    child: ListTile(
                      title: Text('Fragmento ${index + 1}'),
                      subtitle: Text(
                        '${fragment['story']}\nRequiere NFC: ${fragment['requiresNFC'] ? 'Sí' : 'No'}',
                      ),
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    value: 'CANCELAR',
                    color: Color(0xFFFFA1A1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    value: 'CREAR',
                    color: Color(0xFFA2F1A5),
                    onPressed: () {
                      _showDialog('Crear Escape Room', 'Escape Room creado exitosamente.');
                      //Aqui se llamará a la función de recoger los fragmentos
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
