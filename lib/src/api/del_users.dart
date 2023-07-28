import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> eliminarUsuario(int id) async {
  final response = await http.delete(Uri.parse('http://TU_DIRECCION_API/usuarios.php?id=$id'));

  if (response.statusCode == 200) {
    print('Usuario eliminado exitosamente');
  } else {
    throw Exception('Error al eliminar el usuario');
  }
}

class DetalleUsuarioScreen extends StatelessWidget {
  final int id;
  final String nombre;
  final int edad;

  DetalleUsuarioScreen({required this.id, required this.nombre, required this.edad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: $id', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nombre: $nombre', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Edad: $edad', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                eliminarUsuario(id);
                Navigator.pop(context);
              },
              child: Text('Eliminar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
