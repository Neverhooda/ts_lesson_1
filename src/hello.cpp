#include <iostream>
#include <fmt/format.h>
#include "hello.h"

std::string greeting(){
    #ifdef NDEBUG
    return fmt::format("Hello World {}!", "Release");
    #else
    return fmt::format("Hello World {}!", "Debug");
    #endif
}

void hello(){
    std::cout << greeting() << std::endl;
}
