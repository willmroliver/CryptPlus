#ifndef INCLUDE_CIPHER_H
#define INCLUDE_CIPHER_H

#include <openssl/evp.h>
#include <openssl/err.h>

#include "util.hpp"

namespace crpt {

/**
 * @brief Manages an OpenSSL Cipher (see man EVP_CIPHER)
 */
class Cipher {
    private:
        EVP_CIPHER_CTX* context;
        EVP_CIPHER* cipher;
    
    public:
        /**
         * @brief See man EVP_CIPHER_fetch
         */
        Cipher(EVP_CIPHER_CTX* ctx, std::string name):
            context { ctx },
            cipher { EVP_CIPHER_fetch(nullptr, name.c_str(), nullptr) }
        {
            if (cipher == nullptr) {
                err_out();
            }
        }
        /**
         * @brief See man EVP_CIPHER_fetch
         */
        Cipher(EVP_CIPHER_CTX* ctx, std::string name, OSSL_LIB_CTX* c):
            context { ctx },
            cipher { EVP_CIPHER_fetch(c, name.c_str(), nullptr) }
        {
            if (cipher == nullptr) {
                err_out();
            }
        }
        /**
         * @brief See man EVP_CIPHER_fetch
         */
        Cipher(EVP_CIPHER_CTX* ctx, std::string name, OSSL_LIB_CTX* c, std::string properties):
            context { ctx },
            cipher { EVP_CIPHER_fetch(c, name.c_str(), properties.c_str()) }
        {
            if (cipher == nullptr) {
                err_out();
            }
        }
        /**
         * @brief See man EVP_CIPHER_fetch
         */
        Cipher(EVP_CIPHER_CTX* ctx, std::string name, std::string properties):
            context { ctx },
            cipher { EVP_CIPHER_fetch(nullptr, name.c_str(), properties.c_str()) }
        {
            if (cipher == nullptr) {
                err_out();
            }
        }
        Cipher(Cipher& c) = default;
        Cipher(Cipher&& c) = default;
        ~Cipher() {
            EVP_CIPHER_free(cipher);
        }

        inline bool is_null() const {
            return cipher == nullptr;
        };

        /**
         * @brief Initializes the cipher for encryption. See man EVP_EncryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @return bool The success or failure of the initialization.
         */
        inline bool encrypt_init(const unsigned char* key, const unsigned char* iv) const {
            return EVP_EncryptInit_ex2(context, cipher, key, iv, nullptr);
        }

        /**
         * @brief Initializes the cipher for encryption. See man EVP_EncryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @param params Optional parameters.
         * @return bool The success or failure of the initialization.
         */
        inline bool encrypt_init(const unsigned char* key, const unsigned char* iv, OSSL_PARAM* params) const {
            return EVP_EncryptInit_ex2(context, cipher, key, iv, params);
        }
        
        /**
         * @brief Encrypts the content of msg and stores the result in out. See man EVP_EncryptUpdate
         * 
         * @param out The buffer to store the encrypted data.
         * @param out_len Will be set to the length of the data encrypted.
         * @param msg The data to encrypt.
         * @param msg_len The length of the data to encrypt.
         * @return bool The success or failure of the encryption attempt.
         */
        inline bool encrypt_update(unsigned char* out, int* out_len, const unsigned char* msg, int msg_len) {
            return EVP_EncryptUpdate(context, out, out_len, msg, msg_len);
        }
        
        /**
         * @brief Completes the initialized encryption. See man EVP_EncryptFinal_ex
         * 
         * @param out Pointer to the end of the encrypted data in the buffer written to.
         * @param tmp_len Stores the number of added bytes as a result of the call to final.
         * @return bool The success or failure of the finalization call.
         */
        inline bool encrypt_final(unsigned char* out, int* tmp_len) {
            return EVP_EncryptFinal_ex(context, out, tmp_len);
        }

        /**
         * @brief Initializes the cipher for decryption. See man EVP_DecryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @return bool The success or failure of the initialization.
         */
        inline bool decrypt_init(const unsigned char* key, const unsigned char* iv) const {
            return EVP_DecryptInit_ex2(context, cipher, key, iv, nullptr);
        }

        /**
         * @brief Initializes the cipher for decryption. See man EVP_DecryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @param params Optional parameters.
         * @return bool The success or failure of the initialization.
         */
        inline bool decrypt_init(const unsigned char* key, const unsigned char* iv, OSSL_PARAM* params) const {
            return EVP_DecryptInit_ex2(context, cipher, key, iv, params);
        }
        
        /**
         * @brief Decrypts the content of msg and stores the result in out. See man EVP_DecryptUpdate
         * 
         * @param out The buffer to store the decrypted data.
         * @param out_len Will be set to the length of the data decrypted.
         * @param msg The data to decrypt.
         * @param msg_len The length of the data to decrypt.
         * @return bool The success or failure of the decryption attempt.
         */
        inline bool decrypt_update(unsigned char* out, int* out_len, const unsigned char* msg, int msg_len) {
            return EVP_DecryptUpdate(context, out, out_len, msg, msg_len);
        }
        
        /**
         * @brief Completes the initialized decryption. See man EVP_DecryptFinal_ex
         * 
         * @param out Pointer to the end of the decrypt data in the buffer written to.
         * @param tmp_len Stores the number of added bytes as a result of the call to final.
         * @return bool The success or failure of the finalization call.
         */
        inline bool decrypt_final(unsigned char* out, int* tmp_len) {
            return EVP_DecryptFinal_ex(context, out, tmp_len);
        }

        /**
         * @brief Get the cipher block size for the underlying algorithm. See man EVP_CIHPER_block_size
         * 
         * @return int 
         */
        inline int block_size() {
            return EVP_CIPHER_block_size(cipher);
        }

        /**
         * @brief Get the cipher block size for the underlying algorithm. See man EVP_CIHPER_key_length
         * 
         * @return int 
         */
        inline int key_length() {
            return EVP_CIPHER_key_length(cipher);
        }
};

}

#endif