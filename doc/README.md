# Documentation

Welcome to the minpack-builder documentation! Here, you can find all the possible configuration options supported by ```minpack-builder```, and detailed build-and-install instructions for minpack on different combinations of platform / Fortran compiler toolchain. Moreover, we provide documentation to use minpack as a CMake package after you installed it through ```minpack-builder```.

## Build and Install Usage

> [!IMPORTANT]
> 
> At the moment, we have guides to build and install minpack on Windows and Linux, using either GFortran or Intel Fortran Compiler (ifx).

The build-and-install usage is split by platform and Fortran compiler. For now, we have the following guides:

* Windows
    * [Build and install minpack on Windows with GFortran](Build-and-Install-on-Windows-GFortran.md)
    * [Build and install minpack on Windows with Intel Fortran Compiler (ifx)](Build-and-Install-on-Windows-Intel-Fortran-Compiler-ifx.md)
* Linux
    * [Build and install minpack on Linux with GFortran](Build-and-Install-on-Linux-GFortran.md)
    * [Build and install minpack on Linux with Intel Fortran Compiler (ifx)](Build-and-Install-on-Linux-Intel-Fortran-Compiler-ifx.md)

## Configuration Options

Take a look at [Configuration Options](Configuration-Options.md).

## CMake Package

After you have built and installed minpack through ```minpack-builder```, you can use minpack as a CMake Package. For detailed instructions, have a read at [CMake Package](CMake-Package.md).