#include <string>
#include <openssl/evp.h>
#include <openssl/x509.h>
#include "crypt/pkey.hpp"
#include "crypt/error.hpp"

using namespace crpt;

void PKey::generate_key(EVP_PKEY_CTX* ctx, OSSL_PARAM* params) {
    if (!ctx) return;

    if (EVP_PKEY_keygen_init(ctx) <= 0) {
        Error::openssl_err_out("EVP_PKEY_keygen_init");
        return;
    }
    if (EVP_PKEY_CTX_set_params(ctx, params) <= 0) {
        Error::openssl_err_out("EVP_PKEY_CTX_set_params");
        return;
    }
    if (EVP_PKEY_generate(ctx, &key) <= 0) {
        Error::openssl_err_out("EVP_PKEY_generate");
        return;
    }
}

PKey::PKey(EVP_PKEY_CTX* ctx, std::string group):
    key { nullptr }
{
    OSSL_PARAM params[] = {
        OSSL_PARAM_construct_utf8_string("group", const_cast<char*>(group.c_str()), 0),
        OSSL_PARAM_construct_end()
    };

    generate_key(ctx, params);
}

PKey::PKey(EVP_PKEY_CTX* ctx, OSSL_PARAM* params):
    key { nullptr }
{
    generate_key(ctx, params);
}

PKey::PKey(EVP_PKEY* key):
    key { key }
{}

PKey::PKey(): 
    key { nullptr }
{}

PKey::PKey(PKey& pkey):
    key { EVP_PKEY_dup(pkey.key) }
{}

PKey::PKey(PKey&& pkey):
    key { pkey.key }
{
    pkey.key = nullptr;
}

PKey::~PKey() {
    EVP_PKEY_free(key);
}

PKey& PKey::operator=(PKey& pkey) {
    key = EVP_PKEY_dup(pkey.key);

    return *this;
}

PKey& PKey::operator=(PKey&& pkey) {
    key = pkey.key;
    pkey.key = nullptr;
    
    return *this;
}

bool PKey::derive_set_peer(EVP_PKEY_CTX* ctx) const {
    if (EVP_PKEY_derive_set_peer(ctx, key) <= 0) {
        Error::openssl_err_out("EVP_PKEY_derive_set_peer");
        return false;
    }

    return true;
}

EVP_PKEY* const PKey::get_key() {
    return key;
}