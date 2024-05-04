# Build and Install on Linux (Intel Fortran Compiler - ifx)

For this tutorial, we are going to use Debian 12 stable in a terminal-only fashion, compiling the library with Intel Fortran Compiler (ifx) provided by Intel through the package manager.

## Table of Contents

* [Requirements](#requirements)
    * [Pre-installation steps](#pre-installation-steps)
    * [Install the required tools](#install-the-required-tools)
* [Build and Install minpack](#build-and-install-minpack)

## Requirements

1. Have the skills needed to translate the commands contained here for non-Debian distributions, if it applies;
2. Terminal opened;
3. Internet connection;
4. Tools:
   * ifx (latest version from Intel apt repositories);
   * git;
   * make;
   * cmake (>= 3.17).

### Pre-installation steps

> [!NOTE]
> 
> The guide presented here follows Intel instructions for Debian-based 64-bit distributions, which at the time of writing, you can find at [https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/apt.html](https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/apt.html). If you are running a 32-bit distribution, replace ```intel-basekit``` for ```intel-basekit-32bit```, and ```intel-hpckit``` for ```intel-hpckit-32bit``` everywhere in this guide.
> 
> For RedHad-based distributions, take a look at [https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/yum-dnf-zypper.html](https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/yum-dnf-zypper.html).

1. First, make sure to have gpg installed. So, install it:

    ```bash
    sudo apt install -f -y gpg
    ```

2. Confirm that gpg was installed properly:

    ```bash
    gpg --version
    ```

3. If gpg was installed, the last lines ouf the command above should be more or less like this

<!-- image here -->

### Install the required tools

> [!TIP]
> 
> Install them all at once running the following command in the terminal:
> ```bash
> sudo apt install -f -y intel-basekit intel-hpckit git make cmake
> ```

> [!IMPORTANT]
> 
> After the installation has finished, you have to source intel shell variables in order to have access to ```ifx```, otherwise the ```ifx``` will not be found.
> 
> ```bash
> source /opt/intel/oneapi/setvars.sh
> ```

Check that everything went fine. You should have all these tools installed, and the following commands should suceed:

```bash
ifx --version
git --version
make --version
cmake --version
```

The result on terminal should be more or less like this:

<!-- image here -->

## Build and Install minpack

1. Change directory to ```/tmp``` and create a working directory named ```ifx_working_dir```
    ```bash
    cd /tmp
    mkdir ifx_working_dir
    cd ifx_working_dir
    ```
2. Set shell variables for the build and install directories
    ```bash
    BUILD_DIR=$PWD/build-ifx
    INSTALL_DIR=$PWD/local-install-ifx
    ```
> [!NOTE]
> 
> We are going for a local installation at ```/tmp/ifx_working_dir/local-install-ifx```, building the package at ```/tmp/ifx_working_dir/build-ifx```.

3. Clone minpack-builder by running ```git clone https://github.com/luau-project/minpack-builder```

<!-- image here -->

4. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake -DCMAKE_Fortran_COMPILER=ifx --install-prefix $INSTALL_DIR -S minpack-builder -B $BUILD_DIR
    ```

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

5. Review the configuration summary and proceed to build

<!-- image here -->

6. Build the library. 

    ```
    cmake --build $BUILD_DIR
    ```

<!-- image here -->

> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.

7. Install the library

    ```
    cmake --install $BUILD_DIR
    ```

<!-- image here -->

---
[Documentation](README.md)