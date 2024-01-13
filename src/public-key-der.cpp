#include <openssl/evp.h>
#include <openssl/x509.h>
#include <cstring>
#include "crypt/pkey.hpp"
#include "crypt/public-key-der.hpp"
#include "crypt/error.hpp"

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

PublicKeyDER::PublicKeyDER(unsigned char* pk, size_t len):
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

const unsigned char* const PublicKeyDER::get_public_key() const {
    return public_key;
}

int PublicKeyDER::get_len() const {
    return len;
}

PKey PublicKeyDER::get_key() {
    auto pk = get_public_key();
    auto k = d2i_PUBKEY(nullptr, &pk, len);

    if (k == nullptr) {
        Error::openssl_err_out("d2i_PUBKEY");
    }

    return { k };
}

std::vector<char> PublicKeyDER::to_vector() const {
    if (public_key == nullptr || len == 0) {
        return {};
    }

    return { public_key, public_key + len };
}

void PublicKeyDER::from_vector(std::vector<char> data) {
    if (data.size() == 0) return;
    len = data.size();

    OPENSSL_free(public_key);
    public_key = (unsigned char*)OPENSSL_malloc(data.size());

    std::memcpy(public_key, data.data(), len);
}