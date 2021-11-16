add_executable(hello_test test_hello.cpp)
target_link_libraries(hello_test PRIVATE hello CONAN_PKG::gtest)
target_include_directories(hello_test PRIVATE ${CMAKE_SOURCE_DIR}/src)

add_test(NAME hello_test COMMAND hello_test)
