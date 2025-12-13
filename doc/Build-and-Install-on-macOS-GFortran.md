# Build and Install on macOS (GFortran)

For this tutorial, we are going to use macOS in a terminal-only fashion, compiling the library with GFortran provided by `Homebrew`.

## Table of Contents

* [Requirements](#requirements)
    * [Install the required tools](#install-the-required-tools)
* [Build and Install minpack](#build-and-install-minpack)

## Requirements

1. Have the skills needed to translate the commands contained here for your system;
2. Terminal opened;
3. Internet connection;
4. Tools:
   * gfortran from `Homebrew`;
   * git;
   * make;
   * cmake (>= 3.17).

### Install the required tools

> [!TIP]
> 
> * `git` and `make` can be installed through Developer Command Line tools;
> * `cmake` can be downloaded from [https://cmake.org/download/](https://cmake.org/download/);
> * `Homebrew` can be installed following the instructions at [https://brew.sh/](https://brew.sh/)
> * After `Homebrew` was installed and configured correctly, install GFortran through the `gcc` package:
>     ```bash
>     brew install gcc
>     ```

Check that everything went fine. You should have all these tools installed, and the following commands should suceed:

```bash
gfortran --version
git --version
make --version
cmake --version
```

The result on terminal should be more or less like this:

<img width="937" height="650" alt="01-install-tools" src="https://github.com/user-attachments/assets/cef44b87-caa7-4189-ba29-7bc8e63e95a7" />

## Build and Install minpack

1. Change directory to ```/tmp``` and create a working directory named ```working_dir```
    ```bash
    cd /tmp
    mkdir working_dir
    cd working_dir/
    ```

    <img width="937" height="650" alt="02-build-install-step-1" src="https://github.com/user-attachments/assets/c6253d80-dd4c-4f85-a6ef-971ce452a41d" />

2. Clone minpack-builder by running

    ```bash
    git clone https://github.com/luau-project/minpack-builder
    ```

3. Set shell variables for the build and install directories, and another one (`FC`) to hold the path to GFortran
    ```bash
    BUILD_DIR=$PWD/build
    INSTALL_DIR=$PWD/local-install
    FC=$(brew --prefix gcc)/bin/gfortran
    ```
> [!NOTE]
> 
> We are going for a local installation at ```/tmp/working_dir/local-install```, building the package at ```/tmp/working_dir/build```.

4. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake "-DCMAKE_Fortran_COMPILER=$FC" --install-prefix $INSTALL_DIR -S minpack-builder -B $BUILD_DIR
    ```

    <img width="937" height="650" alt="03-build-install-step-2-to-4" src="https://github.com/user-attachments/assets/269ee4a4-7628-4d67-a591-3c0a67bb2099" />

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

5. Review the configuration summary and proceed to build

    <img width="937" height="650" alt="04-build-install-step-5" src="https://github.com/user-attachments/assets/ba0238dc-5e07-4590-8d95-c926b1a533b1" />

6. Build the library. 

    ```
    cmake --build $BUILD_DIR
    ```

    <img width="937" height="650" alt="05-build-install-step-6" src="https://github.com/user-attachments/assets/8130f2ef-324c-4cbd-a63f-cdfe88d180ce" />

> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.

7. Install the library

    ```
    cmake --install $BUILD_DIR
    ```

    <img width="937" height="650" alt="06-build-install-step-7" src="https://github.com/user-attachments/assets/01e0d4f3-3ad4-4d2f-8a02-d8f87f9be64c" />

---
[Documentation](README.md)
