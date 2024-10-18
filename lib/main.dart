import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async'; // Para usar Timer
import 'package:zipapp/zip_converter.dart'; // Asegúrate de importar el archivo correcto

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Bienvenido/bienvenida',
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 76, 116, 247), // Fondo morado del AppBar
            toolbarHeight: 150,
          ),
          body: CompressionScreen(),
        ),
      ),
    );
  }
}

class CompressionScreen extends StatefulWidget {
  @override
  _CompressionScreenState createState() => _CompressionScreenState();
}

class _CompressionScreenState extends State<CompressionScreen> {
  bool _isCompleted = false;
  List<String> selectedDirectories = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 81, 189, 239), // Fondo azul claro
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
        children: [
          const Text(
            'Atención',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '-Asegúrese de que la carpeta seleccionada solamente tenga las carpetas que desee convertir en .zip.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '-El programa creará una carpeta dentro de la carpeta seleccionada llamada "Carpetas zip"  con todas las carpetas convertidas a .zip',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '-Hecho exclusivamente para Windows.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          Align(
  alignment: Alignment.center,
  child: ElevatedButton(
    onPressed: () async {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath(); // Selecciona una carpeta
      if (selectedDirectory != null) {
        setState(() {
          selectedDirectories = [selectedDirectory]; // Guardar la carpeta seleccionada
        });
        await zipFiles(selectedDirectories); // Llamar a la función que comprime carpetas
        setState(() {
          _isCompleted = true;
        });
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _isCompleted = false;
          });
        });
      }
              },
              child: const Text(
                'Seleccionar Carpeta',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_isCompleted)
            const Text(
              'Carpetas comprimidas exitosamente',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
