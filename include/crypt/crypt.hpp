#ifndef INCLUDE_CRYPT_H
#define INCLUDE_CRYPT_H

#include "cipher.hpp"
#include "cipher-context.hpp"

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
         * @tparam Args should equal some Cipher constructor argument list.
         * @param args See Cipher.hpp
         */
        template <typename... Args>
        Crypt(Args&&... args):
            context {},
            cipher { std::forward<Args>(args)... }
        {}

        std::pair<std::string, bool> encrypt(std::string plain_text, std::string key, std::string iv);

        std::pair<std::string, bool> decrypt(std::string cipher_text, std::string key, std::string iv);

        static std::pair<std::string, bool> hash(std::string algorithm, std::string data);

        inline static std::pair<std::string, bool> hash(std::string data) {
            return hash("SHA3-256", data);
        }
};

}

#endif