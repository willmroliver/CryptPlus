#define BOOST_TEST_MODULE crypt_test_suite

#include <boost/test/unit_test.hpp>
#include <fstream>
#include "error.hpp"

struct GlobalFixture {
    std::ofstream test_out {};

    void setup() {
        // As we'll be deliberately causing errors, let's unset std::cerr as the default err ostream.
        // crpt::Error::set_err_ostream(&test_out);
    }
};

BOOST_TEST_GLOBAL_FIXTURE( GlobalFixture );