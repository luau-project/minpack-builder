# Build and Install on Linux (Intel Fortran Compiler - ifx)

For this tutorial, we are going to use Debian 12 stable in a terminal-only fashion, compiling the library with Intel Fortran Compiler (ifx) provided by Intel through the package manager.

> [!IMPORTANT]
> 
> In the end of this guide, you will have a working ```minpack``` shared library (libminpack.so) installed on your computer, and this final ```libminpack.so``` depends on Intel Fortran Compiler Runtime for Linux. In order to use ```libminpack.so``` built here in a standalone manner with Intel Fortran Compiler (ifx), or redistribute to end users, you have to install Intel Fortran Compiler Runtime for Linux [https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2023-0/list-available-toolkits-components-and-runtime.html#LIST-RUNTIME](https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2023-0/list-available-toolkits-components-and-runtime.html#LIST-RUNTIME) depending on the ifx version you have installed (2024.1 for this guide), or guide your end users to install it. In the future, since most likely these links will change and become obsolete, look for Intel Fortran Compiler Runtime for Linux.

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
   * ifx (latest version provided by Intel apt repositories);
   * git;
   * make;
   * cmake (>= 3.17).

### Pre-installation steps

> [!TIP]
>
> If you already have Intel Fortran Compiler (ifx) installed, you can skip this section.

> [!NOTE]
> 
> The guide presented here follows Intel instructions for Debian-based 64-bit distributions, which at the time of writing, you can find at [https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/apt.html](https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/apt.html). If you are running a 32-bit distribution, replace ```intel-basekit``` for ```intel-basekit-32bit```, and ```intel-hpckit``` for ```intel-hpckit-32bit``` everywhere in this guide.
> 
> For RedHad-based distributions, take a look at [https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/yum-dnf-zypper.html](https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2024-1/yum-dnf-zypper.html).

1. First, make sure to have gpg installed. So, install it:

    ```bash
    sudo apt install -y gpg
    ```

2. Confirm that gpg was installed properly:

    ```bash
    gpg --version
    ```

3. If gpg was installed, the last lines ouf the command above should be more or less like this

    ![Screenshot from 2024-05-04 11-36-10](https://github.com/luau-project/minpack-builder/assets/18295115/6e2b5ceb-77e1-42dc-9f41-a88c9342d73e)

4. Download Intel's key to system keyring

    ```bash
    wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
    ```

5. Add signed entry to apt sources and configure the APT client to use Intel repository 

    ```bash
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
    ```
    
    ![Screenshot from 2024-05-04 11-47-36](https://github.com/luau-project/minpack-builder/assets/18295115/81634d13-7b78-4568-87a2-cce8e49399ae)

6. Update packages list and repository index

    ```bash
    sudo apt update
    ```

### Install the required tools

> [!TIP]
> 
> Install them all at once running the following command in the terminal:
> ```bash
> sudo apt install -y intel-basekit intel-hpckit git make cmake
> ```

> [!IMPORTANT]
> 
> After the installation has finished, you have to source intel shell variables in order to have access to ```ifx```, otherwise the system will not be able to find ```ifx```.
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

![Screenshot from 2024-05-04 12-37-35](https://github.com/luau-project/minpack-builder/assets/18295115/29ec35bb-333a-4634-ac9c-888bf9e74809)


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

3. Clone minpack-builder by running

    ```bash
    git clone https://github.com/luau-project/minpack-builder
    ```

    ![Screenshot from 2024-05-04 12-43-51](https://github.com/luau-project/minpack-builder/assets/18295115/c2bafde5-9fab-49e6-bb38-85996a91a3bf)

4. By default, minpack-builder downloads (optional param ```USE_DOWNLOAD``` is ```ON```) minpack source code to the same directory of minpack-builder (provided by optional param ```DOWNLOAD_DIR```).

    ```
    cmake -DCMAKE_Fortran_COMPILER=ifx --install-prefix $INSTALL_DIR -S minpack-builder -B $BUILD_DIR
    ```

> [!NOTE]
> 
> If the optional param ```CMAKE_BUILD_TYPE``` is not specified, a Release build is configured.

5. Review the configuration summary and proceed to build

    ![Screenshot from 2024-05-04 12-44-56](https://github.com/luau-project/minpack-builder/assets/18295115/5602010d-ba63-4e0a-a32c-14d0812e5695)

6. Build the library. 

    ```
    cmake --build $BUILD_DIR
    ```

    ![Screenshot from 2024-05-04 12-45-28](https://github.com/luau-project/minpack-builder/assets/18295115/88152fd4-fc28-41ca-8a5f-7aed67128b12)


> [!NOTE]
> 
> By default, only the shared library is built. You can build the static library by feeding ```-DBUILD_STATIC_LIBS=ON``` in the configuration step.

7. Install the library

    ```
    cmake --install $BUILD_DIR
    ```

    ![Screenshot from 2024-05-04 12-46-02](https://github.com/luau-project/minpack-builder/assets/18295115/e9591e67-ed59-4295-81b3-fceb50d46c04)

---
[Documentation](README.md)
