target_sources(CryptPlus
    PRIVATE
        cipher-context.cpp
        cipher.cpp
        crypt.cpp
        error.cpp
        exchange.cpp
        pkey-context.cpp
        pkey.cpp
        public-key-der.cpp
)

target_link_libraries(CryptPlus
    PUBLIC
        OpenSSL::Crypto
)