// import 'dart:convert';
// // export  'package:componets/view/Prestamos/solicita_prestamo.dart';
// import 'package:componets/api/NuevoPrestmoNomina.dart';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// // import 'package:intl/intl.dart';
// class DropdownValueNotifier extends StateNotifier<String> {
//   DropdownValueNotifier() : super('');

//   void updateValue(String value) {
//     state = value;
//   }
// }

// class NuevoPrestamo extends HookConsumerWidget{
//    NuevoPrestamo({super.key});
  

//   // get selectedValue => null;

//   final selectedValue =
//       StateNotifierProvider<DropdownValueNotifier, String>((ref) {
//     return DropdownValueNotifier();
//   });
  
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//   TextEditingController _amountController = TextEditingController();
//   // TextEditingController _montoaval =TextEditingController();

//   // final numero_avales = _amountController.value;
 
//     DateTime fechaActual = DateTime.now();
//     DateTime fechainicio = DateTime(fechaActual.year, fechaActual.month, fechaActual.day);
//     DateTime fecha = DateTime(2023, 11, 30); 
//     DateTime fechafin = DateTime(fecha.year, fecha.month, fecha.day);
//     Duration diferencia = fechafin.difference(fechainicio);
//     int dias = diferencia.inDays;

//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//     String? _monto;
//     String? _tasaiva;
//     String? _comision;
//     String? _plazos;
//     String? _pagoprestamo;  
//     List<TextEditingController> _montoaval = [];
  
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' Datos Préstamo'),
//         backgroundColor:Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 10,),
//             child:     Center(
//             child: FutureBuilder<Map<String, dynamic>>(
//               future: ref.watch(response_solicita_prestamo_nomina.future),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else if (snapshot.data == null) {
//                   return Text('Data is null');
//                 } else {
//                   final empleado = snapshot.data!['empleado'];
//                   final avales = snapshot.data!['avales'];
//                   final monto_maximo = snapshot.data!['monto_maximo'];
//                   final monto_x_aval = snapshot.data!['monto_x_aval'];
//                   final plazos_restantes = snapshot.data!['plazos_restantes'];

//                   if (empleado == null ||
//                       !empleado.containsKey('salario_mensual')) {
//                     return Text('Data does not contain "salario_mensual" key');
//                   }
//                   final maxprstamo = empleado['monto_maximo'];
//                   final plazo = 3;
//                   final id_operacion = empleado['id_operacion'];
//                   print(avales.runtimeType);  //lista dinamica 

//                   for (int i = 0; i < avales.length; i++) {
//                     dynamic elemento = avales[i];
//                     // print(elemento);
//                   }
//                      void _validateAmount() {
//                       final String amountText = _amountController.text;
//                       if (amountText.isEmpty) {
//                         return;
//                       }
//                       final double? amount = double.tryParse(amountText);
//                       if (amount != null && amount > monto_maximo) {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return Hero(
//                               tag: 'alert',
//                               child: AlertDialog(
//                                 title: Text('Cantidad excedida'),
//                                 content: Text('La cantidad no puede ser mayor a $monto_maximo'),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     child: Text('Aceptar'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                         _amountController.clear();
//                       }
//                     }

//                     //  void _valida_monto_aval() {
//                     //   final String monto = _montoaval.text;
//                     //   if (monto.isEmpty) {
//                     //     return;
//                     //   }
//                     //   final double? amount = double.tryParse(monto);
//                     //   if (amount != null && amount >= monto_x_aval) {
//                     //     showDialog(
//                     //       context: context,
//                     //       builder: (context) {
//                     //         return Hero(
//                     //           tag: 'alert',
//                     //           child: AlertDialog(
//                     //             title: Text('Cantidad excedida'),
//                     //             content: Text('El monto por aval no puede superar a: $monto_x_aval'),
//                     //             actions: <Widget>[
//                     //               TextButton(
//                     //                 child: Text('Aceptar'),
//                     //                 onPressed: () {
//                     //                   Navigator.of(context).pop();
//                     //                 },
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         );
//                     //       },
//                     //     );
//                     //     _montoaval.clear();
//                     //   }
//                     // }
//                   return Column(
//               children: [Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Hero(
//                                 tag: 'alert',
//                                 child: TextField(
//                                 controller: _amountController,
//                                 decoration: InputDecoration(
//                                   labelText: "Monto",
//                                     border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                                 ),
//                                 onChanged: (_) {
//                                   _validateAmount();
//                                 },
//                                ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 // readOnly: true,
//                                 decoration:  const InputDecoration(labelText: 'Tasa con iva por periodo',
//                                   // fillColor: Colors.green,
//                                   // filled: true,
//                                   border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                                 hintStyle: TextStyle(
//                                   color: Colors.blue,
//                                   decorationColor:Colors.purple,
          
