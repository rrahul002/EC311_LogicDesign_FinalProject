def rc4(key, data):
    S = list(range(256))
    j = 0

    # Key scheduling
    for i in range(256):
        j = (j + S[i] + key[i % len(key)]) % 256
        S[i], S[j] = S[j], S[i]

    # Pseudo-random generation
    i = j = 0
    result = []
    for char in data:
        i = (i + 1) % 256
        j = (j + S[i]) % 256
        S[i], S[j] = S[j], S[i]
        result.append(chr(ord(char) ^ S[(S[i] + S[j]) % 256]))

    return ''.join(result)

# Example usage
key = [0x1, 0x2, 0x3, 0x4, 0x5]
data = "Hello, World!"

encrypted_data = rc4(key, data)
print("Encrypted:", encrypted_data)

decrypted_data = rc4(key, encrypted_data)
print("Decrypted:", decrypted_data)

# Example 1
key1 = [0x5, 0x2, 0x9, 0x1, 0x8]
data1 = "EC311 is Cool!"

encrypted_data1 = rc4(key1, data1)
print("Example 1 - Encrypted:", encrypted_data1)

decrypted_data1 = rc4(key1, encrypted_data1)
print("Example 1 - Decrypted:", decrypted_data1)

# Example 2
key2 = [0xAA, 0xBB, 0xCC, 0xDD, 0xEE]
data2 = "RC4 is a stream cipher."

encrypted_data2 = rc4(key2, data2)
print("Example 2 - Encrypted:", encrypted_data2)

decrypted_data2 = rc4(key2, encrypted_data2)
print("Example 2 - Decrypted:", decrypted_data2)
