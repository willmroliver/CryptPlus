cmake_minimum_required(VERSION 3.28)

project(CryptPlus VERSION 1.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED true)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++ -pedantic -Wall -Werror")

set(Boost_LIBRARIES ${Boost_INCLUDE_DIRS}/stage/lib)
set(Boost_USE_STATIC_LIBS ON)

find_package(Boost 1.82.0 COMPONENTS unit_test_framework REQUIRED)
find_package(OpenSSL REQUIRED)

add_library(crypt_lib "")
add_executable(crypt_test)

add_subdirectory(src)
add_subdirectory(test)

target_include_directories(crypt_lib 
    PRIVATE 
        src
        include
)

target_include_directories(crypt_test 
    PRIVATE 
        src
        include
    PUBLIC 
        ${Boost_INCLUDE_DIRS}
)