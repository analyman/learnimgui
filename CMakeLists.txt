cmake_minimum_required(VERSION 3.5)
project(learn_imgui)

add_executable(main ./src/main.cpp)

include_directories (./third_party/imgui)
include_directories (./third_party/imgui/examples)

