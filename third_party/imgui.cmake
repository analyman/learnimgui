cmake_minimum_required(VERSION 3.5)
project(imgui)

set(GL3W_DIR "${CMAKE_CURRENT_LIST_DIR}/imgui/examples/libs/gl3w")
include_directories(${GL3W_DIR})
file(GLOB GL3W_SRC "${GL3W_DIR}/GL/*.c")

file(GLOB IMGUI_SRC "${CMAKE_CURRENT_LIST_DIR}/imgui/*.cpp")
set(IMGUI_SDL_OPENGL3_IMPL_SRC 
    ${CMAKE_CURRENT_LIST_DIR}/imgui/examples/imgui_impl_sdl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/examples/imgui_impl_opengl3.cpp)

set(IMGUI_LIBRARY imgui)
add_library(${IMGUI_LIBRARY} STATIC ${IMGUI_SRC} ${IMGUI_SDL_OPENGL3_IMPL_SRC} ${GL3W_SRC})

include (FindOpenGL)
target_link_libraries(${IMGUI_LIBRARY} ${OPENGL_gl_LIBRARY})
target_link_libraries(${IMGUI_LIBRARY} ${OPENGL_LIBRARIES})

