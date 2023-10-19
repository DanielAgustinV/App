// import 'dart:convert';
import 'package:componets/api/configApi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
var name;
var user;
final api = ConfigApi('http://3.144.234.124:81/login');

final postDataProvider = FutureProvider.autoDispose<String>((ref) async {
  final data = {
    'no_empleado': name ,
    'imss': user,
  };

  final response = await api.postRequest(data);
    // print(response);

  // return response.toString();
  return response ;
});