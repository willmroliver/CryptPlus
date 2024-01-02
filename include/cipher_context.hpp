#ifndef INCLUDE_CIPHER_CONTEXT_H
#define INCLUDE_CIPHER_CONTEXT_H

#include <openssl/evp.h>
#include "cipher.hpp"

namespace crpt {

/**
 * @brief Manages a cipher context; see man crypto(7)
 */
class CipherContext {
    private:
        EVP_CIPHER_CTX* context;
    
    public:
        CipherContext(): 
            context { EVP_CIPHER_CTX_new() }
        {}
        CipherContext(CipherContext& c) {
            EVP_CIPHER_CTX_copy(c.context, context);
        }
        CipherContext(CipherContext&& c) {
            c.context = context;
            context = nullptr;
        }
        ~CipherContext() {
            EVP_CIPHER_CTX_free(context);
        }
        inline bool is_null() const { 
            return context == nullptr;
        };

        /**
         * @brief Returns a new Cipher object
         * 
         * @tparam Args When well-formed, is synonymous to some Cipher constructor argument list, except for the first arg, EVP_CIPHER_CTX*, which will be injected.
         * @param args Some Cipher constructor argument list, minus the leading EVP_CIPHER_CTX* argument.
         * @return Cipher 
         */
        template<typename... Args>
        inline Cipher new_cipher(Args&&... args) const {
            return Cipher(context, std::forward<Args>(args)...);
        }
};

}

#endif