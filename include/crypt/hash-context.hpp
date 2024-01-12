#ifndef INCLUDE_HASH_CONTEXT_H
#define INCLUDE_HASH_CONTEXT_H

#include <openssl/evp.h>

namespace crpt {

/**
 * @brief Manages a hash (md) context; see man crypto & man EVP_MD_fetch
 */
class HashContext {
    private:
        EVP_MD_CTX* context;

    public:
        HashContext();

        HashContext(HashContext& c);

        HashContext(HashContext&& c);

        ~HashContext();

        HashContext& operator=(HashContext& c);

        HashContext& operator=(HashContext&& c);
        
        EVP_MD_CTX* const get_context() const;
};

}

#endif