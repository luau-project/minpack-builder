# Project-specific targets

In this section, you find all the custom targets made available by ```minpackex```.

## Table of Contents

* [Behavioral targets](#behavioral-targets)
* [Binary packaging targets](#binary-packaging-targets)
* [Source packaging targets](#source-packaging-targets)

## Behavioral targets

* [uninstall](#uninstall)

### uninstall

* Description: Removes all the installed files.
* Note: Only works if the user has installed with minpack-builder, but didn't delete the build directory or related files.
* Usage: Assume that user configured, built and installed minpack with the following commands (i, ii, iii). If the build directory was not deleted, reconfigured or cleaned, the user is able to uninstall at step (iv):
    1. Configure
        ```bash
        cmake -DCMAKE_BUILD_TYPE=Release --install-prefix <path-to-install> -S minpack-builder -B build-dir
        ```
    2. Build
        ```bash
        cmake --build build-dir --config Release
        ```
    3. Install
        ```bash
        cmake --install build-dir --config Release
        ```
    4. Then, if the directory ```build-dir``` is still available and was not reconfigured or cleaned, it is possible to uninstall
        ```bash
        cmake --build build-dir --config Release --target uninstall
        ```

## Binary packaging targets

> [!TIP]
> 
> The configuration option ```BINARY_ARCHIVE_SUFFIX``` places a suffix in the binary archive. Read [BINARY_ARCHIVE_SUFFIX](Configuration-Options.md#BINARY_ARCHIVE_SUFFIX) for more information.

* [binary-zip](#binary-zip)
* [binary-tar-gz](#binary-tar-gz)
* [binary-tar-bz2](#binary-tar-bz2)
* [binary-tar-xz](#binary-tar-xz)

### binary-zip

* Description: Packages the built artifacts as a zip (.zip) file.
* Note: Must be run after a ```cmake --install <build-dir>``` command.

### binary-tar-gz

* Description: Packages the built artifacts as a .tar.gz file.
* Note: Must be run after a ```cmake --install <build-dir>``` command.

### binary-tar-bz2

* Description: Packages the built artifacts as a .tar.bz2 file.
* Note: Must be run after a ```cmake --install <build-dir>``` command.

### binary-tar-xz

* Description: Packages the built artifacts as a .tar.xz file.
* Note: Must be run after a ```cmake --install <build-dir>``` command.

## Source packaging targets

> [!TIP]
> 
> The configuration option ```SOURCE_ARCHIVE_SUFFIX``` places a suffix in the source archive. Read [SOURCE_ARCHIVE_SUFFIX](Configuration-Options.md#SOURCE_ARCHIVE_SUFFIX) for more information.

* [source-zip](#source-zip)
* [source-tar-gz](#source-tar-gz)
* [source-tar-bz2](#source-tar-bz2)
* [source-tar-xz](#source-tar-xz)

### source-zip

* Description: Packages the relevant source code in the source tree as a zip (.zip) file.
* Note: Must be run after a cmake configure command. DO NOT choose a build directory equal to the source tree, or inside the source tree. Also, DO NOT choose a install directory inside the source tree.

### source-tar-gz

* Description: Packages the relevant source code in the source tree as a .tar.gz file.
* Note: Must be run after a cmake configure command. DO NOT choose a build directory equal to the source tree, or inside the source tree. Also, DO NOT choose a install directory inside the source tree.

### source-tar-bz2

* Description: Packages the relevant source code in the source tree as a .tar.bz2 file.
* Note: Must be run after a cmake configure command. DO NOT choose a build directory equal to the source tree, or inside the source tree. Also, DO NOT choose a install directory inside the source tree.

### source-tar-xz

* Description: Packages the relevant source code in the source tree as a .tar.xz file.
* Note: Must be run after a cmake configure command. DO NOT choose a build directory equal to the source tree, or inside the source tree. Also, DO NOT choose a install directory inside the source tree.

---
[Documentation](README.md)