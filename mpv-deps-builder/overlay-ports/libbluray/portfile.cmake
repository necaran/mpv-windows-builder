vcpkg_from_gitlab(
    GITLAB_URL https://code.videolan.org
    OUT_SOURCE_PATH SOURCE_PATH
    REPO videolan/libbluray
    REF "${VERSION}"
    SHA512 2956a01f5cbf21a30387e62cccd97c1816948cc06d01ceca01447b533caade700c3600c094fe7ac4c1bec57c61d97f62d82fe81f382253d27f1531a632b0656c
)

if(NOT VCPKG_TARGET_IS_WINDOWS)
    list(APPEND options -Dfontconfig=enabled)
else()
    list(APPEND options -Dfontconfig=disabled)
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -Denable_tools=false
        -Dbdj_jar=disabled
        -Dfreetype=enabled
        -Dlibxml2=enabled
        ${options}
)

vcpkg_install_meson()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
