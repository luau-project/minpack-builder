# Documentation

Welcome to the minpack-builder documentation! Here, you can find all the possible configuration options supported by ```minpack-builder```, and detailed build-and-install instructions for minpack on different combinations of platform / Fortran compiler toolchain. Moreover, we provide documentation to use minpack as a CMake package after you installed it through ```minpack-builder```.

## Build and Install Usage

> [!NOTE]
> 
> At the moment, the documentation is not in a complete state.

For now, we have guides to build and install minpack on Windows and Linux, using different Fortran compilers: GFortran, Intel Fortran Compiler (ifx) and LLVM flang.

The following build-and-install guides were split by platform and Fortran compiler:

* Windows
    * [Build and install minpack on Windows with GFortran](Build-and-Install-on-Windows-GFortran.md)
    * [Build and install minpack on Windows with Intel Fortran Compiler (ifx)](Build-and-Install-on-Windows-Intel-Fortran-Compiler-ifx.md)
    * [Build and install minpack on Windows with LLVM flang (MSVC-like)](Build-and-Install-on-Windows-LLVM-Flang-MSVC-like.md)
* Linux
    * [Build and install minpack on Linux with GFortran](Build-and-Install-on-Linux-GFortran.md)
    * [Build and install minpack on Linux with Intel Fortran Compiler (ifx)](Build-and-Install-on-Linux-Intel-Fortran-Compiler-ifx.md)
* macOS
    * [Build and install minpack on macOS with GFortran](Build-and-Install-on-macOS-GFortran.md)
    * [Build and install minpack on macOS with LLVM flang](Build-and-Install-on-macOS-LLVM-Flang.md)

> [!TIP]
> 
> On Windows, Intel Fortran Compiler (ifx) emits libraries compatible to Microsoft Visual C/C++ (MSVC) build tools, what we call here *MSVC-like*.

## Configuration Options

Take a look at [Configuration Options](Configuration-Options.md).

## CMake Package

After you have built and installed minpack through ```minpack-builder```, you can use minpack as a CMake Package. For detailed instructions, have a read at [CMake Package](CMake-Package.md).

## Project-specific targets

We also have a few specific targets for some operations. For further information, take a look at [Project-specific targets](Project-Targets.md).
