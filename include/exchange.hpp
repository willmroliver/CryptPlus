#ifndef INCLUDE_EXCHANGE_H
#define INCLUDE_EXCHANGE_H

#include <string>
#include "pkey_context.hpp"
#include "pkey.hpp"

namespace crpt {

/**
 * @brief Provides OpenSSL Diffie-Hellman key exchange
 */
class Exchange {
    private:
        PKeyContext context;
        PKey key;

    public:
        /**
         * @brief Construct a Diffie-Hellman Exchange instance and generate a new private key.
         * 
         * @tparam Args The args to be passed to PKeyContext::new_pkey. See PKeyContext
         * @param args 
         */
        template <typename... Args>
        Exchange(Args... args):
            context { "DH" },
            key { context.new_pkey(...args) }
        {}
};

}
#endif