cmake_minimum_required(VERSION 3.28)

project(CryptPlus VERSION 1.0 DESCRIPTION "A simple OpenSSL wrapper with support for basic encryption/decryption and Diffie-Hellman key exchange")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED true)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++ -pedantic -Wall -Werror")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(Boost_LIBRARIES ${Boost_INCLUDE_DIRS}/stage/lib)
set(Boost_USE_STATIC_LIBS ON)

find_package(Boost 1.82.0 COMPONENTS unit_test_framework REQUIRED)
find_package(OpenSSL REQUIRED)

add_library(CryptPlus "")
add_executable(crypt_test)

add_subdirectory(src)
add_subdirectory(test)

target_include_directories(CryptPlus 
    PRIVATE 
        src
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

target_include_directories(crypt_test 
    PRIVATE 
        src
        include
    PUBLIC 
        ${Boost_INCLUDE_DIRS}
)

include(InstallRequiredSystemLibraries)

set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${CryptPlus_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${CryptPlus_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")

include(CPack)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

set_target_properties(
    CryptPlus
        PROPERTIES
            POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
)

install(
    TARGETS CryptPlus
    EXPORT CryptPlusTargets
    DESTINATION bin
    INCLUDES DESTINATION include
)

install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/crypt
    DESTINATION include
    FILES_MATCHING PATTERN "*.hpp"
)

install(
    EXPORT CryptPlusTargets
    FILE CryptPlusTargets.cmake
    DESTINATION lib/cmake/CryptPlus
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/CryptPlusConfig.cmake"
    INSTALL_DESTINATION "cryptplus/lib/cmake/example"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/CryptPlusConfigVersion.cmake"
  VERSION "${CryptPlus_VERSION_MAJOR}.${CryptPlus_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/CryptPlusConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/CryptPlusConfigVersion.cmake
    DESTINATION
        lib/cmake/CryptPlus
)

export(
    EXPORT CryptPlusTargets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/CryptPlusTargets.cmake"
)
