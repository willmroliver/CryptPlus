#include <openssl/evp.h>
#include <openssl/err.h>

#include "error.hpp"
#include "cipher.hpp"

using namespace crpt;

Cipher::Cipher(std::string name):
    cipher { EVP_CIPHER_fetch(nullptr, name.c_str(), nullptr) }
{
    if (cipher == nullptr) {
        Error::openssl_err_out("EVP_CIPHER_fetch");
    }
}

Cipher::Cipher(std::string name, OSSL_LIB_CTX* c):
    cipher { EVP_CIPHER_fetch(c, name.c_str(), nullptr) }
{
    if (cipher == nullptr) {
        Error::openssl_err_out("EVP_CIPHER_fetch");
    }
}       

Cipher::Cipher(std::string name, OSSL_LIB_CTX* c, std::string properties):
    cipher { EVP_CIPHER_fetch(c, name.c_str(), properties.c_str()) }
{
    if (cipher == nullptr) {
        Error::openssl_err_out("EVP_CIPHER_fetch");
    }
}

Cipher::Cipher(std::string name, std::string properties):
    cipher { EVP_CIPHER_fetch(nullptr, name.c_str(), properties.c_str()) }
{
    if (cipher == nullptr) {
        Error::openssl_err_out("EVP_CIPHER_fetch");
    }
}
        
Cipher::Cipher(Cipher&& c): 
    cipher { c.cipher }
{
    c.cipher = nullptr;
}
        
Cipher& Cipher::operator=(Cipher&& c) {
    cipher = c.cipher;
    c.cipher = nullptr;
    
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