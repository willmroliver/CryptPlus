#ifndef INCLUDE_UTIL_H
#define INCLUDE_UTIL_H

#include <openssl/rand.h>
#include <string>

namespace crpt {

namespace util {

/**
 * @brief Generates and returns n cryptographically secure random bytes intended for public use, such as an IV. 
 * See man RAND_bytes
 * 
 * @param n The number of bytes to generate.
 * @return std::string The random bytes, or an empty string on failure.
 */
std::string rand_bytes(unsigned n);

/**
 * @brief Generates and returns n cryptographically secure random bytes intended for private use, such as a symmetric cipher key. 
 * See man RAND_priv_bytes
 * 
 * @param n The number of bytes to generate.
 * @return std::string The random bytes, or an empty string on failure.
 */
std::string rand_priv_bytes(unsigned n);

}

}

#endif