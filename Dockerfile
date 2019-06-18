FROM cubao/basic-google-suit as build
ADD . /tmp/code
RUN cd /tmp/code && \
    sudo make clean && \
    sudo mkdir dist && sudo chmod 777 -Rf dist && \
    make install

FROM cubao/basic-google-suit
ENV USER=conan
COPY --from=build /home/$USER/.cmake_install /home/$USER/.cmake_install 
RUN sudo chown $USER -Rf /home/$USER/.cmake_install
