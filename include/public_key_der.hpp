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
        int len;

    public:
        PublicKeyDER(): 
            public_key { nullptr },
            len { 0 }
        {}

        PublicKeyDER(PKey& key):
            public_key { nullptr }
        {
            len = i2d_PUBKEY(key.get_key(), &public_key);
        }

        PublicKeyDER(unsigned char* pk, int len):
            len { len }
        {
            if (pk == nullptr) {
                public_key = nullptr;
                len = 0;
                return;
            }

            public_key = (unsigned char*)OPENSSL_malloc(len);
            std::memcpy(public_key, pk, len);
        }

        PublicKeyDER(PublicKeyDER& pkd) {
            if (pkd.public_key == nullptr) {
                public_key = nullptr;
                len = 0;
                return;
            }

            public_key = (unsigned char*)OPENSSL_malloc(len);
            std::memcpy(public_key, pkd.public_key, pkd.len);
            len = pkd.len;
        }

        PublicKeyDER(PublicKeyDER&& pkd):
            public_key { pkd.public_key },
            len { pkd.len }
        {
            pkd.public_key = nullptr;
            pkd.len = 0;
        }

        ~PublicKeyDER() {
            OPENSSL_free(public_key);
        }

        inline const unsigned char* get_public_key() const {
            return public_key;
        }

        inline PKey get_key() {
            auto pk = get_public_key();
            return { d2i_PUBKEY(nullptr, &pk, len) };
        }
};

}

#endif