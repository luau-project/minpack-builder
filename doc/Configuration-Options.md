# Configuration Options

> [!TIP]
> 
> Each parameter below can be set by adding ```"-D<PARAMETER>=<VALUE>"``` in the command line.
> 
> For instance, ```cmake "-DCMAKE_BUILD_TYPE=Debug" <PARAMETER LIST> ``` would configure a debug build.

## Parameters
* [CMAKE_BUILD_TYPE](#CMAKE_BUILD_TYPE)
* [BUILD_SHARED_LIBS](#BUILD_SHARED_LIBS)
* [BUILD_STATIC_LIBS](#BUILD_STATIC_LIBS)
* [MINPACK_VERSION](#MINPACK_VERSION)
* [USE_DOWNLOAD](#USE_DOWNLOAD)
* [DOWNLOAD_DIR](#DOWNLOAD_DIR)
* [MINPACK_INSTALL_BINDIR](#MINPACK_INSTALL_BINDIR)
* [MINPACK_INSTALL_LIBDIR](#MINPACK_INSTALL_LIBDIR)
* [MINPACK_INSTALL_INCLUDEDIR](#MINPACK_INSTALL_INCLUDEDIR)
* [MINPACK_INSTALL_DOCDIR](#MINPACK_INSTALL_DOCDIR)
* [MINPACK_INSTALL_PKGCONFIGDIR](#MINPACK_INSTALL_PKGCONFIGDIR)

## CMAKE_BUILD_TYPE

* Parameter: CMAKE_BUILD_TYPE
* Description: The build type.
* Type: STRING
* Default value: Release
* Note: Common values are Debug, Release, RelWithDebInfo and MinSizeRel.

## BUILD_SHARED_LIBS

* Parameter: BUILD_SHARED_LIBS
* Description: Builds the shared library.
* Type: BOOL
* Default value: ON
* Note: If this value is OFF, then BUILD_STATIC_LIBS must be set ON.

## BUILD_STATIC_LIBS

* Parameter: BUILD_STATIC_LIBS
* Description: Builds the static library.
* Type: BOOL
* Default value: OFF
* Note: If this value is OFF, then BUILD_SHARED_LIBS must be set ON.

## MINPACK_VERSION

* Parameter: MINPACK_VERSION
* Description: The version of this build script.
* Type: STRING
* Default value: 1.1.0
* Note: Since it is unlikely to face any change in the source code of minpack, this value makes sense to be interpreted as this build script's version.

## USE_DOWNLOAD

* Parameter: USE_DOWNLOAD
* Description: Allows official files to be downloaded from [https://www.netlib.org/minpack](https://www.netlib.org/minpack) to do the build.
* Type: BOOL
* Default value: ON
* Note: If this option is left OFF, ${CMAKE_CURRENT_SOURCE_DIR} is assumed to be the location of minpack source files and copyright.

## DOWNLOAD_DIR

* Parameter: DOWNLOAD_DIR
* Description: Destination directory to store files downloaded from [https://www.netlib.org/minpack](https://www.netlib.org/minpack).
* Type: PATH
* Default value: ${CMAKE_CURRENT_SOURCE_DIR}
* Note: This value only makes sense if USE_DOWNLOAD is set ON.

## MINPACK_INSTALL_BINDIR

* Parameter: MINPACK_INSTALL_BINDIR
* Description: Installation directory for executables (.dll files on Windows).
* Type: PATH
* Default value: ${CMAKE_INSTALL_BINDIR}
* Note: This value must be a relative path to ${CMAKE_INSTALL_PREFIX}.

## MINPACK_INSTALL_LIBDIR

* Parameter: MINPACK_INSTALL_LIBDIR
* Description: Installation directory for libraries.
* Type: PATH
* Default value: ${CMAKE_INSTALL_LIBDIR}
* Note: This value must be a relative path to ${CMAKE_INSTALL_PREFIX}.

## MINPACK_INSTALL_INCLUDEDIR

* Parameter: MINPACK_INSTALL_INCLUDEDIR
* Description: Installation directory for header files.
* Type: PATH
* Default value: ${CMAKE_INSTALL_INCLUDEDIR}
* Note: This value must be a relative path to ${CMAKE_INSTALL_PREFIX}.

## MINPACK_INSTALL_DOCDIR

* Parameter: MINPACK_INSTALL_DOCDIR
* Description: Installation directory for documentation.
* Type: PATH
* Default value: ${CMAKE_INSTALL_DOCDIR}
* Note: This value must be a relative path to ${CMAKE_INSTALL_PREFIX}.

## MINPACK_INSTALL_PKGCONFIGDIR

* Parameter: MINPACK_INSTALL_PKGCONFIGDIR
* Description: Installation directory for pkg-config (.pc) files.
* Type: PATH
* Default value: ${MINPACK_INSTALL_LIBDIR}/pkgconfig
* Note: This value must be a relative path to ${CMAKE_INSTALL_PREFIX}.

---
[Documentation](Home.md)