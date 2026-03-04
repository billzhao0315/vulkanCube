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
- **Screenshot feature**: Save front and back faces of the cube as JPG images

## Controls

- **S key**: Save the front and back faces of the cube to `cube_front.jpg` and `cube_back.jpg`
- Close the window to exit the application

## Screenshot Feature Implementation

### Overview
Press the `S` key to save the cube's front and back faces as JPG images. The saved images include the color and texture blending effect, matching what you see in the window.

### Technical Implementation

#### 1. Dependencies Added
```cpp
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb_image_write.h>
```

#### 2. Offscreen Rendering Resources
Created dedicated offscreen rendering resources:
- `offscreenImage` - Color attachment for offscreen rendering
- `offscreenDepthImage` - Depth attachment
- `offscreenFramebuffer` - Framebuffer for offscreen rendering
- `offscreenRenderPass` - Render pass with `TRANSFER_SRC_OPTIMAL` final layout

#### 3. Two Pipelines with Different Cull Modes
```cpp
// Cull back faces -> render only front faces
frontFacePipeline = createCulledPipeline(VK_CULL_MODE_BACK_BIT);

// Cull front faces -> render only back faces
backFacePipeline = createCulledPipeline(VK_CULL_MODE_FRONT_BIT);
```

#### 4. Rendering Flow
```
Press 'S' key
    │
    ├─→ renderOffscreenAndSave(frontFacePipeline) ─→ cube_front.jpg
    │       Uses VK_CULL_MODE_BACK_BIT (cull back faces)
    │
    └─→ renderOffscreenAndSave(backFacePipeline) ─→ cube_back.jpg
            Uses VK_CULL_MODE_FRONT_BIT (cull front faces)
```

#### 5. Key Design Decisions

| Problem | Solution |
|---------|----------|
| Swapchain images not readable | Create separate offscreen image with `TRANSFER_SRC_BIT` |
| Separate front/back faces | Use different `cullMode`: `BACK_BIT` vs `FRONT_BIT` |
| Synchronization issues | Complete rendering and copy in the same command buffer |
| Image format conversion | Use `R8G8B8A8_UNORM` for offscreen, convert to RGB when saving |

## Project Structure

```
VulkanProgram/
├── CMakeLists.txt          # CMake build configuration
├── main.cpp                # Main application code
├── compile_shaders.bat     # Shader compilation script (Windows)
├── README.md               # This file
├── shaders/
│   ├── shader.vert         # Vertex shader (GLSL)
│   ├── shader.frag         # Fragment shader (GLSL)
│   ├── shader.vert.spv     # Compiled vertex shader (generated)
│   └── shader.frag.spv     # Compiled fragment shader (generated)
├── textures/
│   └── texture.jpg         # Cube texture
└── thirdparty/
    ├── glfw-3.4.bin.WIN64/ # GLFW library
    ├── glm/                # GLM math library
    ├── imgui/              # Dear ImGui (optional)
    └── stb/                # stb_image and stb_image_write
```
