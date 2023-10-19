import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(LoginApp());
// }

// class LoginApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage(),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

  Future<void> login() async {
    print(correoController.value);
    print(contrasenaController.text);
    final url = Uri.parse('http://3.144.234.124:81/login'); // Reemplaza con la URL correcta
    final response = await http.post(
      url,
      body: {
        "no_empleado": correoController.value,
        "imss": contrasenaController.value,
      },
    );
     final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    // print('poiuytrewqwertyu');
  //  return response.toString();

    // final decodedData = json.decode(response as String);

    if (response.statusCode == true) {
      // Inicio de sesión exitoso
      print('exito');
      // Puedes redirigir al usuario a otra pantalla o realizar otras acciones
    } else {
      // Inicio de sesión fallido
      print('fallo');
      // Muestra un mensaje de error al usuario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: contrasenaController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: login,
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
