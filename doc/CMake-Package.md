# CMake Package

## Table of Contents
* [Description](#description)
* [Variables](#variables)
* [Usage](#usage)
    * [Windows](#windows)
    * [Unix](#unix)

## Description

When minpack is installed through ```minpack-builder```, it is installed as a CMake package using the config mode of ``find_package``, which you can read more about at [Finding Packages](https://cmake.org/cmake/help/book/mastering-cmake/chapter/Finding%20Packages.html).

> [!NOTE]
> 
> By default, the module tries to keep compatibility with the usual minpack library installed by the distribution through the package manager.

## Variables

Below, you can find a list of all exported CMake variables in the configuration file turned available through ```find_package(minpack)```.

| Variable | Type | Description |
|----------|------|-------------|
| minpack_FOUND | BOOL | True if library and headers were found. |
| minpack_ROOT_DIR | PATH | Root directory of minpack. |
| minpack_INSTALL_PREFIX | PATH | Root directory of minpack. |
| minpack_LIBRARY | PATH | Path to minpack library. |
| minpack_LIBRARIES | LIST | minpack libraries to link against. |
| minpack_LIBRARY_DIR | PATH | Directory where library files are stored. |
| minpack_INCLUDE_DIR | PATH | Directory where header files are stored. |
| minpack_INCLUDE_DIRS | LIST | List of include dirs needed to use minpack. |
| minpack_FORTRAN_FLAGS | LIST | List of Fortran flags to compile. |
| minpack_VERSION_MAJOR | STRING | Major version of minpack, if present. |
| minpack_VERSION_MINOR | STRING | Minor version of minpack, if present. |
| minpack_VERSION_PATCH | STRING | Patch version of minpack, if present. |
| minpack_VERSION | STRING | Full version of minpack. |
| minpack_RUNTIME_DIR | PATH | Directory holding .dll files on Windows. |
| minpack_PKGCONFIG_DIR | PATH | Directory holding minpack.pc, if present. |

## Usage

### Windows

Assume you have installed minpack through minpack-builder at ```C:\minpack```.

* Environment variables (recommended)

    1. Append the installation directory of minpack to ```CMAKE_PREFIX_PATH``` environment variable:

        * cmd:
        ```cmd
        set MINPACK_INSTALL_DIR=C:\minpack

        if defined CMAKE_PREFIX_PATH (set CMAKE_PREFIX_PATH=%MINPACK_INSTALL_DIR%;%CMAKE_PREFIX_PATH%) else (set CMAKE_PREFIX_PATH=%MINPACK_INSTALL_DIR%)
        ```

        * powershell:
        ```powershell
        $env:MINPACK_INSTALL_DIR = "C:\minpack";

        if ($env:CMAKE_PREFIX_PATH) { $env:CMAKE_PREFIX_PATH = @("$env:MINPACK_INSTALL_DIR", "$env:CMAKE_PREFIX_PATH") -join [System.IO.Path]::PathSeparator; } else { $env:CMAKE_PREFIX_PATH = "$env:MINPACK_INSTALL_DIR"; }
        ```
    2. Call cmake to configure normally

        ```cmd
        cmake <PARAMETER LIST>
        ```

* CMake parameter

    You can configure it directly through

    ```
    cmake "-DCMAKE_PREFIX_PATH=C:/minpack" <PARAMETER LIST>
    ```

    > [!IMPORTANT]
    > 
    > If you chose the parameter-passing manner, you must be aware that CMake uses forward slash on prefix path, this is the reason ```C:/minpack``` is used above rather than ```C:\minpack```

On your ```CMakeLists.txt```, you can use ```minpack``` the following way

```cmake
cmake_minimum_required(VERSION 3.17)

project(MyUseOfMinpack LANGUAGES C)

find_package(minpack)

if (minpack_FOUND)
    message(STATUS "minpack found: ")
    message(STATUS "    minpack include dir: ${minpack_INCLUDE_DIR}")
    message(STATUS "    minpack library: ${minpack_LIBRARY}")
else()
    message(FATAL_ERROR "minpack was not found.")
endif()
``` 

### Unix
Assume you have installed minpack through minpack-builder at ```/tmp/minpack```.

* Environment variables

    1. Append the installation directory of minpack to ```CMAKE_PREFIX_PATH``` environment variable:
        ```bash
        MINPACK_INSTALL_DIR=/tmp/minpack
        export CMAKE_PREFIX_PATH="$MINPACK_INSTALL_DIR:$CMAKE_PREFIX_PATH"
        ```
    2. Call cmake to configure normally

        ```bash
        cmake <PARAMETER LIST>
        ```


* CMake parameter

    You can configure it directly through

    ```
    cmake "-DCMAKE_PREFIX_PATH=/tmp/minpack" <PARAMETER LIST>
    ```

On your ```CMakeLists.txt```, you can use ```minpack``` the following manner

```cmake
cmake_minimum_required(VERSION 3.17)

project(MyUseOfMinpack LANGUAGES C)

find_package(minpack)

if (minpack_FOUND)
    message(STATUS "minpack found: ")
    message(STATUS "    minpack include dir: ${minpack_INCLUDE_DIR}")
    message(STATUS "    minpack library: ${minpack_LIBRARY}")
else()
    message(FATAL_ERROR "minpack was not found.")
endif()
``` 

---
[Documentation](README.md)
