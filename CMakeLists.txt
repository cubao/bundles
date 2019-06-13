cmake_minimum_required(VERSION 3.5)
project(cubao_bundles)

include(cmake/Utilities.cmake)
include(cmake/SetEnv.cmake)

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
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/mongoose
)

add_library(${PROJECT_NAME} SHARED
    mongoose/mongoose.c
)
install(DIRECTORY RxCpp/Rx/v2/src/rxcpp/
    DESTINATION include/${PROJECT_NAME}/rxcpp
    FILES_MATCHING PATTERN "*.hpp"
)
install(FILES
    clipp/include/clipp.h
    DESTINATION include/${PROJECT_NAME}
)
install(DIRECTORY cpp-taskflow/taskflow/
    DESTINATION include/${PROJECT_NAME}/taskflow
)
install(DIRECTORY fmt/include/fmt/
    DESTINATION include/${PROJECT_NAME}/fmt
)
install(FILES
    json/single_include/nlohmann/json.hpp
    DESTINATION include/${PROJECT_NAME}/nlohmann
)
install(FILES
    mongoose/mongoose.h
    DESTINATION include/${PROJECT_NAME}
)

install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_EXPORT}
    RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin
    LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT shlib
    ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" COMPONENT stlib
    COMPONENT dev)
