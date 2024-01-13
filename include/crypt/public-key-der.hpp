#ifndef INCLUDE_PUBLIC_KEY_DER_H
#define INCLUDE_PUBLIC_KEY_DER_H

#include <openssl/evp.h>
#include <openssl/x509.h>
#include <cstring>
#include "pkey.hpp"

namespace crpt {

/**
 * @brief Manages the memory space for a DER-formatted public key buffer. See man i2d_PUBKEY & man d2i_PUBKEY
 */
class PublicKeyDER {
    private:
        unsigned char* public_key;
        size_t len;

    public:
        PublicKeyDER();

        PublicKeyDER(PKey& key);

        PublicKeyDER(unsigned char* pk, size_t len);

        PublicKeyDER(PublicKeyDER& pkd);

        PublicKeyDER(PublicKeyDER&& pkd);

        ~PublicKeyDER();

        /**
         * @brief See man i2d_PUBKEY
         * 
         * @return const unsigned char* 
         */
        const unsigned char* const get_public_key() const;

        /**
         * @brief See man i2d_PUBKEY
         * 
         */
        int get_len() const;
        
        /**
         * @brief See man d2i_PUBKEY
         * 
         * @return PKey 
         */
        PKey get_key();

        /**
         * @brief Returns a std::string holding the key data.
         * 
         * @return std::string 
         */
        std::vector<char> to_vector() const;

        /**
         * @brief Marshalls the input string into the class fields.
         * 
         */
        void from_vector(std::vector<char> key_str);
};

}

#endif