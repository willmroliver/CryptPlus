#include "crypt/util.hpp"
#include "crypt/error.hpp"
#include <string>

using namespace crpt;

std::string util::rand_bytes(unsigned n) {
    if (n < 1) {
        return "";
    }

    auto buf = new unsigned char[n];

    if (RAND_bytes(buf, n) < 1) {
        Error::openssl_err_out("RAND_bytes");
        return "";
    }

    std::string result { reinterpret_cast<char*>(buf), n };

    delete[] buf;
    return result;
}

std::string util::rand_priv_bytes(unsigned n) {
    if (n < 1) {
        return "";
    }

    auto buf = new unsigned char[n];

    if (RAND_priv_bytes(buf, n) < 1) {
        Error::openssl_err_out("RAND_priv_bytes");
        return "";
    }

    std::string result { reinterpret_cast<char*>(buf), n };
    
    delete[] buf;
    return result;
}
