vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libcdio/libcdio-paranoia
    REF release-10.2+2.0.2
    SHA512 0740b2a4d32b3b511a7df8cbe04b35dbf55812c9ff307b68895fa6f44835da7a3864eb0ccd743bd8f18b18aeffa452165010eb491bcbf19507a9050e639caece
    HEAD_REF master
    PATCHES
        strip-subdirs.diff
        msvc-fixes.diff
)

set(extra_cppflags "")
if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
    set(extra_cppflags "CPPFLAGS=\$CPPFLAGS -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_WARNINGS -I${SOURCE_PATH}/.vs -DHAVE_SYS_TIMEB_H=1 -DHAVE_GETTIMEOFDAY=1")
endif()

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    AUTOCONFIG
    OPTIONS
        --disable-cxx
        --disable-example-progs
        --disable-test-progs
        --without-versioned-libs
        ${extra_cppflags}
)
vcpkg_install_make()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/tools"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
