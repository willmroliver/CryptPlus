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

        inline void generate_key(EVP_PKEY_CTX* ctx, OSSL_PARAM* params) {
            if (!ctx) return;

            if (EVP_PKEY_keygen_init(ctx) <= 0) {
                Error::openssl_err_out("EVP_PKEY_keygen_init");
                return;
            }
            if (EVP_PKEY_CTX_set_params(ctx, params) <= 0) {
                Error::openssl_err_out("EVP_PKEY_CTX_set_params");
                return;
            }
            if (EVP_PKEY_generate(ctx, &key) <= 0) {
                Error::openssl_err_out("EVP_PKEY_generate");
                return;
            }
        }
    
    public:
        /**
         * @brief Generates a key from the given context.
         * Assumes that the key is for Diffie-Hellman and sets the safe-prime group specified as an OSSL_PARAM. 
         * See man EVP_PKEY_CTX_set_params
         * 
         * @param ctx The context. See man EVP_PKEY_CTX & man EVP_PKEY_keygen_init
         * @param group The safe-prime group. See man EVP_PKEY-DH
         */
        PKey(EVP_PKEY_CTX* ctx, std::string group):
            key { nullptr }
        {
            OSSL_PARAM params[] = {
                OSSL_PARAM_construct_utf8_string("group", const_cast<char*>(group.c_str()), 0),
                OSSL_PARAM_construct_end()
            };

            generate_key(ctx, params);
        }
        /**
         * @brief Generates a key from the given context. 
         * Sets whatever OSSL_PARAMs are passed. 
         * See man EVP_PKEY_CTX_set_params
         * 
         * @param ctx The context. See man EVP_PKEY_CTX & man EVP_PKEY_keygen_init
         * @param params The OSSL_PARAMs to pass to EVP_PKEY_CTX_set_params()
         */
        PKey(EVP_PKEY_CTX* ctx, OSSL_PARAM* params):
            key { nullptr }
        {
            generate_key(ctx, params);
        }
        /**
         * @brief Wraps an existing EVP_PKEY.
         * 
         * @param ctx The context. See man EVP_PKEY_CTX
         * @param key The key. See man EVP_PKEY
         */
        PKey(EVP_PKEY* key):
            key { key }
        {}

        PKey(): 
            key { nullptr }
        {}

        PKey(PKey& pkey):
            key { EVP_PKEY_dup(pkey.key) }
        {}

        PKey(PKey&& pkey):
            key { pkey.key }
        {
            pkey.key = nullptr;
        }

        ~PKey() {
            EVP_PKEY_free(key);
        }

        PKey& operator=(PKey& pkey) {
            key = EVP_PKEY_dup(pkey.key);

            return *this;
        }

        PKey& operator=(PKey&& pkey) {
            key = pkey.key;
            pkey.key = nullptr;
            
            return *this;
        }

        /**
         * @brief See man EVP_PKEY_derive_set_peer
         * 
         * @param ctx The context. See man EVP_PKEY_CTX
         */
        inline bool derive_set_peer(EVP_PKEY_CTX* ctx) const {
            if (EVP_PKEY_derive_set_peer(ctx, key) <= 0) {
                Error::openssl_err_out("EVP_PKEY_derive_set_peer");
                return false;
            }

            return true;
        }

        inline EVP_PKEY* const get_key() {
            return key;
        }

        inline bool is_null() const {
            return key == nullptr;
        }
};

}

#endif