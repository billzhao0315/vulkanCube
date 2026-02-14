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
    #glfw
    #glm::glm
)

# Copy shaders to build directory
add_custom_command(TARGET VulkanCube POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/shaders
    $<TARGET_FILE_DIR:VulkanCube>/shaders
)
