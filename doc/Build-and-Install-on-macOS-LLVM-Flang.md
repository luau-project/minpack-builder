# Build and Install on macOS (LLVM flang)

For this tutorial, we are going to use macOS in a terminal-only fashion, compiling the library with LLVM flang provided the by `Homebrew`.

## Table of Contents

* [Requirements](#requirements)
    * [Install the required tools](#install-the-required-tools)
* [Build and Install minpack](#build-and-install-minpack)

## Requirements

1. Have the skills needed to translate the commands contained here for your system;
2. Terminal opened;
3. Internet connection;
4. Tools:
   * flang from `Homebrew`;
   * git;
   * make;
   * cmake (>= 3.17).

### Install the required tools

> [!TIP]
> 
> * `git` and `make` can be installed through Developer Command Line tools;
> * `cmake` can be downloaded from [https://cmake.org/download/](https://cmake.org/download/);
> * `Homebrew` can be installed following the instructions at [https://brew.sh/](https://brew.sh/)
> * After `Homebrew` was installed and configured correctly, install LLVM flang through the `flang` package:
>     ```bash
>     brew install flang
>     ```

Check that everything went fine. You should have all these tools installed, and the following commands should suceed:

```bash
flang --version
git --version
make --version
cmake --version
```

The result on terminal should be more or less like this:

<img width="1297" height="902" alt="01-install-tools" src="https://github.com/user-attachments/assets/55ef120b-1a64-4504-9293-d596b766df02" />

## Build and Install minpack

1. Change directory to ```/tmp``` and create a working directory named ```working_dir```
    ```bash
    cd /tmp
    mkdir working_dir
    cd working_dir
    ```

    <img width="1297" height="902" alt="02-build-install-step-1" src="https://github.com/user-attachments/assets/70bd8ce6-c733-45df-9231-0c8815e0d386" />

2. Clone minpack-builder by running

    ```bash
    git clone https://github.com/luau-project/minpack-builder
    ```

3. Set shell variables for the build and install directories, and another one (`FC`) to hold the path to LLVM flang
    ```bash
    BUILD_DIR=$PWD/build
    INSTALL_DIR=$PWD/local-install
    FC=$(brew --prefix flang)/bin/flang
    ```
> [!NOTE]
> 
> We are going for a local installation at ```/tmp/working_dir/local-install```, building the package at ```/tmp/working_dir/build```.

4. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake "-DCMAKE_Fortran_COMPILER=$FC" --install-prefix $INSTALL_DIR -S minpack-builder -B $BUILD_DIR
    ```

    <img width="1297" height="902" alt="03-build-install-step-2-to-4" src="https://github.com/user-attachments/assets/c23475a9-55c4-4dad-909e-86905c0f6584" />

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

5. Review the configuration summary and proceed to build

    <img width="1297" height="902" alt="04-build-install-step-5" src="https://github.com/user-attachments/assets/966dd2e6-7aa2-417e-aede-85e94e379fb2" />

6. Build the library. 

    ```
    cmake --build $BUILD_DIR
    ```

    <img width="1297" height="902" alt="05-build-install-step-6" src="https://github.com/user-attachments/assets/3099e00d-0b8a-431a-a19d-e8e42f0a36b0" />

> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.

7. Install the library

    ```
    cmake --install $BUILD_DIR
    ```

    <img width="1297" height="902" alt="06-build-install-step-7" src="https://github.com/user-attachments/assets/02dc424d-5383-4b11-bb68-dd0613667801" />

---
[Documentation](README.md)
