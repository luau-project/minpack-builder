# Build and Install on Windows (GFortran)

For this tutorial, we are going to use Windows 11 mostly in a command prompt-only fashion, compiling the library with GFortran from MSYS2. In this guide, we obtain MSYS2 through ```winget``` (Microsoft's package manager).

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
    * MSYS2;
    * gfortran (latest provided by MSYS2);
    * make (latest provided by MSYS2);
    * git;
    * cmake (>= 3.17).

### Pre-installation steps

According to [Microsoft](https://github.com/microsoft/winget-cli), the recommended way to install ```winget``` (a package manager for Windows maintained by Microsoft) goes through the Microsoft Store, distributed within the [App Installer](https://www.microsoft.com/p/app-installer/9nblggh4nns1) package. So, go ahead and install it.

> [!NOTE]
> 
> On my personal experience using a fresh Windows 11 installation for this guide, if you download and install all the Windows updates and restart your computer the many times required, ```winget``` will get installed in the process.

You can check that ```winget``` got properly installed if the search command works well on ```cmd``` once you answer ```Y``` when asked. For example, running a search ```winget search MSYS2``` for MSYS2 on ```winget```, you would receive an output like this:

<!-- image here -->

### Install the required tools

> [!TIP]
>
> You might skip the steps for the tools that you already have installed on your computer.

> [!NOTE]
> 
> Although you can opt to install all the tools directly from MSYS2 (*they have packages for each tool on their repositories*), we are going to build minpack in a standard command prompt, i.e., out of MSYS2 shell.

1. (Optional if you have git) Install and update MSYS2
    1. The first step is the installation on MSYS2 on your computer, in case you don't have it yet
        ```cmd
        winget install --id MSYS2.MSYS2 --source winget --accept-package-agreements --accept-source-agreements --silent
        ```
    2. (Optional, but recommended) Update MSYS2 utilities and packages running the same command twice:
        ```cmd
        %homedrive%\msys64\usr\bin\bash.exe -lc "pacman -Syuu --noconfirm --overwrite *"
        %homedrive%\msys64\usr\bin\bash.exe -lc "pacman -Syuu --noconfirm --overwrite *"
        ```
    > [!NOTE]
    > 
    > ```%homedrive%``` is a system environment variable on Windows that points to the drive letter (```C:``` if you didn't perform a custom Windows install). If you have a standard MSYS2 installation, it gets installed at ```%homedrive%\msys64```, which expands to ```C:\msys64```. You might change it above in case you have MSYS2 elsewhere.

2. Install GFortran + GNU Make targeting x86_64 architecture from MSYS2
    ```cmd
    %homedrive%\msys64\usr\bin\bash.exe -lc "pacman -S mingw-w64-x86_64-gcc-fortran mingw-w64-x86_64-make --noconfirm --overwrite *"
    ```
    
    It is a good idea to test the installation of ```gfortran``` and ```make``` by running the command
    
    ```cmd
    %homedrive%\msys64\mingw64\bin\gfortran.exe --version
    %homedrive%\msys64\mingw64\bin\mingw32-make.exe --version
    ```
     
    <!-- image here -->

3. (Optional if you have git) Install git
    ```cmd
    winget install --id Git.Git --source winget --accept-package-agreements --accept-source-agreements --silent
    ```
4. (Optional if you have CMake >= 3.17) Install CMake
    ```cmd
    winget install --id Kitware.CMake --source winget --accept-package-agreements --accept-source-agreements --silent
    ```

> [!IMPORTANT]
> 
> You must close the command prompt, because the installed tools are not on your system environment PATH variable until you launch a new fresh command prompt.

## Build and Install minpack

1. Launch a vanilla (admin rights not needed) command prompt.
2. Place the directory of MSYS2 tools (```gfortran``` + ```make```) in the system environment PATH variable in order for CMake to find them
    ```cmd
    set PATH=%homedrive%\msys64\mingw64\bin;%PATH%
    ```

3. Test that all the needed tools are available on your command prompt
    ```cmd
    gfortran.exe --version
    mingw32-make.exe --version
    git --version
    cmake --version
    ```

<!-- image here -->

4. Set a cmd variable to hold a working directory. In sequence, create that directory, and then change dir to this newly created working dir
    ```cmd
    set working_dir=%homedrive%\minpack-builder-gfortran-guide
    mkdir %working_dir%
    cd %working_dir%
    ```
5. Set cmd variables for the build and install directories
    ```cmd
    set BUILD_DIR=%working_dir%\build-gfortran
    set INSTALL_DIR=%working_dir%\local-install-gfortran
    ```
> [!NOTE]
> 
> If your ```%homedrive%``` variable points to ```C:```, we are going for a local installation at ```C:\minpack-builder-gfortran-guide\local-install-gfortran```, building the package at ```C:\minpack-builder-gfortran-guide\build-gfortran```.

6. Clone minpack-builder by running ```git clone https://github.com/luau-project/minpack-builder```

<!-- image here -->

7. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake -G "MinGW Makefiles" --install-prefix "%INSTALL_DIR%" -S minpack-builder -B "%BUILD_DIR%"
    ```

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

8. Review the configuration summary and proceed to build

<!-- image here -->

9. Build the library. 

    ```
    cmake --build "%BUILD_DIR%"
    ```

<!-- image here -->

> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.


> [!IMPORTANT]
> 
> Unlike Linux, on Windows you cannot build both shared and static libraries in the same step, because the library name collides (``minpack.lib``). Then, you can only build one version at a time. Be aware that if you install both in the same directory, the latter will map to ``minpack.lib``.

10. Install the library

    ```
    cmake --install "%BUILD_DIR%"
    ```

<!-- image here -->

---
[Documentation](README.md)
