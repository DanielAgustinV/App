// import 'dart:convert';
import 'dart:convert';

import 'package:componets/api/configApi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String? montoprestamo;
String? plazos;


final api = ConfigApi('httpp');

final calcula_prestamo = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final data = {
    'monto': montoprestamo,
    'plazos': plazos,
    'token': '29771_DDKlSfx2ttMhEiwbQCEh1HigF',
  };

  final response = await api.postRequest(data);
// print(response);
  // return response.toString();
    final decodedData = json.decode(response);

  return decodedData;
});


