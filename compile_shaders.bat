@echo off
REM Shader compilation script for Windows
REM Requires glslc from Vulkan SDK

echo Compiling shaders...

glslc shaders/shader.vert -o shaders/shader.vert.spv
if %ERRORLEVEL% neq 0 (
    echo Failed to compile vertex shader
    exit /b 1
)

glslc shaders/shader.frag -o shaders/shader.frag.spv
if %ERRORLEVEL% neq 0 (
    echo Failed to compile fragment shader
    exit /b 1
)

echo Shaders compiled successfully!
