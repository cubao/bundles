# bundles

DON'T BUNDLE LOGGING LIBRARIES. JUST USE GLOG, GOOGLE TEST, GOOGLE BENCHMARK.

Some common C++ libraries:

-   RxCpp: Reactive Extensions for C++
-   clipp: Argparse for C++
-   cpp-taskflow: Modern C++ Parallel Task Programming Library
-   fmt: A modern formatting library
-   json: JSON for Modern C++
-   mongoose: Mongoose Embedded Web Server Library

## Install the bundle

```bash
make install

# default to install headers & libs to ${HOME}/.cmake_install
# can be overrided via
CMAKE_PREFIX_INSTALL=/tmp/other/dir make install
```
