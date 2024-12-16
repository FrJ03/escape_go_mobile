import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../controller/admin/modifyEscController.dart';

void main() {
  runApp(MaterialApp(
    home: ModifyEscapeScreen(),
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
  ));
}

class ModifyEscapeScreen extends StatelessWidget {
  final ModifyEscapeController controller = ModifyEscapeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modificar Escape Room',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: controller.tittleController,
                        decoration: InputDecoration(
                          hintText: 'Introduzca el título del Escape Room',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildRowWithLabelAndTextField(
                      context,
                      label: 'Descripción:',
                      controller: controller.descriptionController,
                      hintText: 'Introduzca una descripción',
                    ),
                    SizedBox(height: 16),
                    _buildRowWithLabelAndTextField(
                      context,
                      label: 'Nivel de dificultad:',
                      controller: controller.levelController,
                      hintText: 'Introduzca el nivel de dificultad',
                    ),
                    SizedBox(height: 16),
                    _buildRowWithLabelAndTextField(
                      context,
                      label: 'Solución :',
                      controller: controller.solutionController,
                      hintText: 'Introduzca la solución del Escape Room',
                    ),
                    SizedBox(height: 16),
                    _buildRowWithLabelAndTextField(
                      context,
                      label: 'Precio:',
                      controller: controller.priceController,
                      hintText: 'Introduzca el precio del Escape Room',
                    ),

                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    key: Key('modify_esc_button'),
                    value: 'SIGUIENTE',
                    color: Color(0xFFA2DAF1),
                    onPressed: () => controller.recoger(context),
                  ),
                  CustomButton(
                    key: Key('cancel_esc_button'),
                    value: 'CANCELAR',
                    color: Color(0xFFFFA1A1),
                    onPressed: () => controller.confirmCancel(context),

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRowWithLabelAndTextField(
      BuildContext context, {
        required String label,
        required TextEditingController controller,
        required String hintText,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Expanded(
          flex: 3, // Proporción para el texto
          child: Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 7, // Proporción para el campo de texto
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(

              ),
            ),
          ),
        ),
      ],
    );
  }
}

