#include <openssl/evp.h>
#include "crypt/cipher-context.hpp"

using namespace crpt;

CipherContext::CipherContext(): 
    context { EVP_CIPHER_CTX_new() }
{}

CipherContext::CipherContext(CipherContext& c) {
    EVP_CIPHER_CTX_copy(context, c.context);
}

CipherContext::CipherContext(CipherContext&& c) {
    c.context = context;
    context = nullptr;
}

CipherContext::~CipherContext() {
    EVP_CIPHER_CTX_free(context);
}

CipherContext& CipherContext::operator=(CipherContext& c) {
    EVP_CIPHER_CTX_copy(context, c.context);
    return *this;
}

CipherContext& CipherContext::operator=(CipherContext&& c) {
    c.context = context;
    context = nullptr;
    return *this;
}

EVP_CIPHER_CTX* const CipherContext::get_context() const {
    return context;
}