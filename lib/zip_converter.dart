import 'dart:io'; // Para trabajar con el sistema de archivos
import 'package:archive/archive_io.dart'; // Para manejar compresión de archivos
import 'package:path/path.dart' as path; // Para manejar rutas

Future<void> zipFiles(List<String> selectedDirectories) async {
  for (String selectedDirectory in selectedDirectories) {
    // Crear una nueva carpeta dentro de la seleccionada para almacenar los archivos zip
    String newFolderPath = path.join(selectedDirectory, 'Carpetas zip');
    final newDirectory = Directory(newFolderPath);
    if (!await newDirectory.exists()) {
      await newDirectory.create();
    }

    // Listar carpetas dentro del directorio seleccionado
    final directory = Directory(selectedDirectory);
    List<FileSystemEntity> entities = directory.listSync();

    for (var entity in entities) {
      // Verificar que la carpeta no sea la que contiene los archivos .zip
      if (entity is Directory && entity.path != newFolderPath) {
        String zipFilePath = path.join(newFolderPath, '${path.basename(entity.path)}.zip');
        final encoder = ZipFileEncoder();
        encoder.create(zipFilePath);

        // Añadir la carpeta entera al archivo zip
        encoder.addDirectory(entity);
        encoder.close(); // Cerrar el zip después de agregar la carpeta
      }
    }
  }
}

