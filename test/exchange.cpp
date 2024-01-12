#include <boost/test/unit_test.hpp>
#include "crypt/exchange.hpp"

using namespace crpt;

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