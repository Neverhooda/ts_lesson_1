FROM gcc:8
WORKDIR /home/conan/project
ADD gcc_profile /home/conan/tools/

ENV CONAN_USER_HOME "/home/conan/project"

RUN apt-get update && apt-get install -y python3-pip cmake
RUN pip3 install conan

CMD ["pip3 install conan --upgrade", "conan create . -pr gcc_profile --build missing"]