//                                 )),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Selecciona el periodo';
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (value) {
//                                   _tasaiva = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 initialValue: '200',
//                                 readOnly: true,
//                                 decoration: InputDecoration(labelText: 'Comision por Apertura',
//                                   border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return '';
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (value) {
//                                   _comision = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 decoration: const InputDecoration(labelText: 'Plazo(s)',
//                                   border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Por favor, ingresa el plazo';
//                                   }
//                                   // Agregar validación de formato de teléfono si es necesario
//                                   return null;
//                                 },
//                                 onSaved: (value) {
//                                   _plazos = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 initialValue: '',
//                                 // readOnly: true,
//                                 decoration: InputDecoration(labelText: 'Pago del prestamo',
//                                   border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return '';
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (value) {
//                                   _pagoprestamo = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             child: Expanded(
//                               child: Container(
//                                 width: 20,
//                                 decoration: BoxDecoration(
//                                     //  border: Border.all(color: Colors.grey, width: 1.0), // Configura el borde
//                                     // borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),            
//                                   child: Column(
//                                     children: List.generate(3, (index) {
//                                       _montoaval.add(TextEditingController());                                      return Column(
//                                         children: [
//                                           DropdownButton<String?>(
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                             ),
//                                             value: ref.watch(selectedValue), 
//                                             onChanged: (value) {
//                                               print(value);
//                                                  ref
//                                                   .read(selectedValue.notifier)
//                                                   .updateValue(value.toString());
//                                             }, 
//                                             items: avales.map<DropdownMenuItem<String?>>((item) {
//                                               return DropdownMenuItem<String?>(
//                                                 value: item["id_empleado"].toString(),
//                                                 child: Text(item["nombre_completo"],
//                                                   // style: TextStyle(fontSize: 13),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                           TextField(
//                                             controller: _montoaval[index],
//                                             decoration: InputDecoration(
//                                               labelText: "Monto aval",
//                                                 border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                                             ),
//                                             onChanged: (_) {
//                                               // _valida_monto_aval();
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     }),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // SizedBox(
//                       //   height: 34,
//                       // ),
//                       // TextField(
//                       //   controller: _montoaval,
//                       //   decoration: InputDecoration(
//                       //     labelText: "Monto por aval",
//                       //       border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                       //   ),
//                       //   onChanged: (_) {
//                       //     _valida_monto_aval();
//                       //   },
//                       // ),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _formKey.currentState!.save();
//                             // Realizar acciones con los datos ingresados
//                             print('monto: ${_amountController.text}'); //pasar monto
//                             print('tasaiva: $_tasaiva');
//                             print('comision: $_comision');
//                             print('plazos: $_plazos');
//                             print('pago_prestamo: $_pagoprestamo');
//                             // print(prestamo);
//                             // print('monto_aval ${_montoaval.text}');
//                             for (int i = 0; i < _montoaval.length; i++) {
//                             String valorTextField = _montoaval[i].text;
//                             print(" Aval $i: $valorTextField");
// }
//                           }
//                         },
//                         child: Text('Solicitar Prestamo'),
//                       ),
//                       // Avals(),
//                       //  MyHomePage(),
//                     ],
//                   ),
//                 ),
//               ),
//               ],
              
//             );
//                 }
//               },
//             ),
//           ),

//             )
//         ),
      
//     );
//   }
// }

// // class MyHomePage extends StatefulWidget {
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   String? selectedValue; // Variable para almacenar el valor seleccionado
// //     String? _monotoaval;

// //   Map<String, dynamic> miMap = {
// //     "1": {"id": 1, "nombre": "Opción 1"},
// //     "2": {"id": 2, "nombre": "Opción 2"},
// //     "3": {"id": 3, "nombre": "Opción 3"},
// //   };

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(

// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: <Widget>[
// //                 Text('Selecciona una opción:'),
// //             DropdownButton<String>(
// //               value: selectedValue,
// //               onChanged: (newValue) {
// //                 setState(() {
// //                   selectedValue = newValue;
// //                 });
// //               },
// //               items: miMap.keys.map((key) {
// //                 return DropdownMenuItem<String>(
// //                   value: key,
// //                   child: Text(miMap[key]["nombre"]),
// //                 );
// //               }).toList(),
// //             ),
// //             Text('Valor seleccionado: $selectedValue'),

// //           //   Expanded(
// //           //    child: Padding(
// //           //      padding: const EdgeInsets.all(8.0),
// //           //      child: TextFormField(
// //           //        decoration: const InputDecoration(labelText: 'Plazo(s)',
// //           //          border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
// //           //        ),
// //           //        validator: (value) {
// //           //          if (value == null || value.isEmpty) {
// //           //            return 'Por favor, ingresa el plazo';
// //           //          }
// //           //          // Agregar validación de formato de teléfono si es necesario
// //           //          return null;
// //           //        },
// //           //        onSaved: (value) {
// //           //          _monotoaval = value;
// //           //        },
// //           //      ),
// //           //    ),
// //           //  ),
// //               ],
// //             ),
// //         ),
// //       );
// //   }
// // }


