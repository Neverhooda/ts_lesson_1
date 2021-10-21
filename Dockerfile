ARG CONAN_VERSION=1.40.4
FROM conanio/gcc8:${CONAN_VERSION}
WORKDIR /home/conan/project
ADD gcc_profile /home/conan/tools/

ENV CONAN_USER_HOME "/home/conan/project"

CMD ["/bin/bash", "build.sh"]
