#ifndef INCLUDE_CRYPT_H
#define INCLUDE_CRYPT_H

#include "cipher.hpp"
#include "cipher_context.hpp"

namespace crpt {

/**
 * @brief Provides OpenSSL symmetric encryption/decryption
 */
class Crypt {
    private:
        CipherContext context;
        Cipher cipher;

    public:
        /**
         * @brief Construct a new Crypt object
         * 
         * @tparam Args Should be synonymous to some Cipher constructor argument list, minus the leading EVP_CIPHER_CTX* arugment.
         * @param args See CipherContext::new_cipher(Args&&... args).
         */
        template <typename... Args>
        Crypt(Args&&... args):
            context {},
            cipher { context.new_cipher(std::forward<Args>(args)...) }
        {}

        inline bool context_is_null() const {
            return context.is_null();
        }

        inline bool cipher_is_null() const {
            return cipher.is_null();
        }

        std::pair<std::string, bool> encrypt(std::string plain_text, std::string key, std::string iv);
        std::pair<std::string, bool> decrypt(std::string cipher_text, std::string key, std::string iv);
};

}

#endif