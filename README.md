# CryptPlus

## About

CryptPlus is a lightweight wrappper of OpenSSL cryptographic tools. Specifically, the library aims to support symmetric encryption & decryption with AES-256 alongside Diffie-Hellman key exchange. Official OpenSSL documentation can be found here: https://www.openssl.org/docs/

Most functions are well-documented. The library is not large so a peruse through the source code should be explanatory. Make sure to refer to the man pages relating to the employed OpenSSL functions: `man crypto`.

No guarantee of security is given to an application which uses this library. Whilst careful attention has been paid to ensure that the security of OpenSSL functions employed are no less secure, it is the responsibility of the library user to ensure best security practices.

This codebase is part of a collection of personal educational projects; in general security protocols should not be written from scratch.

### Installation

- Install pre-built library

1. Download the *-Darwin.tar.gz package in `/build`
2. Unzip in a directory of your choosing

- Build from source (with CMake)

1. Download the *-Source.tar.gz package and unzip anywhere
2. From the command line, navigate to the build folder
3. Execute the following line: `cmake --install . --prefix "[INSTALL_DIR]"`

### How to use

The following example shows how both a host and a peer would generate their own keys & share them to generate identical shared secrets.

- Creating a public key for DH exchange

```cpp
#include <crypt/exchange.hpp>

Exchange host;
PublicKeyDER host_pub_key = host.get_public_key();

const unsigned char* pub_key_raw = host_pub_key.get_key();
int key_len = host_pub_key.get_len();
```

- Creating a PublicKeyDER from raw data

```cpp
#include <crypt/public-key-der.hpp>

char* key_data;
int key_len;

// ... Read some data from somewhere, such as a socket, and write into the buffer. Set key length.

PublicKeyDER pkd { reinterpret_cast<unsigned char*>(key_data), key_len };
```

- Generating a shared secret using a public key

```cpp
#include <crypt/exchange.hpp>

Exchange host;
PublicKeyDER public_key;

// ... We'll assume the public key has been initialised with a peer's public key data.

host.derive_secret(public_key);
std::string shared_secret = host.get_secret();
```

Next is an example of symmetric encryption/decryption with AES-256.

```cpp
#include <crypt/crypt.hpp>

Crypt aes { "AES-256-CBC" };

char[32] key_256;
char[16] iv_128;

// ... Establish a 256-bit key (perhaps by hashing a shared secret derived with DH?) and a sufficiently entropic initialization vector.

std::string plain_text = { "Hello, World!" };

// Encrypt plain_text to std::string cipher_text. The var 'success' is a bool holding the success or failure of the operation.
auto [cipher_text, success] = aes.encrypt(plain_text, key_256, iv_128);

// Decrypt cipher_text to std::string decrypted.
auto [decrypted, decrypt_success] = aes.decrypt(cipher_text, key_256, iv_128);
```