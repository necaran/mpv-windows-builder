vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libcdio/libcdio
    REF ${VERSION}
    SHA512 0408e8ba8dd5521e97ca5ce7662e0cffe8504ce63f862b0553133428b8885be766c09909d9e7050a9c531a02504993d70ee7dfc47c430d3beceb69332be07b90
    HEAD_REF master
    PATCHES
        no-docs.diff
        msvc-io-h.diff
        msvc-win32-driver.diff
        msvc-alloca.diff
        msvc-alloca-src.diff
        strip-subdirs.diff
)

set(extra_cppflags "")
if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
    set(extra_cppflags "CPPFLAGS=\$CPPFLAGS -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_WARNINGS -I${SOURCE_PATH}/.vs -Doff64_t=__int64 -DHAVE_VSNPRINTF=1 -DHAVE_NTDDCDRM_H=1")
endif()

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    AUTOCONFIG
    ADDITIONAL_MSYS_PACKAGES texinfo
    OPTIONS
        --disable-cxx
        --without-versioned-libs
        ${extra_cppflags}
)
vcpkg_install_make()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()
vcpkg_replace_string(
    "${CURRENT_PACKAGES_DIR}/include/cdio/types.h"
    "#if defined(_MSC_VER)\n#include <unistd.h>\n#endif"
    "#if defined(_MSC_VER)\n#include <io.h>\n#include <fcntl.h>\ntypedef unsigned short mode_t;\n#ifdef _WIN64\ntypedef long long ssize_t;\n#else\ntypedef long ssize_t;\n#endif\n#endif"
)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/tools"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
