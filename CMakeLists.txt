if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup(TARGETS)
else ()
	if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
	  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
	  file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/v0.16.1/conan.cmake"
	                "${CMAKE_BINARY_DIR}/conan.cmake"
	                EXPECTED_HASH SHA256=396e16d0f5eabdc6a14afddbcfff62a54a7ee75c6da23f32f7a31bc85db23484
	                TLS_VERIFY ON)
	  endif()
	  include(${CMAKE_BINARY_DIR}/conan.cmake)
	
	  conan_cmake_run(CONANFILE ${CMAKE_SOURCE_DIR}/conanfile.py
	        BASIC_SETUP CMAKE_TARGETS
	        BUILD missing)
endif()

add_subdirectory(src)
add_subdirectory(test_package)