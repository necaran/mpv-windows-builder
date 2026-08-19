$env:workspace = (Get-Location).Path

Set-Location mpv-builder

.\env-win.ps1
.\env-clang.ps1
.\deps-vcpkg-lto.ps1
.\clone-mpv.ps1

Set-Location mpv-windows
..\setup-cl.ps1
..\compile.ps1
..\install.ps1
