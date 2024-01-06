#include <openssl/evp.h>
#include <openssl/x509.h>
#include <cstring>
#include "pkey.hpp"
#include "public-key-der.hpp"

using namespace crpt;

PublicKeyDER::PublicKeyDER(): 
    public_key { nullptr },
    len { 0 }
{}

PublicKeyDER::PublicKeyDER(PKey& key):
    public_key { nullptr }
{
    len = i2d_PUBKEY(key.get_key(), &public_key);
}

PublicKeyDER::PublicKeyDER(unsigned char* pk, int len):
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

PublicKeyDER::PublicKeyDER(PublicKeyDER& pkd) {
    if (pkd.public_key == nullptr) {
        public_key = nullptr;
        len = 0;
        return;
    }

    public_key = (unsigned char*)OPENSSL_malloc(len);
    std::memcpy(public_key, pkd.public_key, pkd.len);
    len = pkd.len;
}

PublicKeyDER::PublicKeyDER(PublicKeyDER&& pkd):
    public_key { pkd.public_key },
    len { pkd.len }
{
    pkd.public_key = nullptr;
    pkd.len = 0;
}

PublicKeyDER::~PublicKeyDER() {
    OPENSSL_free(public_key);
}

const unsigned char* PublicKeyDER::get_public_key() const {
    return public_key;
}

PKey PublicKeyDER::get_key() {
    auto pk = get_public_key();
    return { d2i_PUBKEY(nullptr, &pk, len) };
}