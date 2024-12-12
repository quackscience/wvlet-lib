# Download the appropriate files for the target triplet
if(VCPKG_TARGET_TRIPLET MATCHES "arm64-linux" OR (VCPKG_TARGET_ARCH STREQUAL "arm64" AND CMAKE_SYSTEM_NAME STREQUAL "Linux"))
    set(WVLET_STATIC_URL "https://github.com/quackscience/wvlet-lib/releases/download/latest/linux-arm64_libwvlet.a")
    set(WVLET_DYNAMIC_URL "https://github.com/quackscience/wvlet-lib/releases/download/latest/linux-arm64_libwvlet.so")
elif(VCPKG_TARGET_TRIPLET MATCHES "x64-linux" OR VCPKG_TARGET_ARCH STREQUAL "x64")
    set(WVLET_STATIC_URL "https://github.com/quackscience/wvlet-lib/releases/download/latest/linux-x64_libwvlet.a")
    set(WVLET_DYNAMIC_URL "https://github.com/quackscience/wvlet-lib/releases/download/latest/linux-x64_libwvlet.so")
elif(VCPKG_TARGET_TRIPLET MATCHES "arm64-osx" OR (VCPKG_TARGET_ARCH STREQUAL "arm64" AND CMAKE_SYSTEM_NAME STREQUAL "Darwin"))
    set(WVLET_STATIC_URL "https://github.com/quackscience/wvlet-lib/releases/download/latest/mac-arm64_libwvlet.a")
    set(WVLET_DYNAMIC_URL "https://github.com/quackscience/wvlet-lib/releases/download/latest/mac-arm64_libwvlet.dylib")
else()
    message(FATAL_ERROR "Unsupported platform or architecture")
endif()

# Download the static library
file(DOWNLOAD
    ${WVLET_STATIC_URL}
    ${CURRENT_PACKAGES_DIR}/lib/libwvlet.a
    SHOW_PROGRESS
)
# Download the dynamic library
file(DOWNLOAD
    ${WVLET_DYNAMIC_URL}
    ${CURRENT_PACKAGES_DIR}/lib/libwvlet${CMAKE_SHARED_LIBRARY_SUFFIX}
    SHOW_PROGRESS
)
# Install libraries
vcpkg_copy_tools(
    TOOLS libwvlet.a libwvlet${CMAKE_SHARED_LIBRARY_SUFFIX}
    DESTINATION lib
)
# If there are headers to include, add them to the include directory
# For example:
# file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Add package configuration
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/wvlet-lib)
