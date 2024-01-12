#ifndef INCLUDE_PKEY_CONTEXT_H
#define INCLUDE_PKEY_CONTEXT_H

#include <string>
#include <openssl/evp.h>
#include "pkey.hpp"
#include "error.hpp"

namespace crpt {

/**
 * @brief Manages an EVP_PKEY_CTX* structure. See man EVP_PKEY_CTX_new
 */
class PKeyContext {
    private:
        EVP_PKEY_CTX* context;

    public:
        PKeyContext(EVP_PKEY* key);

        PKeyContext(std::string name);

        PKeyContext(std::string name, OSSL_LIB_CTX* libctx, std::string propquery);

        PKeyContext(std::string name, OSSL_LIB_CTX* libctx);

        PKeyContext(std::string name, std::string propquery);

        PKeyContext(PKeyContext& ctx);

        PKeyContext(PKeyContext&& ctx);

        ~PKeyContext();

        PKeyContext& operator=(PKeyContext& ctx);

        PKeyContext& operator=(PKeyContext&& ctx);

        /**
         * @brief Set EVP_PKEY_CTX parameters. See man EVP_PKEY_CTX_set_params
         * 
         * @param params The parameters to set
         * @return The success or failure of the call to EVP_PKEY_CTX_set_params
         */
        bool set_params(const OSSL_PARAM* params) const;

        /**
         * @brief Calls EVP_PKEY_derive_init on the context. See man EVP_PKEY_derive_init
         * 
         * @return bool The success or failure of the call 
         */
        bool derive_init() const;

        /**
         * @brief Calls EVP_PKEY_derive with a null buffer to retrieve the derived secret length. See man EVP_PKEY_derive
         * 
         * @param secret_len Pointer to store the result in
         * @return bool The success or failure of the call
         */
        bool derive_len(size_t* secret_len) const;

        /**
         * @brief Derives a shared secret. See man EVP_PKEY_derive
         * 
         * @param secret Buffer to write the secret to
         * @param secret_len Pointer to the length of the secret. See PKeyContext::pkey_derive_len
         * @return bool The success or failure of the call
         */
        bool derive(unsigned char* secret, size_t* secret_len) const;

        EVP_PKEY_CTX* const get_context() const;
};

}

#endif