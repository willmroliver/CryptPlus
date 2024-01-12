#include <openssl/evp.h>
#include <openssl/err.h>

#include "crypt/error.hpp"
#include "crypt/hash.hpp"

using namespace crpt;

Hash::Hash(std::string name):
    hash { EVP_MD_fetch(nullptr, name.c_str(), nullptr) },
    name { name }
{
    if (hash == nullptr) {
        Error::openssl_err_out("EVP_MD_fetch");
    }
}

Hash::Hash(std::string name, std::string properties):
    hash { EVP_MD_fetch(nullptr, name.c_str(), properties.c_str()) },
    properties { properties }
{
    if (hash == nullptr) {
        Error::openssl_err_out("EVP_MD_fetch");
    }
}

Hash::Hash(Hash& c):
    context { c.context },
    name { c.name },
    properties { c.properties }
{
    hash = EVP_MD_fetch(nullptr, name.c_str(), properties.size() ? properties.c_str() : nullptr);
}
        
Hash::Hash(Hash&& c):
    context { c.context },
    hash { c.hash },
    name { c.name },
    properties { c.properties }
{
    c.hash = nullptr;
    c.name = "";
    c.properties = "";
}

Hash& Hash::operator=(Hash& c) {
    context = c.context;
    name = c.name;
    properties = c.properties;

    hash = EVP_MD_fetch(nullptr, name.c_str(), properties.size() ? properties.c_str() : nullptr);
    
    return *this;
}
        
Hash& Hash::operator=(Hash&& c) {
    context = c.context;
    hash = c.hash;
    name = c.name;
    properties = c.properties;

    c.hash = nullptr;
    c.name = "";
    c.properties = "";
    
    return *this;
}
        
Hash::~Hash() {
    EVP_MD_free(hash);
}

bool Hash::digest_init() const {
    return EVP_DigestInit_ex2(context.get_context(), hash, nullptr);
}     

bool Hash::digest_init(OSSL_PARAM* params) const {
    return EVP_DigestInit_ex2(context.get_context(), hash, params);
}

bool Hash::digest_update(const void* data, size_t n) {
    return EVP_DigestUpdate(context.get_context(), data, n);
}

bool Hash::digest_final(unsigned char* out, unsigned* len) {
    return EVP_DigestFinal_ex(context.get_context(), out, len);
}

int Hash::block_size() {
    return EVP_MD_block_size(hash);
}

EVP_MD* const Hash::get_hash() const {
    return hash;
}  