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
