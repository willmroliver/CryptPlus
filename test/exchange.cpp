#include <boost/test/unit_test.hpp>
#include "crypt/exchange.hpp"

using namespace crpt;

BOOST_AUTO_TEST_CASE( exchange_secret_test ) {
    Exchange host;
    Exchange peer;

    auto host_pk_data = host.get_public_key().to_vector();
    auto peer_pk_data = peer.get_public_key().to_vector();

    std::string host_pk_str { host_pk_data.begin(), host_pk_data.end() };
    std::string peer_pk_str { peer_pk_data.begin(), peer_pk_data.end() };

    PublicKeyDER host_pub_key;
    PublicKeyDER peer_pub_key;

    host_pub_key.from_vector({ host_pk_str.begin(), host_pk_str.end() });
    peer_pub_key.from_vector({ peer_pk_str.begin(), peer_pk_str.end() });

    BOOST_ASSERT(host.derive_secret(peer_pub_key));
    BOOST_ASSERT(peer.derive_secret(host_pub_key));

    auto host_shared_secret = host.get_secret();
    auto peer_shared_secret = peer.get_secret();

    BOOST_ASSERT(host_shared_secret == peer_shared_secret);
}