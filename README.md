[![Build Status](https://travis-ci.org/Neverhooda/ts_lesson_1.svg?branch=main)](https://travis-ci.org/Neverhooda/ts_lesson_1)
# ts_lesson_1
How to work with conan in docker
---

## Dependents
- conan
- cmake
- docker

## Create new package & build it
```shell
$ conan new libts/1.0 -ts -gi -cilg
$ conan create . 
```

## Build docker
```shell 
docker build --tag tslib_tool:1.0 .
```

## Build in docker
```shell
$ docker run -it -v$(pwd):/home/conan/project --rm tslib_tool:1.0 /bin/bash build.sh
```

Презентация:
https://docs.google.com/presentation/d/1IKXdM6Nkcb8dmDZeu3RIbO0D3fJho66-RMvJJuQ5uT4/edit?usp=sharing

Заметки:
https://docs.google.com/document/d/1RLT3eYxZBoZA0TfsVm2tixtBNrMkMAKUCDoTP4oYaUI/edit?usp=sharing

# ts_lesson_2
How to work with Visual Studio in docker
## Install env
- https://docs.microsoft.com/en-us/windows/wsl/install-win10
- https://docs.docker.com/docker-for-windows/install/
- https://docs.microsoft.com/en-us/cpp/linux/download-install-and-setup-the-linux-development-workload?view=msvc-160&viewFallbackFrom=vs-2019#visual-studio-setup

## Preparing image 

```shell
$ docker pull ubuntu
$ docker build -t tslib_tool_win -f Dockerfile_win .
$ docker run -p 5000:22 -i -t tslib_tool_win /bin/bash
```
Add user
```shell
# service ssh start
# adduser user
# usermod -a -G sudo user
```

## VS 
See doc:
- https://docs.google.com/document/d/1akLBaoePIyXEf3WMLZP2NnVmeFoGmbkAS6cPPnWOOhg/edit?usp=sharing

# ts_lesson_3
Make and pinned versions

## Dependents
- make (GNU make 4.2+)
- docker

## Pinned versions
Python tools are pinned in `requirements.txt`, the Makefile reads the conan version from it
and passes it to `docker build`:

| Tool | Version |
|---|---|
| conan | 1.40.4 |
| markupsafe | 2.0.1 |
| conan-package-tools | 0.36.0 |
| cmake | 3.21.3 |
| docker image for build | conanio/gcc8:1.40.4 |
| docker image for VS | ubuntu:20.04 |

```shell
$ make versions
```

## Targets
```shell
$ make help
$ make deps      # pip3 install -r requirements.txt
$ make package   # conan create on the host
$ make build     # conan create inside docker
$ make shell     # shell inside docker
$ make image-win # image for Visual Studio
$ make run-win
$ make clean
```

Variables can be overridden from the command line:
```shell
$ make package PROFILE=gcc_profile
$ make run-win SSH_PORT=5022
```

# ts_lesson_4
Dependencies from ConanCenter

## Dependencies
| Package | Version | Recipe revision | Used for |
|---|---|---|---|
| fmt | 8.0.1 | 826bcee69ee04232ff9864766afa728c | `requires`, formatting in `src/hello.cpp` |
| gtest | 1.11.0 | 12a4d978bed45770a20e2f7737664dc2 | `build_requires`, unit tests in `tests/` |

A version alone is not enough: ConanCenter keeps updating recipes of the same version,
and a new recipe revision may need a newer conan client. Pinning the recipe revision
(`fmt/8.0.1#826bcee...`) keeps the build reproducible. Revisions must be enabled,
the Makefile and both Dockerfiles set it:
```shell
$ export CONAN_REVISIONS_ENABLED=1
```

gtest is added with `force_host_context=True`, so it is built for the target platform
but does not become a dependency of `libts` consumers.

## Build and test
`conan create` builds the library, runs the unit tests with `ctest` and then runs `test_package`:
```shell
$ make build
$ make package PROFILE=gcc_profile
```

Debug build:
```shell
$ conan create . -pr gcc_profile -s build_type=Debug --build missing
```

Show the dependency graph:
```shell
$ conan info .
```
