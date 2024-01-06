target_sources(crypt_test
    PRIVATE
        main.cpp
        crypt.cpp
        exchange.cpp
)

target_link_libraries(crypt_test
    PRIVATE
        CryptPlus
    PUBLIC
        OpenSSL::Crypto
        ${Boost_LIBRARIES}
)