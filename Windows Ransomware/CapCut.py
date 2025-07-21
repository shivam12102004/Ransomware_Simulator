import os
from Crypto.Cipher import AES
from Crypto.Hash import SHA256
from Crypto import Random

# ✅ Target file to encrypt (you can change this path)
file_to_encrypt = r"E:\stack.png"

# ✅ Password for AES encryption
password = "shivam200@123"

# 🔐 Generate 256-bit AES key from password
def get_aes_key(password):
    hasher = SHA256.new(password.encode())
    return hasher.digest()

# 📦 Pad data to match AES block size
def pad(data):
    padding = AES.block_size - len(data) % AES.block_size
    return data + bytes([padding]) * padding

# 🔁 Encrypt function
def encrypt_file(file_path):
    if file_path.endswith(".encrypted"):
        return

    key = get_aes_key(password)

    with open(file_path, 'rb') as f:
        data = f.read()

    data = pad(data)
    iv = Random.new().read(AES.block_size)
    cipher = AES.new(key, AES.MODE_CBC, iv)
    encrypted_data = iv + cipher.encrypt(data)

    with open(file_path + ".encrypted", 'wb') as f:
        f.write(encrypted_data)

    os.remove(file_path)

# 🚀 Run
encrypt_file(file_to_encrypt)
