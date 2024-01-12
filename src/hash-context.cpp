#include <crypt/hash-context.hpp>

using namespace crpt;

HashContext::HashContext(): 
    context { EVP_MD_CTX_new() }
{}

HashContext::HashContext(HashContext& c) {
    EVP_MD_CTX_copy(context, c.context);
}

HashContext::HashContext(HashContext&& c) {
    c.context = context;
    context = nullptr;
}

HashContext::~HashContext() {
    EVP_MD_CTX_free(context);
}

HashContext& HashContext::operator=(HashContext& c) {
    EVP_MD_CTX_copy(context, c.context);
    return *this;
}

HashContext& HashContext::operator=(HashContext&& c) {
    c.context = context;
    context = nullptr;
    return *this;
}

EVP_MD_CTX* const HashContext::get_context() const {
    return context;
}