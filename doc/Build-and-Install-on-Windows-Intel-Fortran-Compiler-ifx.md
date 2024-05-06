# Build and Install on Windows 11 (Intel ifx)

For this tutorial, we are going to use Windows 11 mostly in a command prompt-only fashion, compiling the library with Intel Fortran Compiler (ifx) acquired through ```winget``` (Microsoft's package manager).

> [!NOTE]
> 
> At the time of writing this guide, the latest Intel Fortran Compiler (ifx), which is ifx 2024.1, requires Visual Studio 2022 or 2019 native build tools to work nicely.

## Table of Contents

* [Requirements](#requirements)
    * [Pre-installation steps](#pre-installation-steps)
    * [Install the required tools](#install-the-required-tools)
* [Build and Install minpack](#build-and-install-minpack)

## Requirements

1. Have the skills needed to adapt the commands contained here for Windows 10, if it applies;
2. Command prompt **running as administrator** opened;
3. Internet connection;
4. Tools:
    * Microsoft Visual C/C++ (MSVC) build tools for native C/C++ x86/x64 development (latest) + Windows SDK (suitable for your target platform);
    * ifx (latest version available on winget repositories);
    * git;
    * Ninja (>= 1.10);
    * cmake (>= 3.17).

### Pre-installation steps

According to [Microsoft](https://github.com/microsoft/winget-cli), the recommended way to install ```winget``` (a package manager for Windows maintained by Microsoft) goes through the Microsoft Store, distributed within the [App Installer](https://www.microsoft.com/p/app-installer/9nblggh4nns1) package. So, go ahead and install it.

> [!NOTE]
> 
> On my personal experience using a fresh Windows 11 installation for this guide, if you download and install all the Windows updates and restart your computer the many times required, ```winget``` will get installed in the process.

You can check that ```winget``` got properly installed if the search command

```cmd
winget search "visual studio"
```

works well on ```cmd``` once you answer ```Y``` when asked. You would receive an output like this:

![Screenshot from 2024-05-05 10-54-50](https://github.com/luau-project/minpack-builder/assets/18295115/2eabeafc-a898-4a97-8fba-937ec5bec0a5)

### Install the required tools

> [!TIP]
>
> You might skip the steps for the tools that you already have installed on your computer.

1. Close any Visual Studio instances opened on your machine;
2. Open a command prompt **running as administrator** to avoid permission issues when installing the tools required here;

    ![Screenshot from 2024-05-05 12-27-04](https://github.com/luau-project/minpack-builder/assets/18295115/a4ba3d9f-4832-4f91-baf3-d9ea1bb76748)

3. Set a variable to hold the path to a working directory, create that directory, and then change dir to this new directory
    ```cmd
    set working_dir=%homedrive%\minpack-builder-guide
    mkdir %working_dir%
    cd %working_dir%
    ```

    ![Screenshot from 2024-05-05 12-28-57](https://github.com/luau-project/minpack-builder/assets/18295115/3ea47e3f-7cbc-40f4-9585-5b7eb7d7dd73)

> [!NOTE]
> 
> ```%homedrive%``` is a Windows environment variable that expands to your root letter (```C:``` in case you performed a vanilla Windows install). For instance, if your home drive is ``D:``, then ``D:\minpack-builder-guide`` will be used as working directory.

4. Make sure to have installed both MSVC Build Tools 2022 for native C/C++ x86/x64 development, and a Windows SDK:
    * If you don't have Visual Studio 2022 installed and just want MSVC native C/C++ compilers for x86/x64, install them with the command below depending on the Windows version that you are targeting
        * Windows 10
            ```cmd
            winget install --id Microsoft.VisualStudio.2022.BuildTools --source winget --silent --override "--wait --quiet --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.18362"
            ```
        * Windows 11
            ```cmd
            winget install --id Microsoft.VisualStudio.2022.BuildTools --source winget --silent --override "--wait --quiet --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000"
            ```
    * Otherwise, assuming that you already have a Visual Studio 2022 instance previously installed, you can modify it to include native C/C++ x86/x64 development + Windows SDK depending on the Windows version that you are targeting:
        * Windows 10
            ```cmd
            if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (for /f "usebackq tokens=*" %i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property properties.setupEngineFilePath`) do ( for /f "usebackq tokens=*" %j in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property installationPath`) do ( "%i" modify --installPath "%j" --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.18362 ) ) ) else ( echo "Unable to find vswhere.exe" )
            ```
        * Windows 11
            ```cmd
            if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (for /f "usebackq tokens=*" %i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property properties.setupEngineFilePath`) do ( for /f "usebackq tokens=*" %j in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property installationPath`) do ( "%i" modify --installPath "%j" --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000 ) ) ) else ( echo "Unable to find vswhere.exe" )
            ```
5. (Optional if you have ifx) Install Intel Fortran Compiler (ifx)
    ```cmd
    winget install --id Intel.FortranCompiler --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
6. (Optional if you have git) Install git
    ```cmd
    winget install --id Git.Git --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
7. (Optional if you have Ninja >= 1.10) Install Ninja
    ```cmd
    winget install --id Ninja-build.Ninja --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
8. (Optional if you have CMake >= 3.17) Install CMake
    ```cmd
    winget install --id Kitware.CMake --source winget --accept-package-agreements --accept-source-agreements --silent
    ```

> [!IMPORTANT]
> 
> You must close the command prompt, because the installed tools are not on your system environment PATH variable until you launch a new fresh command prompt.

## Build and Install minpack

1. Launch a vanilla (admin rights not needed) new fresh ``x64 Native Tools Command Prompt for VS 2022`` to build 64-bit minpack or ``x86 Native Tools Command Prompt for VS 2022`` to build 32-bit minpack.

    ![Screenshot from 2024-05-05 17-31-44](https://github.com/luau-project/minpack-builder/assets/18295115/3cc4a4e0-5a36-4f3c-b087-9136e94e3148)

2. Load Intel oneAPI variables to access ifx compiler

    ```cmd
    call "%ProgramFiles(x86)%\Intel\oneAPI\setvars.bat"
    ```

    ![Screenshot from 2024-05-05 17-41-39](https://github.com/luau-project/minpack-builder/assets/18295115/527e2acc-1b95-409c-87e5-9e8c9bbf75c9)

> [!NOTE]
> 
> If you performed the standard install for Intel Fortran Compiler, it gets installed at ```%ProgramFiles(x86)%\Intel\oneAPI```. Change the path above if you installed somewhere else.

3. Set again a variable to hold the path to that working directory created previously, and then change dir to the working directory
    ```cmd
    set working_dir=%homedrive%\minpack-builder-guide
    cd %working_dir%
    ```

4. Set cmd variables for the build and install directories
    ```cmd
    set BUILD_DIR=%working_dir%\build-ifx
    set INSTALL_DIR=%working_dir%\local-install-ifx
    ```
> [!NOTE]
> 
> If your ```%homedrive%``` variable points to ```C:```, we are going for a local installation at ```C:\minpack-builder-guide\local-install-ifx```, building the package at ```C:\minpack-builder-guide\build-ifx```.

5. Clone minpack-builder by running ```git clone https://github.com/luau-project/minpack-builder```

    ![Screenshot from 2024-05-05 17-48-51](https://github.com/luau-project/minpack-builder/assets/18295115/f77c04d4-1beb-47eb-b62b-0d5d9b142330)

6. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake -G Ninja --install-prefix "%INSTALL_DIR%" -S minpack-builder -B "%BUILD_DIR%"
    ```

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

7. Review the configuration summary and proceed to build

    ![Screenshot from 2024-05-05 17-50-07](https://github.com/luau-project/minpack-builder/assets/18295115/9c5bdb1f-4a6f-4b04-a6d9-06930211342f)

8. Build the library. 

    ```
    cmake --build "%BUILD_DIR%"
    ```

    ![Screenshot from 2024-05-05 17-51-29](https://github.com/luau-project/minpack-builder/assets/18295115/c296a828-137d-4443-8a6f-92894cee49c0)

> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.


> [!IMPORTANT]
> 
> Unlike Linux, on Windows you cannot build both shared and static libraries in the same step, because the library name collides (``minpack.lib``). Then, you can only build one version at a time. Be aware that if you install both in the same directory, the latter will map to ``minpack.lib``.

9. Install the library

    ```
    cmake --install "%BUILD_DIR%"
    ```

    ![Screenshot from 2024-05-05 17-51-55](https://github.com/luau-project/minpack-builder/assets/18295115/6162aa03-3ec0-4690-be85-c7d7b9e0ee1e)

---
[Documentation](README.md)
