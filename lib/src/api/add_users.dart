// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> agregarUsuario(String nombre, int edad) async {
  final response = await http.post(
    Uri.parse('http://192.168.18.7/apirest/usuarios.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'nombre': nombre, 'edad': edad}),
  );

  if (response.statusCode == 201) {
    if (kDebugMode) {
      print('Usuario agregado exitosamente');
    }
  } else {
    throw Exception('Error al agregar el usuario');
  }
}

class AgregarUsuarioScreen extends StatefulWidget {
  const AgregarUsuarioScreen({super.key});

  @override
  _AgregarUsuarioScreenState createState() => _AgregarUsuarioScreenState();
}

class _AgregarUsuarioScreenState extends State<AgregarUsuarioScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: edadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Edad'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String nombre = nombreController.text;
                int edad = int.tryParse(edadController.text) ?? 0;
                agregarUsuario(nombre, edad);
              },
              child: const Text('Agregar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
