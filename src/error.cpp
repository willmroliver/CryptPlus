#include <ostream>
#include "crypt/error.hpp"

using namespace crpt;

std::ostream* Error::err_ostream = &std::cerr;