#ifndef INCLUDE_CIPHER_H
#define INCLUDE_CIPHER_H

#include <openssl/evp.h>
#include <openssl/err.h>
#include "cipher-context.hpp"
#include <string>

namespace crpt {

/**
 * @brief Manages an OpenSSL Cipher (see man EVP_CIPHER)
 */
class Cipher {
    private:
        CipherContext context;
        EVP_CIPHER* cipher;
        std::string name;
        std::string properties;
    
    public:
        /**
         * @brief See man EVP_CIPHER_fetch
         */
        Cipher(std::string name);

        /**
         * @brief See man EVP_CIPHER_fetch
         */
        Cipher(std::string name, std::string properties);

        Cipher(Cipher& c);

        Cipher(Cipher&& c);

        Cipher& operator=(Cipher& c);

        Cipher& operator=(Cipher&& c);

        ~Cipher();

        /**
         * @brief Initializes the cipher for encryption. See man EVP_EncryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @return bool The success or failure of the initialization.
         */
        bool encrypt_init(const unsigned char* key, const unsigned char* iv) const;

        /**
         * @brief Initializes the cipher for encryption. See man EVP_EncryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @param params Optional parameters.
         * @return bool The success or failure of the initialization.
         */
        bool encrypt_init(const unsigned char* key, const unsigned char* iv, OSSL_PARAM* params) const;
        
        /**
         * @brief Encrypts the content of msg and stores the result in out. See man EVP_EncryptUpdate
         * 
         * @param out The buffer to store the encrypted data.
         * @param out_len Will be set to the length of the data encrypted.
         * @param msg The data to encrypt.
         * @param msg_len The length of the data to encrypt.
         * @return bool The success or failure of the encryption attempt.
         */
        bool encrypt_update(unsigned char* out, int* out_len, const unsigned char* msg, int msg_len);
        
        /**
         * @brief Completes the initialized encryption. See man EVP_EncryptFinal_ex
         * 
         * @param out Pointer to the end of the encrypted data in the buffer written to.
         * @param tmp_len Stores the number of added bytes as a result of the call to final.
         * @return bool The success or failure of the finalization call.
         */
        bool encrypt_final(unsigned char* out, int* tmp_len);

        /**
         * @brief Initializes the cipher for decryption. See man EVP_DecryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @return bool The success or failure of the initialization.
         */
        bool decrypt_init(const unsigned char* key, const unsigned char* iv) const;

        /**
         * @brief Initializes the cipher for decryption. See man EVP_DecryptInit_ex2
         * 
         * @param key The symmetric key to use. Size depends on the algorithm.
         * @param iv The initialization vector, if required.
         * @param params Optional parameters.
         * @return bool The success or failure of the initialization.
         */
        bool decrypt_init(const unsigned char* key, const unsigned char* iv, OSSL_PARAM* params) const;
        
        /**
         * @brief Decrypts the content of msg and stores the result in out. See man EVP_DecryptUpdate
         * 
         * @param out The buffer to store the decrypted data.
         * @param out_len Will be set to the length of the data decrypted.
         * @param msg The data to decrypt.
         * @param msg_len The length of the data to decrypt.
         * @return bool The success or failure of the decryption attempt.
         */
        bool decrypt_update(unsigned char* out, int* out_len, const unsigned char* msg, int msg_len);
        
        /**
         * @brief Completes the initialized decryption. See man EVP_DecryptFinal_ex
         * 
         * @param out Pointer to the end of the decrypt data in the buffer written to.
         * @param tmp_len Stores the number of added bytes as a result of the call to final.
         * @return bool The success or failure of the finalization call.
         */
        bool decrypt_final(unsigned char* out, int* tmp_len);

        /**
         * @brief Get the cipher block size for the underlying algorithm. See man EVP_CIHPER_block_size
         * 
         * @return int 
         */
        int block_size();

        /**
         * @brief Get the cipher block size for the underlying algorithm. See man EVP_CIHPER_key_length
         * 
         * @return int 
         */
        int key_length();

        EVP_CIPHER* const get_cipher() const;
};

}

#endif
