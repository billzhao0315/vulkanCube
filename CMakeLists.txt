cmake_minimum_required(VERSION 3.16)
project(VulkanCube)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Vulkan
find_package(Vulkan REQUIRED)

# Find GLFW
#find_package(glfw3 CONFIG REQUIRED)

# Find GLM
#find_package(glm CONFIG REQUIRED)

# Add executable
add_executable(VulkanCube main.cpp)

# Link libraries
target_link_libraries(VulkanCube PRIVATE 
    Vulkan::Vulkan
    glfw3 
    #glfw
    #glm::glm
)

# ===== thirdparty paths =====
set(THIRDPARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty)

# ===== GLM (header-only) =====
target_include_directories(VulkanCube PRIVATE
    ${THIRDPARTY_DIR}/glm
)

# 推荐：Vulkan 常用（深度 0..1）+ 统一弧度（可选但推荐）
target_compile_definitions(VulkanCube PRIVATE
    GLM_FORCE_DEPTH_ZERO_TO_ONE
    GLM_FORCE_RADIANS
)

# ===== GLFW (prebuilt, MSVC 2022, static) =====
set(GLFW_DIR ${THIRDPARTY_DIR}/glfw-3.4.bin.WIN64)

target_include_directories(VulkanCube PRIVATE
    ${GLFW_DIR}/include
)

# 静态库文件目录
set(GLFW_LIB_DIR ${GLFW_DIR}/lib-vc2022)

# 导入静态库 glfw3.lib
add_library(glfw3 STATIC IMPORTED GLOBAL)
set_target_properties(glfw3 PROPERTIES
    IMPORTED_LOCATION ${GLFW_LIB_DIR}/glfw3.lib
)


target_compile_definitions(VulkanCube PRIVATE
    GLM_FORCE_RADIANS
    GLM_FORCE_DEPTH_ZERO_TO_ONE
)


# Copy shaders to build directory
add_custom_command(TARGET VulkanCube POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/shaders
    $<TARGET_FILE_DIR:VulkanCube>/shaders
)
