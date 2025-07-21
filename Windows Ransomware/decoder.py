import os
from Crypto.Cipher import AES
from Crypto.Hash import SHA256

# ✅ Target file or folder to decrypt
file_to_decrypt = r"C:\Important_File"  # Encrypted folder or single file
password = "Faizal200@123"

def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()

def unpad(data):
    padding = data[-1]
    return data[:-padding]

def decrypt_file(file_path):
    if not file_path.endswith(".encrypted"):
        return

    try:
        key = get_aes_key(password)

        with open(file_path, 'rb') as f:
            encrypted_data = f.read()

        iv = encrypted_data[:AES.block_size]
        cipher = AES.new(key, AES.MODE_CBC, iv)
        decrypted_data = cipher.decrypt(encrypted_data[AES.block_size:])
        decrypted_data = unpad(decrypted_data)

        original_path = file_path.replace(".encrypted", "")
        with open(original_path, 'wb') as f:
            f.write(decrypted_data)

        os.remove(file_path)
        print(f"✅ Decrypted: {file_path}")

    except Exception as e:
        print(f"❌ Failed: {file_path} --> {e}")

def process_path(path):
    if os.path.isfile(path):
        decrypt_file(path)
    elif os.path.isdir(path):
        for root, dirs, files in os.walk(path):
            for file in files:
                full_path = os.path.join(root, file)
                decrypt_file(full_path)
    else:
        print("❌ Invalid path")

# 🚀 Run
process_path(file_to_decrypt)
