#ifndef INCLUDE_PKEY_H
#define INCLUDE_PKEY_H

#include <string>
#include <openssl/evp.h>
#include <openssl/x509.h>
#include "error.hpp"

namespace crpt {

class PKey {
    private:
        EVP_PKEY* key;

        void generate_key(EVP_PKEY_CTX* ctx, OSSL_PARAM* params);
    
    public:
        /**
         * @brief Generates a key from the given context.
         * Assumes that the key is for Diffie-Hellman and sets the safe-prime group specified as an OSSL_PARAM. 
         * See man EVP_PKEY_CTX_set_params
         * 
         * @param ctx The context. See man EVP_PKEY_CTX & man EVP_PKEY_keygen_init
         * @param group The safe-prime group. See man EVP_PKEY-DH
         */
        PKey(EVP_PKEY_CTX* ctx, std::string group);

        /**
         * @brief Generates a key from the given context. 
         * Sets whatever OSSL_PARAMs are passed. 
         * See man EVP_PKEY_CTX_set_params
         * 
         * @param ctx The context. See man EVP_PKEY_CTX & man EVP_PKEY_keygen_init
         * @param params The OSSL_PARAMs to pass to EVP_PKEY_CTX_set_params()
         */
        PKey(EVP_PKEY_CTX* ctx, OSSL_PARAM* params);

        /**
         * @brief Wraps an existing EVP_PKEY.
         * 
         * @param ctx The context. See man EVP_PKEY_CTX
         * @param key The key. See man EVP_PKEY
         */
        PKey(EVP_PKEY* key);

        PKey();

        PKey(PKey& pkey);

        PKey(PKey&& pkey);

        ~PKey();

        PKey& operator=(PKey& pkey);

        PKey& operator=(PKey&& pkey);

        /**
         * @brief See man EVP_PKEY_derive_set_peer
         * 
         * @param ctx The context. See man EVP_PKEY_CTX
         */
        bool derive_set_peer(EVP_PKEY_CTX* ctx) const;

        EVP_PKEY* const get_key();
};

}

#endif