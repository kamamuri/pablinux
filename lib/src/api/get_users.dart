import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> obtenerUsuarios() async {
  final response = await http.get(Uri.parse('http://TU_DIRECCION_API/usuarios.php'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al obtener los usuarios');
  }
}
