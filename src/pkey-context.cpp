#include <string>
#include <openssl/evp.h>
#include "pkey-context.hpp"
#include "pkey.hpp"
#include "error.hpp"

using namespace crpt;

PKeyContext::PKeyContext(EVP_PKEY* key): 
    context { EVP_PKEY_CTX_new_from_pkey(nullptr, key, nullptr) }
{}

PKeyContext::PKeyContext(std::string name):
    context { EVP_PKEY_CTX_new_from_name(nullptr, name.c_str(), nullptr) }
{}

PKeyContext::PKeyContext(std::string name, OSSL_LIB_CTX* libctx, std::string propquery):
    context { EVP_PKEY_CTX_new_from_name(libctx, name.c_str(), propquery.c_str()) }
{}

PKeyContext::PKeyContext(std::string name, OSSL_LIB_CTX* libctx):
    context { EVP_PKEY_CTX_new_from_name(libctx, name.c_str(), nullptr) }
{}

PKeyContext::PKeyContext(std::string name, std::string propquery):
    context { EVP_PKEY_CTX_new_from_name(nullptr, name.c_str(), propquery.c_str()) }
{}

PKeyContext::PKeyContext(PKeyContext& ctx): 
    context { EVP_PKEY_CTX_dup(ctx.context) }
{}

PKeyContext::PKeyContext(PKeyContext&& ctx): 
    context { ctx.context }
{
    ctx.context = nullptr;
}

PKeyContext::~PKeyContext() {
    EVP_PKEY_CTX_free(context);
}

PKeyContext& PKeyContext::operator=(PKeyContext& ctx) {
    context = EVP_PKEY_CTX_dup(ctx.context);

    return *this;
}

PKeyContext& PKeyContext::operator=(PKeyContext&& ctx) {
    context = ctx.context;
    ctx.context = nullptr;

    return *this;
}

bool PKeyContext::set_params(const OSSL_PARAM* params) const {
    if (EVP_PKEY_CTX_set_params(context, params) <= 0) {
        Error::openssl_err_out("EVP_PKEY_CTX_set_params");
        return false;
    }

    return true;
}

bool PKeyContext::derive_init() const {
    if (EVP_PKEY_derive_init(context) <= 0) {
        Error::openssl_err_out("EVP_PKEY_derive_init");
        return false;
    }

    return true;
}

bool PKeyContext::derive_len(size_t* secret_len) const {
    if (EVP_PKEY_derive(context, nullptr, secret_len) <= 0) {
        Error::openssl_err_out("EVP_PKEY_CTX_set_params");
        return false;
    }

    return true;
}

bool PKeyContext::derive(unsigned char* secret, size_t* secret_len) const {
    if (EVP_PKEY_derive(context, secret, secret_len) <= 0) {
        Error::openssl_err_out("EVP_PKEY_CTX_set_params");
        return false;
    }

    return true;
}

EVP_PKEY_CTX* const PKeyContext::get_context() const {
    return context;
}