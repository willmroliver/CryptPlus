target_sources(crypt_test
    PRIVATE
        main.cpp
        crypt.cpp
        exchange.cpp
)

target_link_libraries(crypt_test
    PRIVATE
        crypt_lib
    PUBLIC
        OpenSSL::Crypto
        ${Boost_LIBRARIES}
)