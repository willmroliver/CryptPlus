#ifndef INCLUDE_EXCHANGE_H
#define INCLUDE_EXCHANGE_H

#include <string>
#include <utility>
#include <openssl/obj_mac.h>
#include "pkey_context.hpp"
#include "pkey.hpp"
#include "public_key_der.hpp"
#include "error.hpp"

namespace crpt {

/**
 * @brief Provides OpenSSL Diffie-Hellman key exchange facilities
 */
class Exchange {
    private:
        PKeyContext context;
        PKey key;
        unsigned char* shared_secret = nullptr;
        size_t secret_len = 0;

    public:
        Exchange():
            context { "DH" },
            key { context.get_context(), "ffdhe8192" }
        {}
        Exchange(std::string group): 
            context { "DH" },
            key { context.get_context(), group }
        {}
        Exchange(Exchange& exc) = delete;
        Exchange(Exchange&& exc) = delete;
        ~Exchange() {
            OPENSSL_clear_free(shared_secret, secret_len);
        };
        Exchange& operator=(Exchange& exc) = delete;
        Exchange& operator=(Exchange&& exc) = delete;

        inline bool derive_secret(PublicKeyDER& public_key) {
            auto shared_key = public_key.get_key();

            if (key.is_null() || shared_key.is_null()) {
                Error::err_out("Exchange: derive_secret: at least one key is null");
                return false;
            }

            PKeyContext derive_ctx { key.get_key() };

            if (!derive_ctx.derive_init()) {
                Error::err_out("Exchange: derive_secret: call to PKetContext::derive_init() on context failed");
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

        inline PublicKeyDER get_public_key() {
            return { key };
        }

        inline std::string get_secret() {
            return { reinterpret_cast<char*>(shared_secret) };
        }

        inline bool context_is_null() const {
            return context.is_null();
        }

        inline bool key_is_null() const {
            return key.is_null();
        }
};

}
#endif