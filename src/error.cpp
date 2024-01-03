#include <ostream>
#include "error.hpp"

using namespace crpt;

std::ostream* Error::err_ostream = &std::cerr;