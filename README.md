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