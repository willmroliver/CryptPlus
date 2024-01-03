#ifndef INCLUDE_PKEY_H
#define INCLUDE_PKEY_H

#include <string>
#include <openssl/evp.h>
#include <openssl/x509.h>
#include "error.hpp"

namespace crpt {

class PKey {
    private:
        EVP_PKEY_CTX* context;
        EVP_PKEY* key;

        unsigned char* pub_key = nullptr;
        int pub_key_len = 0;

        inline void generate_key(OSSL_PARAM* params) {
            if (!context) return;

            if (EVP_PKEY_keygen_init(context) <= 0) {
                Error::openssl_err_out("EVP_PKEY_keygen_init");
                return;
            }
            if (EVP_PKEY_CTX_set_params(context, params) <= 0) {
                Error::openssl_err_out("EVP_PKEY_CTX_set_params");
                return;
            }
            if (EVP_PKEY_generate(context, &key) <= 0) {
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
        /**
         * @brief Wraps an existing EVP_PKEY.
         * 
         * @param ctx The context. See man EVP_PKEY_CTX
         * @param key The key. See man EVP_PKEY
         */
        PKey(EVP_PKEY_CTX* ctx, EVP_PKEY* key): 
            context { ctx },
            key { key }
        {}
        /**
         * @brief Derives an EVP_PKEY in DER format from the given public key. See man i2d_PUBKEY & man d2i_PUBKEY
         * 
         * @param pub_key_str The public key
         */
        PKey(std::string pub_key_str): 
            context { nullptr }
        {
            auto pub_key_raw = reinterpret_cast<const unsigned char*>(pub_key_str.c_str());
            pub_key_len = pub_key_str.size();
            key = d2i_PUBKEY(nullptr, &pub_key_raw, pub_key_str.size());
            pub_key = const_cast<unsigned char*>(pub_key_raw);
        }
        PKey(): 
            context { nullptr },
            key { nullptr }
        {}
        PKey(PKey& pkey) = delete;
        PKey(PKey&& pkey) = default;
        PKey& operator=(PKey&& pkey) = default;
        ~PKey() {
            EVP_PKEY_free(key);
            OPENSSL_free(pub_key);
        }

        inline bool is_null() const {
            return key == nullptr;
        }

        inline std::pair<unsigned char*, int> get_pub_key() {
            if (pub_key == nullptr) {
                pub_key_len = i2d_PUBKEY(key, &pub_key);
            }

            return { pub_key, pub_key_len };
        }
};

}

#endif