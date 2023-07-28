import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> actualizarUsuario(int id, String nombre, int edad) async {
  final response = await http.put(
    Uri.parse('http://TU_DIRECCION_API/usuarios.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'id': id, 'nombre': nombre, 'edad': edad}),
  );

  if (response.statusCode == 200) {
    print('Usuario actualizado exitosamente');
  } else {
    throw Exception('Error al actualizar el usuario');
  }
}

class ActualizarUsuarioScreen extends StatefulWidget {
  final int id;
  final String nombre;
  final int edad;

  ActualizarUsuarioScreen({required this.id, required this.nombre, required this.edad});

  @override
  _ActualizarUsuarioScreenState createState() => _ActualizarUsuarioScreenState();
}

class _ActualizarUsuarioScreenState extends State<ActualizarUsuarioScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.nombre;
    edadController.text = widget.edad.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: edadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Edad'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String nombre = nombreController.text;
                int edad = int.tryParse(edadController.text) ?? 0;
                actualizarUsuario(widget.id, nombre, edad);
              },
              child: Text('Actualizar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
