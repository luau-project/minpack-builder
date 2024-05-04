# Documentation

Welcome to the minpack-builder documentation! Here, you can find all the possible configuration options supported by ```minpack-builder```, and detailed build-and-install instructions for minpack on different combinations of platform / Fortran compiler toolchain. Moreover, we provide documentation to use minpack as a CMake package after you installed it through ```minpack-builder```.

## Build and Install Usage

> [!IMPORTANT]
> 
> At the moment, the documentation for usage is in early stages.

The build-and-install usage is split by platform and Fortran compiler. For now, you can check the usage on Linux, building minpack with GFortran or Intel Fortran Compiler (ifx).

* Windows (documentation not available yet)
* Linux
    * [Build and install minpack on Linux with GFortran](Build-and-Install-on-Linux-GFortran.md)
    * [Build and install minpack on Linux with Intel Fortran Compiler (ifx)](Build-and-Install-on-Linux-Intel-Fortran-Compiler-ifx.md)

## Configuration Options

Take a look at [Configuration Options](Configuration-Options.md).

## CMake Package

After you have built and installed minpack through ```minpack-builder```, you can use minpack as a CMake Package. For detailed instructions, have a read at [CMake Package](CMake-Package.md).