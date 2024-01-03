target_sources(crypt_lib
    PRIVATE
        crypt.cpp
        error.cpp
)

target_link_libraries(crypt_lib
    PUBLIC
        OpenSSL::Crypto
)