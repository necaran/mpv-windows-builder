set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE static)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_BUILD_TYPE "release")

set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/x64-llvm-toolchains/clangcl-windows.cmake")
set(VCPKG_LOAD_VCVARS_ENV ON) 

if(DEFINED VCPKG_PLATFORM_TOOLSET)
    set(VCPKG_PLATFORM_TOOLSET ClangCL)
endif()
set(VCPKG_ENV_PASSTHROUGH_UNTRACKED "LLVMInstallDir;LLVMToolsVersion") 


set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled)

set(VCPKG_C_FLAGS_RELEASE "-flto=thin -fuse-ld=lld")
set(VCPKG_CXX_FLAGS_RELEASE "-flto=thin -fuse-ld=lld")

include("${CMAKE_CURRENT_LIST_DIR}/x64-llvm-toolchains/other.cmake")
