#include <boost/test/unit_test.hpp>
#include "exchange.hpp"

using namespace crpt;

BOOST_AUTO_TEST_CASE( exchange_constructor_test ) {
    Exchange dh;

    BOOST_ASSERT(!dh.context_is_null());
    BOOST_ASSERT(!dh.key_is_null());

    Exchange dh_invalid_group { "not-a-safe-prime-group" };
    BOOST_ASSERT(dh_invalid_group.key_is_null());
}

BOOST_AUTO_TEST_CASE( openssl_dh_test ) {
    OSSL_PARAM params[] = {
        OSSL_PARAM_construct_utf8_string("group", const_cast<char*>("ffdhe8192"), 0),
        OSSL_PARAM_construct_end()
    };

    EVP_PKEY *pkey = NULL;
    EVP_PKEY_CTX *pctx = EVP_PKEY_CTX_new_from_name(NULL, "DH", NULL);

    EVP_PKEY_keygen_init(pctx);
    EVP_PKEY_CTX_set_params(pctx, params);
    EVP_PKEY_generate(pctx, &pkey);

    unsigned char *peer_pub_der = NULL;
    int peer_pub_der_len;

    peer_pub_der_len = i2d_PUBKEY(pkey, &peer_pub_der);

    const unsigned char *pd = peer_pub_der;

    EVP_PKEY *peer_pub_key = d2i_PUBKEY(NULL, &pd, peer_pub_der_len);

    unsigned int pad = 1;
    OSSL_PARAM params_other[2];
    unsigned char *secret = NULL;
    size_t secret_len = 0;
    EVP_PKEY_CTX *dctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);

    EVP_PKEY_derive_init(dctx);

    /* Optionally set the padding */
    params_other[0] = OSSL_PARAM_construct_uint("pad", &pad);
    params_other[1] = OSSL_PARAM_construct_end();
    EVP_PKEY_CTX_set_params(dctx, params_other);

    EVP_PKEY_derive_set_peer(dctx, peer_pub_key);

    /* Get the size by passing NULL as the buffer */
    EVP_PKEY_derive(dctx, NULL, &secret_len);
    secret = (unsigned char*)OPENSSL_zalloc(secret_len);

    EVP_PKEY_derive(dctx, secret, &secret_len);

    // Release resources

    EVP_PKEY_free(pkey);
    EVP_PKEY_CTX_free(pctx);

    OPENSSL_free(peer_pub_der);
    EVP_PKEY_free(peer_pub_key);

    OPENSSL_clear_free(secret, secret_len);
    EVP_PKEY_CTX_free(dctx);
}

BOOST_AUTO_TEST_CASE( exchange_secret_test ) {
    Exchange host;
    Exchange peer;

    auto peer_pub_key = peer.get_public_key();
    auto host_pub_key = host.get_public_key();

    BOOST_ASSERT(host.derive_secret(peer_pub_key));
    BOOST_ASSERT(peer.derive_secret(host_pub_key));

    auto host_shared_secret = host.get_secret();
    auto peer_shared_secret = peer.get_secret();

    BOOST_ASSERT(host_shared_secret == peer_shared_secret);
}