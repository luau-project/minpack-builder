# minpack-builder

## Table of Contents

* [Introduction](#introduction)
    * [Description](#description)
    * [What is minpack?](#what-is-minpack)
    * [Why minpack-builder is needed?](#why-minpack-builder-is-needed)
    * [How to solve the problem?](#how-to-solve-the-problem)
* [Supported Platforms](#supported-platforms)
* [Usage](#usage)
* [References](#references)

## Introduction

### Description

The goal of **minpack-builder** is to provide an unified C API and a standard way to build-and-install binaries (*shared and/or static library in machine code*) of the double precision version of MINPACK-1 [[1]](https://www.netlib.org/minpack) - *or simply minpack*. In order to achieve this goal, we employ the powerful CMake [[2]](https://cmake.org/) build system to handle platform and compiler intricacies on different operating systems.

### What is minpack?

The original minpack [[1]](https://www.netlib.org/minpack) is a battle-tested **min**imization **pack**age written in Fortran 77 for solving a system of nonlinear equations and nonlinear least squares problems, discussed in details at [[3]](https://doi.org/10.2172/6997568). Throughout the years, popular scientific libraries like SciPy [[4]](https://github.com/scipy/scipy/tree/main/scipy/optimize/minpack) and Eigen [[5]](https://eigen.tuxfamily.org/dox/unsupported/index.html) have been using minpack to perform nonlinear optimization, either in unmodified form or rewritten to programming languages other than Fortran.

### Why minpack-builder is needed?

On a wide range of Linux operating systems [[6]](https://repology.org/project/minpack), due the widespread adoption of gfortran [[7]](https://gcc.gnu.org/wiki/GFortran) as robust and free option for a Fortran compiler, minpack can be installed by the official package manager of the distribution. On Windows, through the great MSYS2 ecosystem [[8]](https://www.msys2.org/) which keeps that feeling of the Linux world, I authored with contributions [[9]](https://github.com/msys2/MINGW-packages/pull/20643) the initial integration of minpack as a package on MSYS2 [[10]](https://packages.msys2.org/base/mingw-w64-libminpack) to deliver Windows developers access to native binaries compiled by the free Fortran compilers gfortran [[7]](https://gcc.gnu.org/wiki/GFortran) and LLVM Flang [[11]](https://flang.llvm.org/docs/).

While MSYS2 is an excellent choice for people working with GCC-like toolchains, Microsoft Visual C/C++ (MSVC) build tools [[12]](https://visualstudio.microsoft.com/visual-cpp-build-tools) are extremely popular among Windows developers. Whenever someone is looking for a Fortran compiler (Intel® Fortran Compiler [[13]](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) and LLVM Flang [[11]](https://flang.llvm.org/docs/)) that integrates nicely with MSVC build tools, the developer will have to build minpack from the source code on its own. Moreover, Fortran compilers often export symbols with different naming conventions, leading to different C APIs if standard compiler options were applied.

### How to solve the problem?

In order to provide an unified C API for minpack, we use CMake [[2]](https://cmake.org/) as a build system to download the source code directly from the official minpack website [[1]](https://www.netlib.org/minpack). Then, we handle vendor-specific parameters of the Fortran compiler to build the library conforming to the API seen on Linux operating systems. Finally, we install it on a suitable location defined by the developer, making the minpack binaries easily discoverable as a CMake [[2]](https://cmake.org/) or pkg-config [[14]](https://gitlab.freedesktop.org/pkg-config/pkg-config) module.

## Supported Platforms

Under construction.

## Usage

Under construction.

## References

1. minpack. Accessed May 2, 2024. [https://www.netlib.org/minpack](https://www.netlib.org/minpack);
2. CMake. Accessed May 2, 2024. [https://cmake.org/](https://cmake.org/);
3. Moré, Jorge J., Burton S. Garbow, and Kenneth E. Hillstrom. *User guide for MINPACK-1.[In FORTRAN]*. No. ANL-80-74. Argonne National Lab.(ANL), Argonne, IL (United States), 1980. DOI: [10.2172/6997568](https://doi.org/10.2172/6997568);
4. SciPy. Accessed May 2, 2024. [https://github.com/scipy/scipy/tree/main/scipy/optimize/minpack](https://github.com/scipy/scipy/tree/main/scipy/optimize/minpack);
5. Eigen. Accessed May 2, 2024. [https://eigen.tuxfamily.org/dox/unsupported/index.html](https://eigen.tuxfamily.org/dox/unsupported/index.html);
6. minpack on repology. Accessed May 2, 2024. [https://repology.org/project/minpack](https://repology.org/project/minpack);
7. GFortran. Accessed May 2, 2024. [https://gcc.gnu.org/wiki/GFortran](https://gcc.gnu.org/wiki/GFortran);
8. MSYS2 project. Accessed May 2, 2024. [https://www.msys2.org/](https://www.msys2.org/);
9. minpack insertion on MSYS2. Accessed May 2, 2024. [https://github.com/msys2/MINGW-packages/pull/20643](https://github.com/msys2/MINGW-packages/pull/20643);
10. MSYS2 package for minpack. Accessed May 2, 2024. [https://packages.msys2.org/base/mingw-w64-libminpack](https://packages.msys2.org/base/mingw-w64-libminpack);
11. LLVM Flang. Accessed May 2, 2024. [https://flang.llvm.org/docs/](https://flang.llvm.org/docs/);
12. Microsoft Visual C/C++ (MSVC) build tools. Accessed May 2, 2024. [https://visualstudio.microsoft.com/visual-cpp-build-tools](https://visualstudio.microsoft.com/visual-cpp-build-tools);
13. Intel® Fortran Compiler. Accessed May 2, 2024. [https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html);
14. pkg-config. Accessed May 2, 2024. [https://gitlab.freedesktop.org/pkg-config/pkg-config](https://gitlab.freedesktop.org/pkg-config/pkg-config).