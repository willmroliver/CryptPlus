#include <boost/test/unit_test.hpp>
#include <string>
#include "crypt/crypt.hpp"

using namespace crpt;

std::vector<char> key_256 { 
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
    0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
};

std::vector<char> iv_128 { 
    0x01, 0x02, 0x03, 0x04, 0x01, 0x02, 0x03, 0x04,
    0x01, 0x02, 0x03, 0x04, 0x01, 0x02, 0x03, 0x04,
};

BOOST_AUTO_TEST_CASE( crypt_encrypt_test ) {
    Crypt aes { "AES-256-CBC" };

    std::string bytes { "Hello, World!" };
    std::vector<char> plain_text { bytes.begin(), bytes.end() };

    auto [cipher_text, success] = aes.encrypt(plain_text, key_256, iv_128);

    BOOST_ASSERT( success );
    BOOST_ASSERT( cipher_text != plain_text );
}

BOOST_AUTO_TEST_CASE( crypt_decrypt_test ) {
    Crypt aes { "AES-256-CBC" };

    std::string bytes { "Hello, World!" };
    std::vector<char> plain_text { bytes.begin(), bytes.end() };

    auto [cipher_text, success] = aes.encrypt(plain_text, key_256, iv_128);
    
    BOOST_ASSERT( success );
    BOOST_ASSERT( cipher_text != plain_text );

    auto [decrypted, decrypt_success] = aes.decrypt(cipher_text, key_256, iv_128);

    BOOST_ASSERT( decrypt_success );
    BOOST_ASSERT( plain_text == decrypted );
}

BOOST_AUTO_TEST_CASE( crypt_decrypt_with_different_instance_test ) {
    Crypt aes_enc { "AES-256-CBC" };
    Crypt aes_dec { "AES-256-CBC" };

    std::string bytes { "Hello, World!" };
    std::vector<char> plain_text { bytes.begin(), bytes.end() };

    auto [cipher_text, success] = aes_enc.encrypt(plain_text, key_256, iv_128);
    
    BOOST_ASSERT( success );
    BOOST_ASSERT( cipher_text != plain_text );

    auto [decrypted, decrypt_success] = aes_dec.decrypt(cipher_text, key_256, iv_128);

    BOOST_ASSERT( decrypt_success );
    BOOST_ASSERT( plain_text == decrypted );
}

BOOST_AUTO_TEST_CASE( crypt_hash_test ) {
    std::string bytes { "Hello, World!" };
    std::vector<char> data { bytes.begin(), bytes.end() };

    auto [hash, success] = Crypt::hash(data);

    BOOST_ASSERT( success );
    BOOST_ASSERT(hash.size() == 32);

    auto [hash_512, success_512] = Crypt::hash("SHA3-512", data);

    BOOST_ASSERT( success_512 );
    BOOST_ASSERT(hash_512.size() == 64);
}