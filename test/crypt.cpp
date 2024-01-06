#include <boost/test/unit_test.hpp>
#include <string>
#include "crypt.hpp"

using namespace crpt;

char key_256[] = { 
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
};

char iv_128[] = { 
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08
};

BOOST_AUTO_TEST_CASE( crypt_simple_encrypt_test ) {
    Crypt aes { "AES-256-CBC" };

    std::string plain_text { "Hello, World!" };
    auto [cipher_text, success] = aes.encrypt(plain_text, key_256, iv_128);

    BOOST_ASSERT( success );
    BOOST_ASSERT( cipher_text != plain_text );
}

BOOST_AUTO_TEST_CASE( crypt_simple_decrypt_test ) {
    Crypt aes { "AES-256-CBC" };

    std::string plain_text = { "Hello, World!" };
    auto [cipher_text, success] = aes.encrypt(plain_text, key_256, iv_128);
    
    BOOST_ASSERT( success );
    BOOST_ASSERT( cipher_text != plain_text );

    auto [decrypted, decrypt_success] = aes.decrypt(cipher_text, key_256, iv_128);

    BOOST_ASSERT( decrypt_success );
    BOOST_ASSERT( plain_text == decrypted );
}