# minpack-builder

Build scripts for minpack.

## Table of Contents

* [Introduction](#introduction)
    * [Description](#description)
    * [What is minpack?](#what-is-minpack)
    * [Why minpack-builder is needed?](#why-minpack-builder-is-needed)
    * [How to solve the problem?](#how-to-solve-the-problem)
* [Documentation](#documentation)
* [Continuous Integration](#continuous-integration)
    * [Windows 11](#windows-11)
    * [Ubuntu 22.04](#ubuntu-2204)
* [References](#references)

## Introduction

### Description

The primary goal of **minpack-builder** is to provide an unified C API and a standard way to build-and-install binaries (*shared and/or static library in machine code*) of the double precision version of MINPACK-1 [[1]](https://www.netlib.org/minpack) - *or simply minpack*. In order to achieve this goal, we employ the powerful CMake [[2]](https://cmake.org/) build system to handle platform and compiler intricacies on different operating systems.

> [!TIP]
> 
> This project is well-suited for C/C++ programmers who want to have the old and good minpack library with a stable C API to work with, regardless of operating system and vendor-specific naming conventions applied by different Fortran compilers.

### What is minpack?

The original minpack [[1]](https://www.netlib.org/minpack) is a battle-tested **min**imization **pack**age written in Fortran 77 for solving a system of nonlinear equations and nonlinear least squares problems, discussed in details at [[3]](https://doi.org/10.2172/6997568). Throughout the years, popular scientific libraries like SciPy [[4]](https://github.com/scipy/scipy/tree/main/scipy/optimize/minpack) and Eigen [[5]](https://eigen.tuxfamily.org/dox/unsupported/index.html) have been using minpack to perform nonlinear optimization.

> [!IMPORTANT]
> 
> Do not confuse the original minpack [[1]](https://www.netlib.org/minpack) written in Fortran 77 with Modernized Minpack [[6]](https://github.com/fortran-lang/minpack). Here, we compile the original (old) minpack library directly from the source code provided by netlib. On the other hand, modern minpack [[6]](https://github.com/fortran-lang/minpack) ported the original code to newer Fortran standards. If you are a Fortran programmer, you definitely should take a look at modern minpack.

### Why minpack-builder is needed?

On a wide range of Linux operating systems [[7]](https://repology.org/project/minpack), due the widespread adoption of gfortran [[8]](https://gcc.gnu.org/wiki/GFortran) as robust and free option for a Fortran compiler, most distributions package minpack and make it available for their users through the package manager.

Recently, on Windows, through the great MSYS2 ecosystem [[9]](https://www.msys2.org/) which keeps that feeling of the Linux world, I authored with contributions [[10]](https://github.com/msys2/MINGW-packages/pull/20643) the initial integration of minpack as a package on MSYS2 [[11]](https://packages.msys2.org/base/mingw-w64-libminpack). The insertion of minpack into MSYS2 repositories allowed Windows developers to have access to native binaries, compiled either by gfortran [[8]](https://gcc.gnu.org/wiki/GFortran) or LLVM flang-new [[12]](https://flang.llvm.org/docs/), which is also a free Fortran compiler under the LLVM project umbrella.

While MSYS2 is an excellent choice for people working with GCC-like toolchains, Microsoft Visual C/C++ (MSVC) build tools [[13]](https://visualstudio.microsoft.com/visual-cpp-build-tools) are extremely popular among Windows developers. Whenever someone is looking for a Fortran compiler that integrates nicely with MSVC build tools, namely Intel® Fortran Compiler [[14]](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) and LLVM flang-new [[12]](https://flang.llvm.org/docs/), the developer will have to build minpack from the source code on its own. Moreover, Fortran compilers often export symbols with different naming conventions, leading to different C APIs if standard compiler options were applied.

### How to solve the problem?

In order to provide an unified C API for minpack, we use CMake [[2]](https://cmake.org/) as a build system to download the source code directly from the official minpack website [[1]](https://www.netlib.org/minpack). Then, we handle vendor-specific parameters of the Fortran compiler to build the library conforming to the API seen on Linux operating systems. Finally, we install it on a suitable location defined by the developer, making the minpack binaries easily discoverable as a CMake [[2]](https://cmake.org/) module or pkg-config [[15]](https://gitlab.freedesktop.org/pkg-config/pkg-config) module.

## Documentation

Browse the [documentation](doc/README.md) for build instructions, guides on various platforms with different compiler toolchains, and usage in general.

## Continuous Integration

> [!TIP]
> 
> The heavy testing of the capabilities of ```minpack-builder``` to build minpack happens on our project [https://github.com/luau-project/minpackex](https://github.com/luau-project/minpackex), which extends minpack API to allow an easier usage from C/C++. Check it out!

At the moment, the continuous integration on ```minpack-builder``` github is able to build and install minpack in the following combination of platform / compiler toolchain.

> [!NOTE]
> 
> In the tables below, *MSVC-like* means the underline linker is MSVC-compatible. Therefore, *GCC-like* means the underline linker is GCC-compatible.

### Windows 11

| Fortran Compiler | Compiler Version | Build Status |
|------------------|------------------|--------------|
| GFortran | 14.1.0 | ![gfortran-win workflow](https://github.com/luau-project/minpack-builder/actions/workflows/gfortran-on-windows.yaml/badge.svg?branch=main) |
| Intel LLVM ifx (*MSVC-like*) | 2024.1.0 | ![ifx-win workflow](https://github.com/luau-project/minpack-builder/actions/workflows/intel-fortran-on-windows.yaml/badge.svg?branch=main) |
| LLVM flang-new (*MSVC-like*) | 18.1.7 | ![llvm-flang-msvc-win workflow](https://github.com/luau-project/minpack-builder/actions/workflows/llvm-flang-msvc-like-on-windows.yaml/badge.svg?branch=main) |
| LLVM flang-new (*GCC-like*) | 18.1.6 | ![llvm-flang-gcc-win workflow](https://github.com/luau-project/minpack-builder/actions/workflows/llvm-flang-gcc-like-on-windows.yaml/badge.svg?branch=main) |

### Ubuntu 22.04

| Fortran Compiler | Compiler Version | Build Status |
|------------------|------------|--------------|
| GFortran         | 11.4.0 |![gfortran-ubuntu workflow](https://github.com/luau-project/minpack-builder/actions/workflows/gfortran-on-ubuntu.yaml/badge.svg?branch=main)|
| Intel LLVM ifx (*GCC-like*) | 2024.1.2 | ![ifx-ubuntu workflow](https://github.com/luau-project/minpack-builder/actions/workflows/intel-fortran-on-ubuntu.yaml/badge.svg?branch=main) |
| LLVM flang-new (*GCC-like*) | 18.1.6 |![llvm-flang-ubuntu workflow](https://github.com/luau-project/minpack-builder/actions/workflows/llvm-flang-on-ubuntu.yaml/badge.svg?branch=main)|

> [!IMPORTANT]
> 
> At the moment (June 2, 2024), we are aware that the current version of this project is not able to build minpack with LFortran compiler [[16]](https://lfortran.org/) paired with MSVC Build Tools on Windows (latest version present on Miniforge [[17]](https://github.com/conda-forge/miniforge), which is 0.36.0) by running
> 
> ```conda install -c conda-forge -n base -y lfortran```
> 
> We also tried LFortran using the binaries provided by MSYS2 platform, and LFortran didn't build minpack either. However, this seems to be a limitation of LFortran.

## References

1. minpack. Accessed May 2, 2024. [https://www.netlib.org/minpack](https://www.netlib.org/minpack);
2. CMake. Accessed May 2, 2024. [https://cmake.org/](https://cmake.org/);
3. Moré, Jorge J., Burton S. Garbow, and Kenneth E. Hillstrom. *User guide for MINPACK-1.[In FORTRAN]*. No. ANL-80-74. Argonne National Lab.(ANL), Argonne, IL (United States), 1980. DOI: [10.2172/6997568](https://doi.org/10.2172/6997568);
4. SciPy. Accessed May 2, 2024. [https://github.com/scipy/scipy/tree/main/scipy/optimize/minpack](https://github.com/scipy/scipy/tree/main/scipy/optimize/minpack);
5. Eigen. Accessed May 2, 2024. [https://eigen.tuxfamily.org/dox/unsupported/index.html](https://eigen.tuxfamily.org/dox/unsupported/index.html);
6. Modernized Minpack. Accessed May 3, 2024. [https://github.com/fortran-lang/minpack](https://github.com/fortran-lang/minpack);
7. minpack on repology. Accessed May 2, 2024. [https://repology.org/project/minpack](https://repology.org/project/minpack);
8. GFortran. Accessed May 2, 2024. [https://gcc.gnu.org/wiki/GFortran](https://gcc.gnu.org/wiki/GFortran);
9. MSYS2 project. Accessed May 2, 2024. [https://www.msys2.org/](https://www.msys2.org/);
10. minpack insertion on MSYS2. Accessed May 2, 2024. [https://github.com/msys2/MINGW-packages/pull/20643](https://github.com/msys2/MINGW-packages/pull/20643);
11. MSYS2 package for minpack. Accessed May 2, 2024. [https://packages.msys2.org/base/mingw-w64-libminpack](https://packages.msys2.org/base/mingw-w64-libminpack);
12. LLVM flang-new . Accessed May 2, 2024. [https://flang.llvm.org/docs/](https://flang.llvm.org/docs/);
13. Microsoft Visual C/C++ (MSVC) build tools. Accessed May 2, 2024. [https://visualstudio.microsoft.com/visual-cpp-build-tools](https://visualstudio.microsoft.com/visual-cpp-build-tools);
14. Intel® Fortran Compiler. Accessed May 2, 2024. [https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html);
15. pkg-config. Accessed May 2, 2024. [https://gitlab.freedesktop.org/pkg-config/pkg-config](https://gitlab.freedesktop.org/pkg-config/pkg-config);
16. LFortran. Accessed June 2, 2024. [https://lfortran.org/](https://lfortran.org/);
17. Miniforge. Accessed June 2, 2024. [https://github.com/conda-forge/miniforge](https://github.com/conda-forge/miniforge).