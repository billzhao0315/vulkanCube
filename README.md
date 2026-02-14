# Vulkan Colored Cube

A simple Vulkan application that displays a rotating colored cube using Vulkan and GLFW.

## Prerequisites

- [Vulkan SDK](https://vulkan.lunarg.com/) (includes glslc shader compiler)
- [vcpkg](https://github.com/microsoft/vcpkg) for dependency management
- CMake 3.16 or higher
- C++17 compatible compiler

## Dependencies

Install dependencies using vcpkg:

```bash
vcpkg install glfw3 glm
```

## Building

### 1. Compile Shaders

First, compile the GLSL shaders to SPIR-V format:

```bash
compile_shaders.bat
```

### 2. Build the Project

```bash
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=[path/to/vcpkg]/scripts/buildsystems/vcpkg.cmake
cmake --build . --config Release
```

Or using Visual Studio:

```bash
cmake .. -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE=[path/to/vcpkg]/scripts/buildsystems/vcpkg.cmake
```

Then open the generated solution file and build.

## Running

Make sure the `shaders` folder (with compiled `.spv` files) is in the same directory as the executable, then run:

```bash
./VulkanCube
```

## Features

- Rotating colored cube with 6 different colored faces:
  - Front: Red
  - Back: Green
  - Top: Blue
  - Bottom: Yellow
  - Right: Magenta
  - Left: Cyan
- Depth testing for proper 3D rendering
- Window resize support
- Vulkan validation layers (in debug mode)

## Controls

- Close the window to exit the application

## Project Structure

```
VulkanProgram/
├── CMakeLists.txt          # CMake build configuration
├── main.cpp                # Main application code
├── compile_shaders.bat     # Shader compilation script (Windows)
├── README.md               # This file
└── shaders/
    ├── shader.vert         # Vertex shader (GLSL)
    ├── shader.frag         # Fragment shader (GLSL)
    ├── shader.vert.spv     # Compiled vertex shader (generated)
    └── shader.frag.spv     # Compiled fragment shader (generated)
```
