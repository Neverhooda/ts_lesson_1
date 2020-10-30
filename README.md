# ts_lesson_1
How to work with conan in docker
---

# Dependents
- conan
- cmake
- docker

# Create new package & build it
```shell
$ conan new libts/1.0 -ts -gi -cilg
$ conan create . 
```

# Build in docker
```shell
$ docker run -it -v$(pwd):/home/conan/project --rm gcc:8.0 /bin/bash
```