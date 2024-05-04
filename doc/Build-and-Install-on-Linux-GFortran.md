# Build and Install on Linux (GFortran)

For this tutorial, we are going to use Debian 12 stable in a terminal-only fashion, compiling the library with GFortran provided the by package manager.

## Table of Contents

* [Requirements](#requirements)
    * [Install the required tools](#install-the-required-tools)
* [Build and Install minpack](#build-and-install-minpack)

## Requirements

1. Have the skills needed to translate the commands contained here for non-Debian distributions, if it applies;
2. Terminal opened;
3. Internet connection;
4. Tools:
   * gfortran;
   * git;
   * make;
   * cmake (>= 3.17).

### Install the required tools

> [!TIP]
> 
> Install them all at once running the following command in the terminal:
> ```bash
> sudo apt install -f -y gfortran git make cmake
> ```

Check that everything went fine. You should have all these tools installed, and the following commands should suceed:

```bash
gfortran --version
git --version
make --version
cmake --version
```

The result on terminal should be more or less like this:

![Screenshot from 2024-05-03 15-06-07](https://github.com/luau-project/minpack-builder/assets/18295115/701c8d97-a2d6-4f6b-a464-0dc8c6ae2328)

## Build and Install minpack

1. Change directory to ```/tmp``` and create a working directory named ```working_dir```
    ```bash
    cd /tmp
    mkdir working_dir
    cd working_dir
    ```
2. Set shell variables for the build and install directories
    ```bash
    BUILD_DIR=$PWD/build
    INSTALL_DIR=$PWD/local-install
    ```
> [!NOTE]
> 
> We are going for a local installation at ```/tmp/working_dir/local-install```, building the package at ```/tmp/working_dir/build```.

3. Clone minpack-builder by running ```git clone https://github.com/luau-project/minpack-builder```

    ![Screenshot from 2024-05-03 15-34-52](https://github.com/luau-project/minpack-builder/assets/18295115/0a24bfac-b4df-48cb-932b-8ff1cfe01bfe)

4. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake --install-prefix $INSTALL_DIR -S minpack-builder -B $BUILD_DIR
    ```

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

5. Review the configuration summary and proceed to build

    ![Screenshot from 2024-05-03 15-45-32](https://github.com/luau-project/minpack-builder/assets/18295115/f8d4054b-0c04-483b-8245-32b116c58acd)

6. Build the library. 

    ```
    cmake --build $BUILD_DIR
    ```

    ![Screenshot from 2024-05-03 15-49-34](https://github.com/luau-project/minpack-builder/assets/18295115/1ba94573-5582-4d76-9f65-435a1963d8f6)

> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.

7. Install the library

    ```
    cmake --install $BUILD_DIR
    ```

    ![Screenshot from 2024-05-03 15-52-36](https://github.com/luau-project/minpack-builder/assets/18295115/84130dec-f122-4594-a8d1-25100bbaff49)

---
[Documentation](Home.md)