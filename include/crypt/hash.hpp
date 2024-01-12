#ifndef INCLUDE_HASH_H
#define INCLUDE_HASH_H

#include <openssl/evp.h>
#include <openssl/err.h>

#include "error.hpp"
#include "hash-context.hpp"

namespace crpt {

/**
 * @brief Manages an OpenSSL Hash (Message Digest) (see man EVP_MD_fetch)
 */
class Hash {
    private:
        HashContext context;
        EVP_MD* hash;
        std::string name;
        std::string properties;
    
    public:
        /**
         * @brief See man EVP_MD_fetch
         */
        Hash(std::string name);

        /**
         * @brief See man EVP_MD_fetch
         */
        Hash(std::string name, std::string properties);

        Hash(Hash& c);

        Hash(Hash&& c);

        Hash& operator=(Hash& c);

        Hash& operator=(Hash&& c);

        ~Hash();

        /**
         * @brief Initializes the context for hashing. See man EVP_DigestInit_ex2
         * 
         * @return bool The success or failure of the initialization.
         */
        bool digest_init() const;

        /**
         * @brief Initializes the context for hashing. See man EVP_DigestInit_ex2
         * 
         * @param params Optional parameters.
         * @return bool The success or failure of the initialization.
         */
        bool digest_init(OSSL_PARAM* params) const;
        
        /**
         * @brief Digests the content of msg and stores the result in out. See man EVP_DigestUpdate
         *
         * @param data The data to be hashed.
         * @param n The number of bytes of data to hash.
         * @return bool The success or failure of the hashing attempt.
         */
        bool digest_update(const void* data, size_t n);
        
        /**
         * @brief Completes the initialized hashing. See man EVP_DigestFinal_ex
         * 
         * @param out Hashed data will be written to this.
         * @param len Stores the number of bytes in the final hash.
         * @return bool The success or failure of the finalization call.
         */
        bool digest_final(unsigned char* out, unsigned* len);

        /**
         * @brief Get the context block size for the underlying algorithm. See man EVP_CIHPER_block_size
         * 
         * @return int 
         */
        int block_size();

        EVP_MD* const get_hash() const;
};

}

#endif