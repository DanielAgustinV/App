// import 'dart:convert';
import 'dart:convert';

import 'package:componets/api/configApi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final api = ConfigApi('http://3.144.234.124:81/solicita_prestamo_nomina');

final response_solicita_prestamo_nomina = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final data = {
    'idEmpleado': 29771,
    'idOperacion': 103,
    'token': '29771_DDKlSfx2ttMhEiwbQCEh1HigF',
  };

  final response = await api.postRequest(data);
// print(response);
  // return response.toString();
    final decodedData = json.decode(response);

  return decodedData;
});





// 
