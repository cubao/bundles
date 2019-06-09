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
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/mongoose
)

add_library(${PROJECT_NAME} SHARED
    mongoose/mongoose.c
)
install(FILES
    clipp/include/clipp.h
    DESTINATION include/${PROJECT_NAME}
)
install(FILES
    json/single_include/nlohmann/json.hpp
    DESTINATION include/${PROJECT_NAME}/nlohmann
)
install(FILES
    fmt/include/fmt/chrono.h
    fmt/include/fmt/core.h
    fmt/include/fmt/ostream.h
    fmt/include/fmt/prepare.h
    fmt/include/fmt/ranges.h
    fmt/include/fmt/color.h
    fmt/include/fmt/format.h
    fmt/include/fmt/locale.h
    fmt/include/fmt/posix.h
    fmt/include/fmt/printf.h
    fmt/include/fmt/time.h
    DESTINATION include/${PROJECT_NAME}/fmt
)

function(install_directory src_dir dst_dir)
    file(GLOB SRC_FILES ${src_dir}/*.*)
    install(FILES ${SRC_FILES} DESTINATION ${dst_dir})
endfunction()

set(taskflow_include_dirs
    .
    utility
    error
    core
    predef
    predef/compiler
    predef/os
    predef/architecture
)
foreach(dir ${taskflow_include_dirs})
    install_directory(
        cpp-taskflow/taskflow/${dir}
        include/${PROJECT_NAME}/taskflow/${dir}
    )
endforeach()

install(TARGETS
    ${PROJECT_NAME}
    DESTINATION lib
)
