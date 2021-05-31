cmake_minimum_required(VERSION 2.8.12)
project(PackageTest CXX)

if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup(TARGETS)
else ()
    message(STATUS "Need some text")
endif ()

add_executable(${PROJECT_NAME} example.cpp)

if (TARGET CONAN_PKG::libts)
    target_link_libraries(${PROJECT_NAME} PRIVATE CONAN_PKG::libts)
else ()
    target_link_libraries(${PROJECT_NAME} PRIVATE hello)
    target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/src)
endif ()
 

# CTest is a testing tool that can be used to test your project.
# enable_testing()
# add_test(NAME ${PROJECT_NAME}
#          WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bin
#          COMMAND ${PROJECT_NAME})
