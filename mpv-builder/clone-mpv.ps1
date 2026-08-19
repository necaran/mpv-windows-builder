if (-not (Test-Path -Path 'mpv-windows')) {
    git clone --branch master --depth 1 https://github.com/mpv-player/mpv.git mpv-windows

    if (Test-Path -Path 'mpv') {
        Copy-Item -Path 'mpv\*' -Destination 'mpv-windows\' -Recurse -Force
    }

    New-Item -Path 'mpv-windows\subprojects' -ItemType Directory -Force | Out-Null
    git clone --branch master --depth 1 https://github.com/haasn/libplacebo.git 'mpv-windows/subprojects/libplacebo'
}
