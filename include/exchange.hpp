#ifndef INCLUDE_EXCHANGE_H
#define INCLUDE_EXCHANGE_H

#include <string>
#include <utility>
#include "pkey_context.hpp"
#include "pkey.hpp"

namespace crpt {

/**
 * @brief Provides OpenSSL Diffie-Hellman key exchange facilities
 */
class Exchange {
    private:
        PKeyContext context;
        PKey key;
        PKey extern_key;

    public:
        /**
         * @brief Construct a Diffie-Hellman Exchange instance and generate a new private key.
         * 
         * @tparam Args The args to be passed to PKeyContext::new_pkey. See PKeyContext
         * @param args 
         */
        template <typename... Args>
        Exchange(Args&&... args):
            context { "DH" },
            key { context.new_pkey(args...) }
        {}
        Exchange(Exchange& exc) = delete;
        Exchange(Exchange&& exc) = delete;
        ~Exchange() = default;

        /**
         * @brief Takes a public key (it is assumed that the key is generated with the same safe-prime group/domain variables) and derives a PKey object from it.
         * 
         * @param epk The public key
         */
        inline void set_extern_key(std::string epk) {
            extern_key = { epk };
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