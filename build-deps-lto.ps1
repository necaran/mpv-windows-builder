$env:workspace = (Get-Location).Path
Set-Location mpv-deps-builder
.\build-vcpkg-lto.ps1