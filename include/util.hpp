#ifndef INCLUDE_UTIL_H
#define INCLUDE_UTIL_H

#include <openssl/err.h>
#include <iostream>

namespace crpt {

template <typename T>
inline void err_out(T&& to) {
    auto err_code = ERR_get_error();
    auto err_buf = ERR_error_string(err_code, nullptr);
    to << "crypt: openssl: " << err_buf << std::endl;
}

inline void err_out() {
    err_out(std::cerr);
}

}

#endif