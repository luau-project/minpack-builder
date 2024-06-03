# Project-specific Targets

In this section, you find all the custom targets made available by ```minpackex```.

## Targets

* [uninstall](#uninstall)

## uninstall

* Description: Removes all the installed files.
* Note: Only works if the user has installed with minpack-builder, but didn't delete the build directory or related files.
* Usage: Assume that user configured, built and installed minpack with the following commands (1, 2, 3). If the build directory was not deleted, reconfigured or cleaned, the user is able to uninstall at step (4):
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