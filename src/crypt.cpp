#include <openssl/evp.h>
#include <openssl/bio.h>
#include <string>
#include <utility>
#include "crypt/cipher-context.hpp"
#include "crypt/cipher.hpp"
#include "crypt/crypt.hpp"
#include "crypt/error.hpp"
#include "crypt/hash-context.hpp"
#include "crypt/hash.hpp"

using namespace crpt;

std::pair<std::string, bool> Crypt::encrypt(std::string plain_text, std::string key, std::string iv) {
    if (key.size() < cipher.key_length()) {
        std::cerr << "crypt: key too small, expecting " << cipher.key_length() << " bytes, got " << key.size() << std::endl;
        return { "", false };
    }

    auto k = reinterpret_cast<const unsigned char*>(key.c_str());
    auto i = reinterpret_cast<const unsigned char*>(iv.c_str());

    auto max_cipher_text_len = plain_text.size() + cipher.block_size() - 1;
    auto cipher_buf = new unsigned char[max_cipher_text_len];

    if (!cipher.encrypt_init(k, i)) {
        Error::openssl_err_out("EVP_EncryptInit_ex2");
        return { "", false };
    }

    auto encrypt_len = 0;
    auto u_plain = reinterpret_cast<const unsigned char*>(plain_text.c_str());
    if (!cipher.encrypt_update(cipher_buf, &encrypt_len, u_plain, plain_text.size())) {
        Error::openssl_err_out("EVP_EncryptUpdate");
        return { "", false };
    }

    auto tmp_len = 0;
    if (!cipher.encrypt_final(cipher_buf + encrypt_len, &tmp_len)) {
        Error::openssl_err_out("EVP_EncryptFinal_ex");
        return { "", false };
    }

    encrypt_len += tmp_len;

    return {{ reinterpret_cast<char*>(cipher_buf), static_cast<unsigned int>(encrypt_len) }, true};
}

std::pair<std::string, bool> Crypt::decrypt(std::string cipher_text, std::string key, std::string iv) {
        if (key.size() < cipher.key_length()) {
        std::cerr << "crypt: key too small, expecting " << cipher.key_length() << " bytes, got " << key.size() << std::endl;
        return { "", false };
    }

    auto k = reinterpret_cast<const unsigned char*>(key.c_str());
    auto i = reinterpret_cast<const unsigned char*>(iv.c_str());

    auto max_plain_text_len = cipher_text.size() + cipher.block_size() - 1;
    auto plain_buf = new unsigned char[max_plain_text_len];

    if (!cipher.decrypt_init(k, i)) {
        Error::openssl_err_out("EVP_DecryptInit_ex2");
        return { "", false };
    }

    auto decrypt_len = 0;
    auto u_cipher = reinterpret_cast<const unsigned char*>(cipher_text.c_str());
    if (!cipher.decrypt_update(plain_buf, &decrypt_len, u_cipher, cipher_text.size())) {
        Error::openssl_err_out("EVP_DecryptUpdate");
        return { "", false };
    }

    auto tmp_len = 0;
    if (!cipher.decrypt_final(plain_buf + decrypt_len, &tmp_len)) {
        Error::openssl_err_out("EVP_DecryptFinal_ex");
        return { "", false };
    }

    decrypt_len += tmp_len;

    return {{ reinterpret_cast<char*>(plain_buf), static_cast<unsigned int>(decrypt_len) }, true};
}

std::pair<std::string, bool> Crypt::hash(std::string algorithm, std::string data) {
    Hash hash { algorithm };

    if (!hash.digest_init()) {
        Error::openssl_err_out("EVP_DigestInit_ex2");
        return { "", false };
    }

    if (!hash.digest_update(data.c_str(), data.size())) {
        Error::openssl_err_out("EVP_DigestUpdate");
        return { "", false };
    }

    auto len = 0u;
    auto out = std::make_unique<void*>(OPENSSL_malloc(EVP_MD_get_size(hash.get_hash())));

    if (out.get() == nullptr) {
        Error::openssl_err_out("OPENSSL_malloc");
        return { "", false };
    }

    if (!hash.digest_final(reinterpret_cast<unsigned char*>(out.get()), &len)) {
        Error::openssl_err_out("EVP_DigestFinal_ex");
        return { "", false };
    }

    return {{ reinterpret_cast<char*>(out.get()), len }, true};
}