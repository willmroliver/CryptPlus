#include <boost/test/unit_test.hpp>
#include "crypt/util.hpp"

BOOST_AUTO_TEST_CASE( test_rand_byte_functions ) {
    using namespace crpt::util;

    auto bytes = rand_bytes(256);
    BOOST_ASSERT(bytes.size() == 256);

    bytes = rand_priv_bytes(512);
    BOOST_ASSERT(bytes.size() == 512);

    bytes = rand_bytes(1);
    BOOST_ASSERT(bytes.size() == 1);

    bytes = rand_bytes(0);
    BOOST_ASSERT(bytes.size() == 0);
}