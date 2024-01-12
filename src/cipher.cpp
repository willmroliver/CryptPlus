#include <openssl/evp.h>
#include <openssl/err.h>

#include "crypt/error.hpp"
#include "crypt/cipher.hpp"

using namespace crpt;

Cipher::Cipher(std::string name):
    cipher { EVP_CIPHER_fetch(nullptr, name.c_str(), nullptr) },
    name { name }
{
    if (cipher == nullptr) {
        Error::openssl_err_out("EVP_CIPHER_fetch");
    }
}

Cipher::Cipher(std::string name, std::string properties):
    cipher { EVP_CIPHER_fetch(nullptr, name.c_str(), properties.c_str()) },
    properties { properties }
{
    if (cipher == nullptr) {
        Error::openssl_err_out("EVP_CIPHER_fetch");
    }
}

Cipher::Cipher(Cipher& c):
    context { c.context },
    name { c.name },
    properties { c.properties }
{
    cipher = EVP_CIPHER_fetch(nullptr, name.c_str(), properties.size() ? properties.c_str() : nullptr);
}
        
Cipher::Cipher(Cipher&& c):
    context { c.context },
    cipher { c.cipher },
    name { c.name },
    properties { c.properties }
{
    c.cipher = nullptr;
    c.name = "";
    c.properties = "";
}

Cipher& Cipher::operator=(Cipher& c) {
    context = c.context;
    name = c.name;
    properties = c.properties;

    cipher = EVP_CIPHER_fetch(nullptr, name.c_str(), properties.size() ? properties.c_str() : nullptr);
    
    return *this;
}
        
Cipher& Cipher::operator=(Cipher&& c) {
    context = c.context;
    cipher = c.cipher;
    name = c.name;
    properties = c.properties;

    c.cipher = nullptr;
    c.name = "";
    c.properties = "";
    
    return *this;
}
        
Cipher::~Cipher() {
    EVP_CIPHER_free(cipher);
}

bool Cipher::encrypt_init(const unsigned char* key, const unsigned char* iv) const {
    return EVP_EncryptInit_ex2(context.get_context(), cipher, key, iv, nullptr);
}     

bool Cipher::encrypt_init(const unsigned char* key, const unsigned char* iv, OSSL_PARAM* params) const {
    return EVP_EncryptInit_ex2(context.get_context(), cipher, key, iv, params);
}

bool Cipher::encrypt_update(unsigned char* out, int* out_len, const unsigned char* msg, int msg_len) {
    return EVP_EncryptUpdate(context.get_context(), out, out_len, msg, msg_len);
}

bool Cipher::encrypt_final(unsigned char* out, int* tmp_len) {
    return EVP_EncryptFinal_ex(context.get_context(), out, tmp_len);
}

bool Cipher::decrypt_init(const unsigned char* key, const unsigned char* iv) const {
    return EVP_DecryptInit_ex2(context.get_context(), cipher, key, iv, nullptr);
}

bool Cipher::decrypt_init(const unsigned char* key, const unsigned char* iv, OSSL_PARAM* params) const {
    return EVP_DecryptInit_ex2(context.get_context(), cipher, key, iv, params);
}

bool Cipher::decrypt_update(unsigned char* out, int* out_len, const unsigned char* msg, int msg_len) {
    return EVP_DecryptUpdate(context.get_context(), out, out_len, msg, msg_len);
}

bool Cipher::decrypt_final(unsigned char* out, int* tmp_len) {
    return EVP_DecryptFinal_ex(context.get_context(), out, tmp_len);
}

int Cipher::block_size() {
    return EVP_CIPHER_block_size(cipher);
}

int Cipher::key_length() {
    return EVP_CIPHER_key_length(cipher);
}       

EVP_CIPHER* const Cipher::get_cipher() const {
    return cipher;
}  