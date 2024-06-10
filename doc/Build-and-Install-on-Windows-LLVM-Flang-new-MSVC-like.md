# Build and Install on Windows 11 (LLVM flang-new MSVC-like)

For this tutorial, we are going to use Windows 11 mostly in a command prompt-only fashion, compiling the library with LLVM flang-new (MSVC-like). LLVM flang-new is obtained from ```conda-forge``` with Miniforge.

> [!NOTE]
> 
> At the time of writing this guide, recent versions of LLVM flang-new (MSVC-like) requires Visual Studio 2022 or 2019 native build tools to work nicely.

## Table of Contents

* [Requirements](#requirements)
    * [Pre-installation steps](#pre-installation-steps)
    * [Install the usual tools and prepare to install LLVM flang-new](#install-the-usual-tools-and-prepare-to-install-llvm-flang-new)
    * [Install LLVM flang-new (MSVC-like) with Miniforge](#install-llvm-flang-new-msvc-like-with-miniforge)
* [Build and install minpack](#build-and-install-minpack)

## Requirements

1. Have the skills needed to adapt the commands contained here for Windows 10, if it applies;
2. Command prompt **running as administrator** opened;
3. Internet connection;
4. Tools:
    * Microsoft Visual C/C++ (MSVC) build tools for native C/C++ x86/x64 development (latest) + Windows SDK (suitable for your target platform);
    * Miniforge;
    * LLVM flang-new (MSVC-like) from ```conda-forge```.
    * git;
    * Ninja (&ge; 1.10);
    * cmake.

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

### Install the usual tools and prepare to install LLVM flang-new

> [!TIP]
>
> You might skip the steps for the tools that you already have installed on your computer.

1. Close any Visual Studio instances opened on your machine;
2. Open a command prompt **running as administrator** to avoid permission issues when installing the tools required here;

    ![Screenshot from 2024-05-05 12-27-04](https://github.com/luau-project/minpack-builder/assets/18295115/a4ba3d9f-4832-4f91-baf3-d9ea1bb76748)

3. Make sure to have installed both MSVC Build Tools 2022 for native C/C++ x86/x64 development, and a Windows SDK:
    * If you don't have Visual Studio 2022 installed and just want MSVC native C/C++ compilers for x86/x64, install them with the command below depending on the Windows version that you are targeting
        * Windows 10
            ```cmd
            winget install --id Microsoft.VisualStudio.2022.BuildTools --source winget --silent --override "--quiet --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.18362"
            ```
        * Windows 11
            ```cmd
            winget install --id Microsoft.VisualStudio.2022.BuildTools --source winget --silent --override "--quiet --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000"
            ```
    * Otherwise, assuming that you already have a Visual Studio 2022 instance previously installed, you can modify it to include native C/C++ x86/x64 development + Windows SDK depending on the Windows version that you are targeting:
        * Windows 10
            ```cmd
            if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (for /f "usebackq tokens=*" %i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property properties.setupEngineFilePath`) do ( for /f "usebackq tokens=*" %j in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property installationPath`) do ( "%comspec%" /C ""%i" modify --quiet --installPath "%j" --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.18362" ) ) ) else ( echo "Unable to find vswhere.exe" )
            ```
        * Windows 11
            ```cmd
            if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (for /f "usebackq tokens=*" %i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property properties.setupEngineFilePath`) do ( for /f "usebackq tokens=*" %j in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -property installationPath`) do ( "%comspec%" /C ""%i" modify --quiet --installPath "%j" --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000" ) ) ) else ( echo "Unable to find vswhere.exe" )
            ```
4. (Optional if you have Miniforge3) Install Miniforge
    ```cmd
    winget install --id CondaForge.Miniforge3 --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
5. (Optional if you have git) Install git
    ```cmd
    winget install --id Git.Git --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
6. (Optional if you have Ninja &ge; 1.10) Install Ninja
    ```cmd
    winget install --id Ninja-build.Ninja --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
7. (Optional if you have a recent CMake - tested on CMake 3.29.3) Install CMake
    ```cmd
    winget install --id Kitware.CMake --source winget --accept-package-agreements --accept-source-agreements --silent
    ```

> [!IMPORTANT]
> 
> You must close the command prompt, because the installed tools are not on your system environment PATH variable until you launch a new fresh command prompt.

### Install LLVM flang-new (MSVC-like) with Miniforge

1. Launch a vanilla (admin rights not needed) new fresh ``x64 Native Tools Command Prompt for VS 2022`` to build 64-bit flang-new.

    ![Screenshot from 2024-05-05 17-31-44](https://github.com/luau-project/minpack-builder/assets/18295115/3cc4a4e0-5a36-4f3c-b087-9136e94e3148)

2. Activate Miniforge
    ```cmd
    %userprofile%\miniforge3\Scripts\activate.bat %userprofile%\miniforge3
    ```

> [!WARNING]
> 
> ```%userprofile%``` is a system environment variable on Windows that points to ```C:\Users\<you user name>```. If you performed a standard Miniforge install, it gets installed at ```%userprofile%\miniforge3```. However, in case you installed Miniforge elsewhere, adjust the path above replacing ```%userprofile%\miniforge3``` by the installation directory.

3. Check that conda is available:
    ```cmd
    conda --version
    ```

    ![Screenshot from 2024-06-07 21-05-26](https://github.com/luau-project/minpack-builder/assets/18295115/ba296717-0f2a-4c62-89c6-4850d4934be9)

4. Create an environment for minpack-builder installing LLVM flang-new (MSVC-like) from ```conda-forge```:
    ```cmd
    conda create --yes -c conda-forge -n minpack-builder flang libflang libfortran-main
    ```

5. Activate the minpack-builder environment created in the latest step
    ```cmd
    conda activate minpack-builder
    ```

6. Check that LLVM flang-new (MSVC-like) is available and print its version
    ```cmd
    flang-new --version
    ```

    ![Screenshot from 2024-06-07 21-21-01](https://github.com/luau-project/minpack-builder/assets/18295115/bab70581-2fb9-4079-b9dd-1a14ec00aca5)

> [!IMPORTANT]
> 
> If the test above worked fined, close the command prompt.

## Build and install minpack

1. Launch a vanilla (admin rights not needed) new fresh ``x64 Native Tools Command Prompt for VS 2022`` to build 64-bit minpack.

    ![Screenshot from 2024-05-05 17-31-44](https://github.com/luau-project/minpack-builder/assets/18295115/3cc4a4e0-5a36-4f3c-b087-9136e94e3148)

2. Activate Miniforge
    ```cmd
    %userprofile%\miniforge3\Scripts\activate.bat %userprofile%\miniforge3
    ```
3. Activate ```minpack-builder``` environment created earlier
    ```cmd
    conda activate minpack-builder
    ```

4. Check that all the required tools are available:
    ```cmd
    cl
    flang-new --version
    git --version
    cmake --version
    ninja --version
    ```

    ![Screenshot from 2024-06-07 21-31-26](https://github.com/luau-project/minpack-builder/assets/18295115/047f54b4-dd32-48e5-b929-23e83a5c934a)

5. Set a variable to hold the path to a working directory, create that directory, and then change dir to this new directory
    ```cmd
    set working_dir=%homedrive%\minpack-builder-flang-new-guide
    mkdir %working_dir%
    cd %working_dir%
    ```

6. Set variables for the build and install directories
    ```cmd
    set BUILD_DIR=%working_dir%\build-flang-new
    set INSTALL_DIR=%working_dir%\local-install-flang-new
    ```

> [!NOTE]
> 
> If your ```%homedrive%``` variable points to ```C:```, we are going for a local installation at ```C:\minpack-builder-flang-new-guide\local-install-flang-new```, building the package at ```C:\minpack-builder-flang-new-guide\build-flang-new```.

7. Set a variable for the build tools to treat ```flang-new``` as the **F**ortran **C**ompiler
    ```cmd
    set FC=flang-new
    ```

8. Clone minpack-builder by running 

    ```cmd
    git clone https://github.com/luau-project/minpack-builder
    ```

    ![Screenshot from 2024-06-07 21-42-10](https://github.com/luau-project/minpack-builder/assets/18295115/5b914fa9-12a3-44df-91cb-631877146016)

9. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake -G Ninja --install-prefix "%INSTALL_DIR%" -S minpack-builder -B "%BUILD_DIR%"
    ```

> [!IMPORTANT]
> 
> In my personal tests, the only generator that worked properly was Ninja, which needs to be version &ge; 1.10 to build Fortran projects. Both Visual Studio or NMake generators failed in the configuration step.

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

10. Review the configuration summary and proceed to build

    ![Screenshot from 2024-06-07 21-42-48](https://github.com/luau-project/minpack-builder/assets/18295115/da2d1bb5-7955-42b2-a3bd-ae6c9c656cfa)

11. Build the library. 

    ```
    cmake --build "%BUILD_DIR%"
    ```

    ![Screenshot from 2024-06-07 21-43-15](https://github.com/luau-project/minpack-builder/assets/18295115/9b2c574d-f31f-4cab-9899-624db0893b22)


> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.


> [!IMPORTANT]
> 
> Unlike Linux, on Windows you cannot build both shared and static libraries in the same step, because the library name collides (``minpack.lib``). Then, you can only build one version at a time. Be aware that if you install both in the same directory, the latter will map to ``minpack.lib``.

12. Install the library

    ```
    cmake --install "%BUILD_DIR%"
    ```

    ![Screenshot from 2024-06-07 21-43-38](https://github.com/luau-project/minpack-builder/assets/18295115/84e9b3a6-ac33-48f9-a78f-773676fa41a1)

---
[Documentation](README.md)
