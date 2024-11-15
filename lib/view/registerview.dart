import 'package:escape_go_mobile/view/loginview.dart';
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escape Go',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        backgroundColor: Color(0xFFA2DAF1),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        color: const Color(0xFFE7E0EC),
        child:

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(child:Image.asset('lib/view/assets/logo.png',height: 150)),
            Center(
              child:
              Text('Registrarse',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 30),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto y el campo de entrada a la izquierda dentro del ancho definido
                mainAxisSize: MainAxisSize.min, // Ajusta la altura de la columna a sus contenidos
                children: [
                  Text('Usuario:',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 300.0, // Cambia este valor para ajustar el ancho
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Introduzca el nombre de usuario',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height:16),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto y el campo de entrada a la izquierda dentro del ancho definido
                mainAxisSize: MainAxisSize.min, // Ajusta la altura de la columna a sus contenidos
                children: [
                  Text('Email:',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 300.0, // Cambia este valor para ajustar el ancho
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Introduzca el correo electrónico',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto y el campo de entrada a la izquierda dentro del ancho definido
                mainAxisSize: MainAxisSize.min, // Ajusta la altura de la columna a sus contenidos
                children: [
                  Text('Contraseña:',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 300.0, // Cambia este valor para ajustar el ancho
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Introduzca la contraseña',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),

                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 100),
            Center(
              child:
              CustomButton(
                value: 'Registrarse',
                color: Color(0xFFA2DAF1),
                onPressed: () {
                  String name = nameController.text;
                  String password = passwordController.text;
                  String email = emailController.text;

                  if (name.isNotEmpty && password.isNotEmpty & email.isNotEmpty) {

                    Navigator.pop(context );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error',textAlign: TextAlign.center,style: TextStyle(color: Color(0xFFFFA1A1),fontWeight:FontWeight.bold ),),
                        content: Text('Por favor, completa todos los campos.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK',style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Center(
                child:
                Column(
                  children:
                  [
                    Text('¿Tienes cuenta?',style: TextStyle(fontSize: 17),),
                    InkWell(child:
                    Text('Iniciar sesión',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                    )

                  ],
                )
            )


          ],
        ),
      ),
    );
  }
}
