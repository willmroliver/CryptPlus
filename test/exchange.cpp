#include <boost/test/unit_test.hpp>
#include "exchange.hpp"

using namespace crpt;

BOOST_AUTO_TEST_CASE( exchange_constructor_test ) {
    Exchange dh { "ffdhe8192" };

    BOOST_ASSERT(!dh.context_is_null());
    BOOST_ASSERT(!dh.key_is_null());

    Exchange dh_invalid_group { "not-a-safe-prime-group" };
    BOOST_ASSERT(dh_invalid_group.key_is_null());
}