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

        std::pair<std::vector<char>, bool> encrypt(std::vector<char> plain_text, std::vector<char> key, std::vector<char> iv);

        std::pair<std::vector<char>, bool> decrypt(std::vector<char> cipher_text, std::vector<char> key, std::vector<char> iv);

        static std::pair<std::vector<char>, bool> hash(std::string algorithm, std::vector<char> data);

        inline static std::pair<std::vector<char>, bool> hash(std::vector<char> data) {
            return hash("SHA3-256", data);
        }
};

}

#endif