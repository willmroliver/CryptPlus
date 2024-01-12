#ifndef INCLUDE_CIPHER_CONTEXT_H
#define INCLUDE_CIPHER_CONTEXT_H

#include <openssl/evp.h>

namespace crpt {

/**
 * @brief Manages a cipher context; see man crypto & man EVP_CIPHER_fetch
 */
class CipherContext {
    private:
        EVP_CIPHER_CTX* context;
    
    public:
        CipherContext();

        CipherContext(CipherContext& c);

        CipherContext(CipherContext&& c);

        ~CipherContext();

        CipherContext& operator=(CipherContext& c);

        CipherContext& operator=(CipherContext&& c);
        
        EVP_CIPHER_CTX* const get_context() const;
};

}

#endif