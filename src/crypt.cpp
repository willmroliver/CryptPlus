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

std::pair<std::vector<char>, bool> Crypt::encrypt(std::vector<char> plain_text, std::vector<char> key, std::vector<char> iv) {
    if (key.size() < cipher.key_length()) {
        std::cerr << "crypt: key too small, expecting " << cipher.key_length() << " bytes, got " << key.size() << std::endl;
        return { {}, false };
    }

    auto k = reinterpret_cast<const unsigned char*>(key.data());
    auto i = reinterpret_cast<const unsigned char*>(iv.data());

    auto max_cipher_text_len = plain_text.size() + cipher.block_size() - 1;
    auto cipher_buf = new unsigned char[max_cipher_text_len];

    if (!cipher.encrypt_init(k, i)) {
        Error::openssl_err_out("EVP_EncryptInit_ex2");
        return { {}, false };
    }

    auto encrypt_len = 0;
    auto u_plain = reinterpret_cast<const unsigned char*>(plain_text.data());
    if (!cipher.encrypt_update(cipher_buf, &encrypt_len, u_plain, plain_text.size())) {
        Error::openssl_err_out("EVP_EncryptUpdate");
        return { {}, false };
    }

    auto tmp_len = 0;
    if (!cipher.encrypt_final(cipher_buf + encrypt_len, &tmp_len)) {
        Error::openssl_err_out("EVP_EncryptFinal_ex");
        return { {}, false };
    }

    encrypt_len += tmp_len;

    return {{ cipher_buf, cipher_buf + encrypt_len }, true};
}

std::pair<std::vector<char>, bool> Crypt::decrypt(std::vector<char> cipher_text, std::vector<char> key, std::vector<char> iv) {
        if (key.size() < cipher.key_length()) {
        std::cerr << "crypt: key too small, expecting " << cipher.key_length() << " bytes, got " << key.size() << std::endl;
        return { {}, false };
    }

    auto k = reinterpret_cast<const unsigned char*>(key.data());
    auto i = reinterpret_cast<const unsigned char*>(iv.data());

    auto max_plain_text_len = cipher_text.size() + cipher.block_size() - 1;
    auto plain_buf = new unsigned char[max_plain_text_len];

    if (!cipher.decrypt_init(k, i)) {
        Error::openssl_err_out("EVP_DecryptInit_ex2");
        return { {}, false };
    }

    auto decrypt_len = 0;
    auto u_cipher = reinterpret_cast<const unsigned char*>(cipher_text.data());
    if (!cipher.decrypt_update(plain_buf, &decrypt_len, u_cipher, cipher_text.size())) {
        Error::openssl_err_out("EVP_DecryptUpdate");
        return { {}, false };
    }

    auto tmp_len = 0;
    if (!cipher.decrypt_final(plain_buf + decrypt_len, &tmp_len)) {
        Error::openssl_err_out("EVP_DecryptFinal_ex");
        return { {}, false };
    }

    decrypt_len += tmp_len;

    return {{ plain_buf, plain_buf + decrypt_len }, true};
}

std::pair<std::vector<char>, bool> Crypt::hash(std::string algorithm, std::vector<char> data) {
    Hash hash { algorithm };

    if (!hash.digest_init()) {
        Error::openssl_err_out("EVP_DigestInit_ex2");
        return { {}, false };
    }

    if (!hash.digest_update(data.data(), data.size())) {
        Error::openssl_err_out("EVP_DigestUpdate");
        return { {}, false };
    }

    auto len = 0u;
    auto out = OPENSSL_malloc(EVP_MD_get_size(hash.get_hash()));

    if (out == nullptr) {
        OPENSSL_free(out);
        Error::openssl_err_out("OPENSSL_malloc");
        return { {}, false };
    }

    if (!hash.digest_final(reinterpret_cast<unsigned char*>(out), &len)) {
        OPENSSL_free(out);
        Error::openssl_err_out("EVP_DigestFinal_ex");
        return { {}, false };
    }

    auto out_chars = reinterpret_cast<char*>(out);
    std::vector<char> result { out_chars, out_chars + len };

    OPENSSL_free(out);
    
    return { result, true };
}