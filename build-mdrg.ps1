cd UniverseLib
dotnet build .\src\UniverseLib.sln -c Release_IL2CPP_Interop_ML
cd ..

# ----------- MelonLoader IL2CPP CoreCLR (net6) -----------
dotnet build src/UnityExplorer.sln -c Release_ML_Cpp_CoreCLR
$Path = "Release\UnityExplorer.MelonLoader.IL2CPP.CoreCLR"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net6 /lib:lib/interop /lib:$Path /internalize /out:$Path/UnityExplorer.ML.IL2CPP.CoreCLR.dll $Path/UnityExplorer.ML.IL2CPP.CoreCLR.dll $Path/mcs.dll
# (cleanup and move files)
Remove-Item $Path/UnityExplorer.ML.IL2CPP.CoreCLR.deps.json
Remove-Item $Path/UnityExplorer.ML.IL2CPP.CoreCLR.pdb
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Iced.dll
Remove-Item $Path/Il2CppInterop.Common.dll
Remove-Item $Path/Il2CppInterop.Runtime.dll
Remove-Item $Path/Microsoft.Extensions.Logging.Abstractions.dll
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/UnityExplorer.ML.IL2CPP.CoreCLR.dll -Destination $Path/Mods -Force
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.ML.IL2CPP.Interop.dll -Destination $Path/UserLibs -Force
# (create zip archive)
Remove-Item $Path/../UnityExplorer.MelonLoader.IL2CPP.CoreCLR.zip -ErrorAction SilentlyContinue
compress-archive .\$Path\* $Path/../UnityExplorer.MelonLoader.IL2CPP.CoreCLR.zip
