cmake_minimum_required(VERSION 3.5)
project(learn_imgui)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(EXEC_FILE_SDL sdlmain)
set(EXEC_FILE_GLFW glfwmain)

add_executable(${EXEC_FILE_SDL}  ./src/main_sdl.cpp)
add_executable(${EXEC_FILE_GLFW} ./src/main_glfw.cpp)

include_directories (./third_party/imgui)
include_directories (./third_party/imgui/examples)

# SDL2 Setup #{
if (WIN32) 
    set(SDL_PATH third_party/sdl2/win32)
    find_file(SDL2_INCLUDE_FILE NAME SDL.h PATH_SUFFIXES include/SDL2 HINTS ${SDL_PATH})
    find_library(SDL2_LIBRARY NAME SDL2 HINTS ${SDL_PATH})
else()
    find_file(SDL2_INCLUDE_FILE NAME SDL.h PATH_SUFFIXES SDL2 HINTS SDL2)
    find_library(SDL2_LIBRARY NAME SDL2 PATH_SUFFIXES SDL2)
endif()
message("-- Found sdl2: " ${SDL2_LIBRARY})
get_filename_component(SDL2_INCLUDE_DIR    ${SDL2_INCLUDE_FILE} DIRECTORY)
get_filename_component(SDL2_INCLUDE_DIR_EX ${SDL2_INCLUDE_DIR}  DIRECTORY)
include_directories (${SDL2_INCLUDE_DIR})
include_directories (${SDL2_INCLUDE_DIR_EX})
#}

# GLFW Setup #{
if (WIN32)
    set(GLFW_PATH third_party/glfw)
    find_file(GLFW_INCLUDE_FILE NAME glfw3.h PATH_SUFFIXES include/GLFW HINTS ${GLFW_PATH})
    find_library(glfw NAME glfw3 HINTS ${GLFW_PATH})
    get_filename_component(GLFW_INCLUDE_DIR    ${GLFW_INCLUDE_FILE} DIRECTORY)
    get_filename_component(GLFW_INCLUDE_DIR_EX ${GLFW_INCLUDE_DIR}  DIRECTORY)
    include_directories(${GLFW_INCLUDE_DIR_EX})
    message("-- Found glfw: " ${glfw})
    set(glfw_target ${glfw})
else()
    find_package (glfw3 REQUIRED)
    if (glfw3_FOUND)
        message("-- Found glfw")
    else()
        message(FATAL_ERROR "cannot found glfw")
    endif()
    set(glfw_target glfw)
endif()
#}

# provide libimgui as IMGUI_LIBRARY
include(${CMAKE_CURRENT_LIST_DIR}/third_party/imgui.cmake)


target_include_directories (${EXEC_FILE_SDL} INTERFACE ${SDL2_INCLUDE_DIR})
target_link_libraries (${EXEC_FILE_SDL} ${SDL2_LIBRARY})
target_link_libraries (${EXEC_FILE_SDL} ${IMGUI_LIBRARY})
target_link_libraries (${EXEC_FILE_SDL} ${CMAKE_DL_LIBS})


target_link_libraries (${EXEC_FILE_GLFW} ${IMGUI_LIBRARY})
target_link_libraries (${EXEC_FILE_GLFW} ${CMAKE_DL_LIBS})
target_link_libraries (${EXEC_FILE_GLFW} ${glfw_target})


