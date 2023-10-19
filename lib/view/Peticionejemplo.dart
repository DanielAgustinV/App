import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

class PeticionHttp extends StatelessWidget {
  final String variable1 = 'idEmpleado';
  final String variable2 = 'idOperacion';
  final String variable3 = 'token';

  void callService() async {
    // Define los datos a enviar al servicio en un mapa
    Map<String, dynamic> data = {
      'idEmpleado': 29771,
      'idOperacion': 103,
      'token': '29771_xScxtrpul35bVKXO1r4seb4VA',
    };

    // Convierte el mapa a JSON
    String jsonData = json.encode(data);

    // URL del servicio que deseas llamar
    final String serviceUrl = 'http://3.144.234.124:81/solicita_prestamo_nomina';

    // Realiza una solicitud POST al servicio
    final response = await http.post(
      Uri.parse(serviceUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // Procesa la respuesta del servicio
      final responseData = json.decode(response.body);
      print('Respuesta del servicio: $responseData');
    } else {
      print('Error en la solicitud al servicio. Código de estado: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Llamar a un Servicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: callService,
              child: Text('Llamar al Servicio'),
            ),
          ],
        ),
      ),
    );
  }
}
