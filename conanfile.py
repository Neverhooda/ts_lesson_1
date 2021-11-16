from conans import ConanFile, CMake


class LibtsConan(ConanFile):
    name = "libts"
    version = "1.0"
    license = "<Put the package license here>"
    author = "<Put your name here> <And your email here>"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "<Description of Libts here>"
    topics = ("<Put some tag here>", "<here>", "<and here>")
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = {"shared": False}
    requires = "fmt/8.0.1#826bcee69ee04232ff9864766afa728c"
    generators = "cmake"
    exports_sources = ["src/*", "tests/*", "CMakeLists.txt", "test_package/*"]

    def build_requirements(self):
        self.build_requires("gtest/1.11.0#12a4d978bed45770a20e2f7737664dc2", force_host_context=True)

    def build(self):
        cmake = CMake(self)
        cmake.configure(source_folder='.')
        cmake.build()
        cmake.test()

        # Explicit way:
        # self.run('cmake %s/hello %s'
        #          % (self.source_folder, cmake.command_line))
        # self.run("cmake --build . %s" % cmake.build_config)

    def package(self):
        self.copy("*.h", dst="include", src="src")
        self.copy("*.lib", dst="lib", keep_path=False)
        self.copy("*.dll", dst="bin", keep_path=False)
        self.copy("*.dylib*", dst="lib", keep_path=False)
        self.copy("*.so", dst="lib", keep_path=False)
        self.copy("*.a", dst="lib", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["hello"]
