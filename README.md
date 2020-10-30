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