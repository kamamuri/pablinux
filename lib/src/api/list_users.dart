import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> obtenerUsuarios() async {
  final response = await http.get(Uri.parse('http://192.168.18.7/apirest/usuarios.php'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al obtener los usuarios');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Usuarios'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: obtenerUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error al obtener los usuarios'),
              );
            } else {
              List<dynamic> usuarios = snapshot.data!;
              return ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(usuarios[index]['nombre']),
                    subtitle: Text('Edad: ${usuarios[index]['edad']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
