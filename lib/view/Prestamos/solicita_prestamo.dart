import 'package:componets/api/NuevoPrestmoNomina.dart';
import 'package:componets/api/CalculaPrestamo.dart';
import 'package:componets/view/ui/input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// void main() {
//   runApp(
//     ProviderScope(
//       child: MaterialApp(
//         home: NuevoPrestamo(),
//       ),
//     ),
//   );
// }

class NuevoPrestamo extends ConsumerStatefulWidget {
  const NuevoPrestamo({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<NuevoPrestamo> {

  void initState() {
setState(() {
        _comisionapertura.text = '200';
        
      });

  }

  TextEditingController      _montoinput       = TextEditingController();
  TextEditingController      _plazos           = TextEditingController();
  TextEditingController      _comisionapertura = TextEditingController();
  late TextEditingController _pagoprestamo;
  late TextEditingController _tasaconiva;


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // String? _monto;
  // String? _tasaiva;
  // String? _comision;
  // String? _plazos;
  // String? _pagoprestamo;

  List<TextEditingController> _montoaval = [];
  String? selectedValue; // Debes definir selectedValue


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Préstamo'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Center(
            child: FutureBuilder<Map<String, dynamic>>(
              future: ref.watch(response_solicita_prestamo_nomina.future),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Text('Data is null');
                } else {
                  final empleado = snapshot.data!['empleado'];
                  final avales = snapshot.data!['avales'];
                  final monto_maximo = snapshot.data!['monto_maximo'];
                  final monto_x_aval = snapshot.data!['monto_x_aval'];
                  final plazos_restantes = snapshot.data!['plazos_restantes'];
                  final tipo_nomina = snapshot.data!['plazos_restantes'];

                  if (empleado == null ||
                      !empleado.containsKey('salario_mensual')) {
                    return Text('Data does not contain "salario_mensual" key');
                  }
                  final maxprstamo = empleado['monto_maximo'];
                  final id_operacion = empleado['id_operacion'];

                  //VALIDACIONES PARA EL MONTO MAXIMO DE PRESTAMOS Y MAXIMO PLAZOS 
                     void ValidaMontoMaximo() {
                      final String amountText = _montoinput.text;
                      if (amountText.isEmpty) {
                        return;
                      }
                      final double? amount = double.tryParse(amountText);
                      if (amount != null && amount > monto_maximo) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Hero(
                              tag: 'alert',
                              child: AlertDialog(
                                title: Text('Cantidad excedida'),
                                content: Text('Tu Prestamo Debe Ser Menor o Igual a $monto_maximo'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        _montoinput.clear();
                      }
                    }
                    void ValidaPlazos() {
                      final String amountText = _plazos.text;
                      if (amountText.isEmpty) {
                        return;
                      }
                      final double? amount = double.tryParse(amountText);
                      if (amount != null && amount > plazos_restantes) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Hero(
                              tag: 'alert',
                              child: AlertDialog(
                                title: Text('Error...!'),
                                content: Text('Los plazos no pueden ser mayor a: $plazos_restantes.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        _plazos.clear();
                      }
                    }
                    
                                        //  void _valida_monto_aval() {
                    //   final String monto = _montoaval.text;
                    //   if (monto.isEmpty) {
                    //     return;
                    //   }
                    //   final double? amount = double.tryParse(monto);
                    //   if (amount != null && amount >= monto_x_aval) {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return Hero(
                    //           tag: 'alert',
                    //           child: AlertDialog(
                    //             title: Text('Cantidad excedida'),
                    //             content: Text('El monto por aval no puede superar a: $monto_x_aval'),
                    //             actions: <Widget>[
                    //               TextButton(
                    //                 child: Text('Aceptar'),
                    //                 onPressed: () {
                    //                   Navigator.of(context).pop();
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     );
                    //     _montoaval.clear();
                    //   }
                    // }
                      // void initState() {
                      //   super.initState();

                      //   _montoinput = TextEditingController(text: '0');
                      //   _plazos = TextEditingController(text: '0');

                      //   _montoinput.addListener(calculate);
                      //   _plazos.addListener(calculate);

                      //   calculate();
                      // }
                      //  void calculate() {
                      //   double num1 = double.tryParse(_montoinput.text) ?? 0.0;
                      //   double num2 = double.tryParse(_plazos.text) ?? 0.0;

                      //   double suma = num1 + num2;
                      //   double resta = num1 - num2;

                      //   _pagoprestamo.text = suma.toString();
                      //   _tasaconiva.text = resta.toString();
                      // }
                return Column(
                  children: [Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Hero(
                                    tag: 'alert',
                                    child: TextFormField(
                                      controller: _montoinput,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecorationBuilder.finalinput(hintText: '10000', labelText: 'Monto'),
                                      onChanged:(value){
                                        ValidaMontoMaximo();
                                        // setState(() {
                                        //   _amountController = value;
                                        // });
                                      },
                                      validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Error!';
                                      }
                                      // return null;
                                    },
                                    // onSaved: (value) {
                                    //   _monto = value;
                                    // },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    // controller: _tasaconiva,
                                    decoration: InputDecorationBuilder.finalinput(hintText: 'Iva', labelText: 'Tasa con iva por Periodo'),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Selecciona el periodo';
                                    //   }
                                    //   return null;
                                    // },
                                    // onSaved: (value) {
                                    //   _tasaiva = value;
                                    // },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    // initialValue: '200',
                                    readOnly: true,
                                    controller: _comisionapertura,
                                    decoration: InputDecorationBuilder.finalinput(hintText: '000', labelText: 'Comision por Apertura'),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return '';
                                    //   }
                                    //   return null;
                                    // },
                                    // onSaved: (value) {
                                    //   _comision = value;
                                    // },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _plazos,
                                    decoration: InputDecorationBuilder.finalinput(hintText: 'Maximo $plazos_restantes plazos', labelText: 'Plazos'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, ingresa el plazo';
                                      }
                                      // Agregar validación de formato de teléfono si es necesario
                                      return null;
                                    },
                                    onChanged: (_){
                                      ValidaPlazos();
                                    },
                                    // onSaved: (value) {
                                    //   _plazos = value;
                                    // },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                     readOnly: true,
                                     decoration: InputDecorationBuilder.finalinput(hintText: 'Monto a pagar', labelText: 'Pago del prestamo'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    // onSaved: (value) {
                                    //   _pagoprestamo = value;
                                    // },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // final String miVariableFinal = "Ejemplo de variable final";
                              Container(
                                child: Expanded(
                                  child: Container(
                                    width: 20,
                                    decoration: BoxDecoration(
                                        //  border: Border.all(color: Colors.grey, width: 1.0), // Configura el borde
                                        // borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),    
                                      // final String miVariableFinal = "Ejemplo de variable final";        
                                      child: Avales(avales,0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {

                                final montoprestamo = _montoinput.text;
                                final plazos = _plazos.text;
                                // context.read(calcula_prestamo.notifier).state = {
                                //   'monto': montoprestamo,
                                //   'plazos': plazos, 
                                //   'token': '29771_DDKlSfx2ttMhEiwbQCEh1HigF'};
                                // _formKey.currentState!.save();
                                // // Realizar acciones con los datos ingresados
                                // // print('monto: ${_amountController.text}'); //pasar monto
                                // // print('tasaiva: $_tasaiva');
                                // // print('comision: $_comision');
                                // print('plazos: $_plazos');
                                // print('pago_prestamo: $_pagoprestamo');
                                // // print(prestamo);
                                // // print('monto_aval ${_montoaval.text}');
                                // for (int i = 0; i < _montoaval.length; i++) {
                                // String valorTextField = _montoaval[i].text;
                                // print(" aval$i: $valorTextField");
                                // }
                              // }
                            },
                            child: Text('Solicitar Prestamo'),
                          ),
                          // Avals(),
                          //  MyHomePage(),
                        ],
                      ),
                    ),
                  ),
              ],
              
            );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget Avales(avales, navales) { 
    return navales > 0 ? Column(
        children: List.generate(navales, (index) {
          _montoaval.add(TextEditingController());
          return Column(
            children: [ Text('Selecciona a tu aval'),
              DropdownButton<String?>(
                style: TextStyle(
                  color: Colors.black,
                ),
                value:  selectedValue, 
                onChanged: (value) {
                  print(value);
                   setState(() {
                    selectedValue = value;
                  });
                  //  selectedValue.value = value;
                }, 
                items: avales.map<DropdownMenuItem<String?>>((item) {
                  return DropdownMenuItem<String?>(
                    value: item["id_empleado"].toString(),
                    child: Text(item["nombre_completo"],
                      // style: TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
              ),
              TextField(
                controller: _montoaval[index],
                decoration: InputDecorationBuilder.finalinput(hintText: 'Ingresa el monto para tu aval', labelText: 'Monto '),
                onChanged: (_) {
                  // _valida_monto_aval();
                },
              ),
              SizedBox(height: 5,),
            ],
          );
        }),
      ):Text('no entro');
  }
}
