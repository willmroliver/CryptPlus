#include <string>
#include <utility>
#include <openssl/obj_mac.h>
#include "crypt/pkey-context.hpp"
#include "crypt/pkey.hpp"
#include "crypt/exchange.hpp"
#include "crypt/public-key-der.hpp"
#include "crypt/error.hpp"

using namespace crpt;

Exchange::Exchange():
    context { "DH" },
    key { context.get_context(), "ffdhe2048" }
{}

Exchange::Exchange(std::string group): 
    context { "DH" },
    key { context.get_context(), group }
{}

Exchange::Exchange(Exchange& exch):
    context { exch.context },
    key { exch.key }
{}

Exchange::Exchange(Exchange&& exch):
    context { exch.context },
    key { exch.key },
    shared_secret { exch.shared_secret },
    secret_len { exch.secret_len }
{
    exch.shared_secret = nullptr;
    exch.secret_len = 0;
}

Exchange::~Exchange() {
    OPENSSL_clear_free(shared_secret, secret_len);
}

Exchange& Exchange::operator=(Exchange& exch) {
    context = exch.context;
    key = exch.key;

    return *this;
}

Exchange& Exchange::operator=(Exchange&& exch) {
    context = exch.context;
    key = exch.key;
    shared_secret = exch.shared_secret;
    secret_len = exch.secret_len;

    exch.shared_secret = nullptr;
    exch.secret_len = 0;

    return *this;
}

bool Exchange::derive_secret(PublicKeyDER& public_key) {
    auto shared_key = public_key.get_key();

    if (!key.get_key() || !shared_key.get_key()) {
        Error::err_out("Exchange: derive_secret: key is null");
        return false;
    }

    PKeyContext derive_ctx { key.get_key() };

    if (!derive_ctx.derive_init()) {
        Error::err_out("Exchange: derive_secret: call to PKeyContext::derive_init() on context failed");
        return false;
    }

    auto pad = 1u;
    OSSL_PARAM params[] = {
        OSSL_PARAM_construct_uint("pad", &pad),
        OSSL_PARAM_construct_end()
    };

    if (!derive_ctx.set_params(params)) {
        Error::err_out("Exchange: derive_secret: failed to set context params");
        return false;
    }

    if (!shared_key.derive_set_peer(derive_ctx.get_context())) {
        Error::err_out("Exchange: derive_secret: call to PKey::derive_set_peer on extern_key failed");
        return false;
    }

    secret_len = 0;

    if (!derive_ctx.derive_len(&secret_len)) {
        Error::err_out("Exchange: derive_secret: call to PKeyContext::pkey_derive_len on context failed");
        return false;
    }

    shared_secret = (unsigned char*)OPENSSL_zalloc(secret_len);

    if (!derive_ctx.derive(shared_secret, &secret_len)) {
        Error::err_out("Exchange: derive_secret: call to PKeyContext::pkey_derive on context failed");
        return false;
    }

    return true;
}

PublicKeyDER Exchange::get_public_key() {
    return { key };
}

std::vector<char> Exchange::get_secret() {
    return { shared_secret, shared_secret + secret_len };
}
