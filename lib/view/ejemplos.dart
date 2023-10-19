import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CalculatorApp(),
//     );
//   }
// }

class Ejemplo extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<Ejemplo> {
  late TextEditingController inputController1;
  late TextEditingController inputController2;
  TextEditingController resultController1 = TextEditingController();
  TextEditingController resultController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    inputController1 = TextEditingController(text: '5');
    inputController2 = TextEditingController(text: '3');

    inputController1.addListener(calculate);
    inputController2.addListener(calculate);

    calculate();
  }

  void calculate() {
    double num1 = double.tryParse(inputController1.text) ?? 0.0;
    double num2 = double.tryParse(inputController2.text) ?? 0.0;

    double suma = num1 + num2;
    double resta = num1 - num2;

    resultController1.text = suma.toString();
    resultController2.text = resta.toString();
  }

  Future<void> sendDataAsJson() async {
    final url = 'https://example.com/api'; // Reemplaza con tu URL de servidor
    final jsonData = {
      'numero1': inputController1.text,
      'numero2': inputController2.text,
      'suma': resultController1.text,
      'resta': resultController2.text,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200) {
      print('Datos enviados exitosamente');
    } else {
      print('Error al enviar datos: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suma y Resta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: inputController1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 1'),
            ),
            TextField(
              controller: inputController2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 2'),
            ),
            TextField(
              controller: resultController1,
              enabled: false,
              decoration: InputDecoration(labelText: 'Suma'),
            ),
            TextField(
              controller: resultController2,
              enabled: false,
              decoration: InputDecoration(labelText: 'Resta'),
            ),
            ElevatedButton(
              onPressed: sendDataAsJson,
              child: Text('Enviar Datos como JSON'),
            ),
          ],
        ),
      ),
    );
  }
}