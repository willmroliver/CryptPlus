#ifndef INCLUDE_PKEY_H
#define INCLUDE_PKEY_H

#include <string>
#include <openssl/evp.h>
#include "util.hpp"

namespace crpt {

class PKey {
    private:
        EVP_PKEY_CTX* context;
        EVP_PKEY* key;

        inline void generate_key(OSSL_PARAM* params) {
            if (!context) return;

            if (EVP_PKEY_keygen_init(context) <= 0) {
                err_out();
                return;
            }
            if (!EVP_PKEY_CTX_set_params(context, params) <= 0) {
                err_out();
                return;
            }
            if (!EVP_PKEY_generate(context, &key) <= 0) {
                err_out();
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
            context { ctx },
            key { nullptr }
        {
            OSSL_PARAM params[] = {
                OSSL_PARAM_construct_utf8_string("group", const_cast<char*>(group.c_str()), 0),
                OSSL_PARAM_construct_end()
            };

            generate_key(params);
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
            context { ctx },
            key { nullptr }
        {
            generate_key(params);
        }
        PKey(PKey& pkey) = delete;
        PKey(PKey&& pkey) = default;
        ~PKey() {
            EVP_PKEY_free(key);
        }

        inline bool is_null() const {
            return key == nullptr;
        }
};

}

#endif