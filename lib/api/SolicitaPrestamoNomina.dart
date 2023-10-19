// import 'dart:convert';
import 'package:componets/api/configApi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final api = ConfigApi('http://3.144.234.124:81/prestamo_nomina');

final postDataProvider = FutureProvider.autoDispose<String>((ref) async {
  final data = {
    'idEmpleado': 29771,
    'token': '29771_DDKlSfx2ttMhEiwbQCEh1HigF',
  };

  final response = await api.postRequest(data);
    // print(response);

  // return response.toString();
  return response ;
});