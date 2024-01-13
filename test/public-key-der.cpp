#include <boost/test/unit_test.hpp>
#include "crypt/public-key-der.hpp"
#include "crypt/exchange.hpp"

using namespace crpt;

BOOST_AUTO_TEST_CASE( from_to_string_test ) {
    PublicKeyDER pk;
    
    std::string bytes { "Hello, World!" };
    std::vector<char> data { bytes.begin(), bytes.end() };

    pk.from_vector(data);
    BOOST_ASSERT(pk.to_vector() == data);
}