#ifndef INCLUDE_PKEY_CONTEXT_H
#define INCLUDE_PKEY_CONTEXT_H

#include <string>
#include <openssl/evp.h>
#include "pkey.hpp"

namespace crpt {

class PKeyContext {
    private:
        EVP_PKEY_CTX* context;

    public:
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
        PKeyContext(PKeyContext& ctx) = delete;
        PKeyContext(PKeyContext&& ctx) = delete;
        ~PKeyContext() {
            EVP_PKEY_CTX_free(context);
        }

        inline bool is_null() const {
            return context == nullptr;
        }
        
        /**
         * @brief Generates a private key from this context with the default safe-prime group choice for Diffie-Hellman.
         * Injects the context as the first constructor arg and passes any additional valid PKey constructor args. 
         * 
         * See PKey(EVP_PKEY_CTX*, std::string), PKey(EVP_PKEY_CTX*, OSSL_PARAM*)
         * 
         * @tparam Args A valid constructor argument list for PKey, minus the leading EVP_PKEY_CTX* arg.
         * @param args The arguments to be passed.
         * @return PKey 
         */
        template <typename... Args>
        inline PKey new_pkey(Args... args) const {
            return { context, ...args };
        }
};

}

#endif