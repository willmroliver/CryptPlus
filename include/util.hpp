#ifndef INCLUDE_UTIL_H
#define INCLUDE_UTIL_H

#include <openssl/err.h>
#include <iostream>

namespace crpt {

inline void err_out(std::string prefix = "") {
    auto err_code = ERR_get_error();
    auto err_buf = ERR_error_string(err_code, nullptr);
    std::cerr << "crypt: openssl: " << (prefix != "" ? prefix + ": " : "") << err_buf << std::endl;
}

}

#endif