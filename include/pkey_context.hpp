#ifndef INCLUDE_PKEY_CONTEXT_H
#define INCLUDE_PKEY_CONTEXT_H

#include <string>
#include <openssl/evp.h>
#include "pkey.hpp"
#include "error.hpp"

namespace crpt {

class PKeyContext {
    private:
        EVP_PKEY_CTX* context;

    public:
        PKeyContext(EVP_PKEY* key): 
            context { EVP_PKEY_CTX_new_from_pkey(nullptr, key, nullptr) }
        {}
        PKeyContext(std::string name):
            context { EVP_PKEY_CTX_new_from_name(nullptr, name.c_str(), nullptr) }
        {}
        PKeyContext(std::string name, OSSL_LIB_CTX* libctx, std::string propquery):
            context { EVP_PKEY_CTX_new_from_name(libctx, name.c_str(), propquery.c_str()) }
        {}
        PKeyContext(std::string name, OSSL_LIB_CTX* libctx):
            context { EVP_PKEY_CTX_new_from_name(libctx, name.c_str(), nullptr) }
        {}
        PKeyContext(std::string name, std::string propquery):
            context { EVP_PKEY_CTX_new_from_name(nullptr, name.c_str(), propquery.c_str()) }
        {}
        PKeyContext(PKeyContext& ctx): 
            context { EVP_PKEY_CTX_dup(ctx.context) }
        {}
        PKeyContext(PKeyContext&& ctx): 
            context { ctx.context }
        {
            ctx.context = nullptr;
        }
        ~PKeyContext() {
            EVP_PKEY_CTX_free(context);
        }
        PKeyContext& operator=(PKeyContext& ctx) {
            context = EVP_PKEY_CTX_dup(ctx.context);

            return *this;
        }
        PKeyContext& operator=(PKeyContext&& ctx) {
            context = ctx.context;
            ctx.context = nullptr;

            return *this;
        }

        /**
         * @brief Set EVP_PKEY_CTX parameters. See man EVP_PKEY_CTX_set_params
         * 
         * @param params The parameters to set
         * @return The success or failure of the call to EVP_PKEY_CTX_set_params
         */
        inline bool set_params(const OSSL_PARAM* params) const {
            if (EVP_PKEY_CTX_set_params(context, params) <= 0) {
                Error::openssl_err_out("EVP_PKEY_CTX_set_params");
                return false;
            }

            return true;
        }

        /**
         * @brief Calls EVP_PKEY_derive_init on the context. See man EVP_PKEY_derive_init
         * 
         * @return bool The success or failure of the call 
         */
        inline bool derive_init() const {
            if (EVP_PKEY_derive_init(context) <= 0) {
                Error::openssl_err_out("EVP_PKEY_derive_init");
                return false;
            }

            return true;
        }

        /**
         * @brief Calls EVP_PKEY_derive with a null buffer to retrieve the derived secret length. See man EVP_PKEY_derive
         * 
         * @param secret_len Pointer to store the result in
         * @return bool The success or failure of the call
         */
        inline bool derive_len(size_t* secret_len) const {
            if (EVP_PKEY_derive(context, nullptr, secret_len) <= 0) {
                Error::openssl_err_out("EVP_PKEY_CTX_set_params");
                return false;
            }

            return true;
        }

        /**
         * @brief Derives a shared secret. See man EVP_PKEY_derive
         * 
         * @param secret Buffer to write the secret to
         * @param secret_len Pointer to the length of the secret. See PKeyContext::pkey_derive_len
         * @return bool The success or failure of the call
         */
        inline bool derive(unsigned char* secret, size_t* secret_len) const {
            if (EVP_PKEY_derive(context, secret, secret_len) <= 0) {
                Error::openssl_err_out("EVP_PKEY_CTX_set_params");
                return false;
            }

            return true;
        }

        inline EVP_PKEY_CTX* const get_context() const {
            return context;
        }

        inline bool is_null() const {
            return context == nullptr;
        }
};

}

#endif