cmake_minimum_required(VERSION 3.5)
project(cubao_bundles)

include(cmake/Utilities.cmake)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
message("Build type: " ${CMAKE_BUILD_TYPE})

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O3 -Wall -pthread -Wno-reorder -march=native")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3 -march=native")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

include_directories(
    ${PROJECT_SOURCE_DIR}/clipp/include
    ${PROJECT_SOURCE_DIR}/fmt/include
    ${PROJECT_SOURCE_DIR}/json/single_include
    ${PROJECT_SOURCE_DIR}/mongoose/
)
print_include_directories()

set(LIBRARY_NAME ${PROJECT_NAME})
add_library(${LIBRARY_NAME} SHARED
    ${PROJECT_SOURCE_DIR}/mongoose/mongoose.c
)
# Install library
install(TARGETS ${LIBRARY_NAME}
    EXPORT ${PROJECT_EXPORT}
    RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin
    LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT shlib
    ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" COMPONENT stlib
    COMPONENT dev)

# Install header files, if set HEADER_ROOT, preserve directory structure, otherwise flatten it
# #
#     fmt/include/fmt/*.h
#     json/single_include/nlohmann/json.hpp

file(GLOB_RECURSE HEADERS
    clipp/include/clipp.h
    mongoose/mongoose.h
)

install(FILES ${file} DESTINATION "${INSTALL_INCLUDE_DIR}/${LIBRARY_FOLDER}")

# include(cmake/InstallConfig.cmake)
