cmake_minimum_required(VERSION 3.5)
project(learn_imgui)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SDL_PATH third_party/sdl2/win32)
set(EXEC_FILE main)

add_executable(${EXEC_FILE} ./src/main.cpp)

include_directories (./third_party/imgui)
include_directories (./third_party/imgui/examples)

if (WIN32) 
    find_file(SDL2_INCLUDE_FILE NAME SDL.h PATH_SUFFIXES include/SDL2 HINTS ${SDL_PATH})
    find_library(SDL2_LIBRARY NAME SDL2 HINTS ${SDL_PATH})
else()
    find_file(SDL2_INCLUDE_FILE NAME SDL.h PATH_SUFFIXES SDL2 HINTS SDL2)
    find_library(SDL2_LIBRARY NAME SDL2 PATH_SUFFIXES SDL2)
endif()
get_filename_component(SDL2_INCLUDE_DIR    ${SDL2_INCLUDE_FILE} DIRECTORY)
get_filename_component(SDL2_INCLUDE_DIR_EX ${SDL2_INCLUDE_DIR}  DIRECTORY)
include_directories (${SDL2_INCLUDE_DIR})
include_directories (${SDL2_INCLUDE_DIR_EX})

# provide libimgui as IMGUI_LIBRARY
include(${CMAKE_CURRENT_LIST_DIR}/third_party/imgui.cmake)


# Debug information
message("-------- MESSAGE ---------")
message(
    "SDL include path: " ${SDL2_INCLUDE_DIR} "\n" 
    "                  " ${SDL2_INCLUDE_DIR_EX} "\n" 
    "SDL library path: " ${SDL2_LIBRARY} "\n"
    )
message("----- END MESSAGE ---------\n")


include (FindOpenGL)
target_include_directories (${EXEC_FILE} INTERFACE ${SDL2_INCLUDE_DIR})
target_link_libraries (${EXEC_FILE} ${SDL2_LIBRARY})
target_link_libraries (${EXEC_FILE} ${IMGUI_LIBRARY})
target_link_libraries (${EXEC_FILE} ${CMAKE_DL_LIBS})
target_link_libraries (${EXEC_FILE} ${OPENGL_LIBRARIES})

