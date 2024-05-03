#                                                                             #
#                                                                             #
###############################################################################
# License                                                                     #
###############################################################################
#                                                                             #
# Copyright (c) 2024 luau-project                                             #
#                    https://github.com/luau-project/minpack-builder          #
#                                                                             #
# Redistribution and use in source and binary forms, with or without          #
# modification, are permitted provided that the following conditions are met: #
#                                                                             #
# 1. Redistributions of source code must retain the above copyright notice,   #
# this list of conditions and the following disclaimer.                       #
#                                                                             #
# 2. Redistributions in binary form must reproduce the above copyright        #
# notice, this list of conditions and the following disclaimer in the         #
# documentation and/or other materials provided with the distribution.        #
#                                                                             #
# 3. Neither the name of the copyright holder nor the names of its            #
# contributors may be used to endorse or promote products derived from this   #
# software without specific prior written permission.                         #
#                                                                             #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” #
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,       #
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR      #
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR           #
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,       #
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,         #
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; #
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,    #
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR     #
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF      #
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                                  #
#                                                                             #
###############################################################################
# Start(Description of parameters)                                            #
###############################################################################
#                                                                             #
#                                                                             #
###############################################################################
# Standard CMake parameters:                                                  #
###############################################################################
#                                                                             #
#     CMAKE_BUILD_TYPE (type: string, default value: Release)                 #
#         Description: the build type.                                        #
#                                                                             #
#     BUILD_SHARED_LIBS (type: BOOL, default value: ON)                       #
#         Description: builds the shared library.                             #
#         Note: If this value is OFF,                                         #
#             BUILD_STATIC_LIBS must be set ON.                               #
#                                                                             #
#     BUILD_STATIC_LIBS (type: BOOL, default value: OFF)                      #
#         Description: builds the static library.                             #
#         Note: If this value is OFF,                                         #
#             BUILD_SHARED_LIBS must be set ON.                               #
#                                                                             #
###############################################################################
# Project-specific parameters:                                                #
###############################################################################
#                                                                             #
#     MINPACK_VERSION (type: string)                                          #
#         Description: Since it is unlikely to face any change                #
#             in the source code of minpack, this value                       #
#             makes sense to be interpreted as this build                     #
#             script's version.                                               #
#         Note: The value must be in the format X.Y.Z,                        #
#             such that X means the Major, Y means Minor,                     #
#             and Z the Patch version.                                        #
#                                                                             #
#     USE_DOWNLOAD (type: BOOL, default value: ON)                            #
#         Description: Allows official files to be                            #
#             downloaded from ${minpack_url}                                  #
#             to do the build. If this option is left OFF,                    #
#             ${CMAKE_CURRENT_SOURCE_DIR} is assumed to be                    #
#             the location of minpack source files and copyright.             #
#         Note: requires internet connection.                                 #
#                                                                             #
#     DOWNLOAD_DIR (type: PATH, default value: ${CMAKE_CURRENT_SOURCE_DIR})   #
#         Description: Destination directory to                               #
#             store files downloaded from ${minpack_url}.                     #
#         Note: This value only makes sense                                   #
#             if USE_DOWNLOAD is ON.                                          #
#                                                                             #
#     MINPACK_INSTALL_BINDIR (type: PATH, default value:                      #
#                             ${CMAKE_INSTALL_BINDIR})                        #
#         Description: Installation directory for executables.                #
#         Note: Must be a relative path to ${CMAKE_INSTALL_PREFIX}.           #
#                                                                             #
#     MINPACK_INSTALL_LIBDIR (type: PATH, default value:                      #
#                             ${CMAKE_INSTALL_LIBDIR})                        #
#         Description: Installation directory for libraries.                  #
#         Note: Must be a relative path to ${CMAKE_INSTALL_PREFIX}.           #
#                                                                             #
#     MINPACK_INSTALL_INCLUDEDIR (type: PATH, default value:                  #
#                                 ${CMAKE_INSTALL_INCLUDEDIR})                #
#         Description: Installation directory for header files.               #
#         Note: Must be a relative path to ${CMAKE_INSTALL_PREFIX}.           #
#                                                                             #
#     MINPACK_INSTALL_DOCDIR (type: PATH, default value:                      #
#                             ${CMAKE_INSTALL_DOCDIR})                        #
#         Description: Installation directory for documentation.              #
#         Note: Must be a relative path to ${CMAKE_INSTALL_PREFIX}.           #
#                                                                             #
#     MINPACK_INSTALL_PKGCONFIG_DIR (type: PATH, default value:               #
#                                    ${MINPACK_INSTALL_LIBDIR}/pkgconfig)     #
#         Description: Installation directory for pkg-config (.pc) files.     #
#         Note: Must be a relative path to ${CMAKE_INSTALL_PREFIX}.           #
#                                                                             #
###############################################################################
# End(Description of parameters)                                              #
###############################################################################
#                                                                             #
#                                                                             #
###############################################################################
###############################################################################
##                                 Body                                      ##
###############################################################################
###############################################################################
#                                                                             #
#                                                                             #

cmake_minimum_required(VERSION 3.17)

set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type.")
option(BUILD_SHARED_LIBS "Build the shared library." ON)
option(BUILD_STATIC_LIBS "Build the static library." OFF)
option(USE_DOWNLOAD "Download source code." ON)
set(DOWNLOAD_DIR "${CMAKE_CURRENT_SOURCE_DIR}" CACHE PATH "Destination directory to store downloaded files.")

# official minpack url
set(minpack_url "https://www.netlib.org/minpack")

# library name
set(minpack_library_name "minpack")

# at least one kind of library must be built
if (NOT (BUILD_SHARED_LIBS OR BUILD_STATIC_LIBS))
    message(FATAL_ERROR "You must build either the shared or static library by settting `-DBUILD_SHARED_LIBS=ON` or `-DBUILD_STATIC_LIBS=ON`")
endif()

# set the package version
if (NOT DEFINED MINPACK_VERSION)
    set(MINPACK_VERSION "1.1.0")
endif()

if (NOT ("${MINPACK_VERSION}" MATCHES "^([0-9]+)\\.([0-9]+)\\.([0-9]+)$"))
    message(FATAL_ERROR "Invalid version format. A version formatted as X.Y.Z is expected.")
endif()

# major version
set(MINPACK_VERSION_MAJOR ${CMAKE_MATCH_1})

# minor version
set(MINPACK_VERSION_MINOR ${CMAKE_MATCH_2})

# patch version
set(MINPACK_VERSION_PATCH ${CMAKE_MATCH_3})

# project details
project(minpack
    VERSION "${MINPACK_VERSION}"
    LANGUAGES Fortran
)

# use GNU directories convention
include(GNUInstallDirs)

if (NOT DEFINED MINPACK_INSTALL_BINDIR)
    # Installation directory for binaries.
    set(MINPACK_INSTALL_BINDIR ${CMAKE_INSTALL_BINDIR})
endif()

if (NOT DEFINED MINPACK_INSTALL_LIBDIR)
    # Installation directory for libraries.
    set(MINPACK_INSTALL_LIBDIR ${CMAKE_INSTALL_LIBDIR})
endif()

if (NOT DEFINED MINPACK_INSTALL_INCLUDEDIR)
    # Installation directory for header files.
    set(MINPACK_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_INCLUDEDIR})
endif()

if (NOT DEFINED MINPACK_INSTALL_DOCDIR)
    # "Installation directory for documentation.
    set(MINPACK_INSTALL_DOCDIR ${CMAKE_INSTALL_DOCDIR})
endif()

if (NOT DEFINED MINPACK_INSTALL_PKGCONFIG_DIR)
    # Installation directory for pkg-config file.
    set(MINPACK_INSTALL_PKGCONFIG_DIR "${MINPACK_INSTALL_LIBDIR}/pkgconfig")
endif()

if (IS_ABSOLUTE "${MINPACK_INSTALL_BINDIR}")
    message(FATAL_ERROR "MINPACK_INSTALL_BINDIR must be a relative path.")
endif()

if (IS_ABSOLUTE "${MINPACK_INSTALL_LIBDIR}")
    message(FATAL_ERROR "MINPACK_INSTALL_LIBDIR must be a relative path.")
endif()

if (IS_ABSOLUTE "${MINPACK_INSTALL_INCLUDEDIR}")
    message(FATAL_ERROR "MINPACK_INSTALL_INCLUDEDIR must be a relative path.")
endif()

if (IS_ABSOLUTE "${MINPACK_INSTALL_DOCDIR}")
    message(FATAL_ERROR "MINPACK_INSTALL_DOCDIR must be a relative path.")
endif()

if (IS_ABSOLUTE "${MINPACK_INSTALL_PKGCONFIG_DIR}")
    message(FATAL_ERROR "MINPACK_INSTALL_PKGCONFIG_DIR must be a relative path.")
endif()

include("cmake/MinpackSources.cmake")

if (USE_DOWNLOAD)

    include("cmake/DownloadMinpackSources.cmake")
    
    download_minpack_sources(
        # Destination directory
        "${DOWNLOAD_DIR}"

        # Fortran source files for minpack
        minpack_source_files
        
        # Copyright for minpack
        minpack_copyright
    )

else()
    get_minpack_sources(
        # Fortran source basenames for minpack
        minpack_source_basenames

        # sha256 sums for each source Fortran file
        minpack_sha256_sums_for_source_files

        # basename copyright for minpack
        minpack_copyright_basename

        # sha256 sum for copyright
        minpack_sha256_sum_for_copyright
    )

    # we deliberately do NOT check
    # whether sha256sum match for each file, because
    # in the future we might potentially patch
    # function identifiers on
    # Fortran source files (*.f),
    # in order to keep a stable API as is
    # defined in the header file minpack.h
    
    set(minpack_source_files ${minpack_source_basenames})
    set(minpack_copyright ${minpack_copyright_basename})
endif()

if (WIN32)
    if ("${CMAKE_Fortran_SIMULATE_ID}" MATCHES "MSVC")
        # .def file for MSVC-like shared library
        set(minpack_def_file "${minpack_library_name}.def")
    else()
        # .def file for GNU-like shared library
        set(minpack_def_file "lib${minpack_library_name}.def")
    endif()
endif()

# minpack header file
set(minpack_header "${minpack_library_name}.h")

# minpack config cmake file to be transformed
set(minpack_config_cmake_in "cmake/${minpack_library_name}-config.cmake.in")

# minpack config cmake destination file
set(minpack_config_cmake "${CMAKE_CURRENT_BINARY_DIR}/${minpack_library_name}-config.cmake")

# minpack config version cmake file to be transformed
set(minpack_config_version_cmake_in "cmake/${minpack_library_name}-config-version.cmake.in")

# minpack config version cmake destination file
set(minpack_config_version_cmake "${CMAKE_CURRENT_BINARY_DIR}/${minpack_library_name}-config-version.cmake")

# minpack pkg-config input file to be transformed
set(minpack_pkg_config_in "cmake/${minpack_library_name}.pc.in")

# minpack pkg-config destination file
set(minpack_pkg_config "${CMAKE_CURRENT_BINARY_DIR}/${minpack_library_name}.pc")

# minpack targets destination file
set(minpack_targets_export "${minpack_library_name}-targets")

# additional vendor-specific Fortran flags
set(minpack_Fflags "")

set(minpack_intel_specific_Fflags_for_Win "/assume:underscore" "/names:lowercase")
set(minpack_intel_specific_Fflags_for_Unix "-assume" "underscore" "-names" "lowercase")

# hold targets to install
set(targets_to_install "")

# Build the shared library
if (BUILD_SHARED_LIBS)
    add_library(minpack_SHARED SHARED "")
    target_sources(minpack_SHARED PRIVATE ${minpack_source_files})
    
    get_filename_component(Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)
    
    if ("${Fortran_COMPILER_NAME}" MATCHES "ifx|ifort")
        if (WIN32)
            target_sources(minpack_SHARED PRIVATE ${minpack_def_file})
            list(APPEND minpack_Fflags ${minpack_intel_specific_Fflags_for_Win})
        else()
            list(APPEND minpack_Fflags ${minpack_intel_specific_Fflags_for_Unix})
        endif()
        target_compile_options(minpack_SHARED PRIVATE ${minpack_Fflags})
    elseif("${Fortran_COMPILER_NAME}" MATCHES "flang(\\-new)?")
        if (WIN32)
            target_sources(minpack_SHARED PRIVATE ${minpack_def_file})
        else()
            # TODO
        endif()
    else()
        # TODO: implement other compilers
    endif()

    set_target_properties(minpack_SHARED
        PROPERTIES
        POSITION_INDEPENDENT_CODE ON
        OUTPUT_NAME ${minpack_library_name}
    )

    list(APPEND targets_to_install minpack_SHARED)
endif()

# Build the static library
if (BUILD_STATIC_LIBS)
    add_library(minpack_STATIC STATIC "")
    target_sources(minpack_STATIC PRIVATE ${minpack_source_files})

    get_filename_component(Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)
    
    if ("${Fortran_COMPILER_NAME}" MATCHES "ifx|ifort")
        if (WIN32)
            set(wanted_Fflags ${minpack_intel_specific_Fflags_for_Win})
        else()
            set(wanted_Fflags ${minpack_intel_specific_Fflags_for_Unix})
        endif()

        foreach(wanted_flag ${wanted_Fflags})
            if (NOT (${wanted_flag} IN_LIST minpack_Fflags))
                list(APPEND minpack_Fflags ${wanted_flag})
            endif()
        endforeach()

        target_compile_options(minpack_STATIC PRIVATE ${minpack_Fflags})
    endif()

    set_target_properties(minpack_STATIC
        PROPERTIES
        OUTPUT_NAME ${minpack_library_name}
    )

    list(APPEND targets_to_install minpack_STATIC)
endif()

install(TARGETS ${targets_to_install} EXPORT ${minpack_targets_export}
    RUNTIME DESTINATION "${MINPACK_INSTALL_BINDIR}"
    LIBRARY DESTINATION "${MINPACK_INSTALL_LIBDIR}"
    ARCHIVE DESTINATION "${MINPACK_INSTALL_LIBDIR}"
)

list(JOIN minpack_Fflags " " minpack_Fflags_for_pkgconfig)

configure_file(
    ${minpack_pkg_config_in}
    ${minpack_pkg_config} @ONLY
)
configure_file(
    ${minpack_config_cmake_in}
    ${minpack_config_cmake} @ONLY
)
configure_file(
    ${minpack_config_version_cmake_in}
    ${minpack_config_version_cmake} @ONLY
)

install(
    FILES ${minpack_pkg_config}
    DESTINATION "${MINPACK_INSTALL_PKGCONFIG_DIR}"
)
install(
    FILES ${minpack_header}
    DESTINATION "${MINPACK_INSTALL_INCLUDEDIR}"
)
install(
    FILES ${minpack_copyright}
    DESTINATION "${MINPACK_INSTALL_DOCDIR}"
)
install(
    FILES ${minpack_config_cmake} ${minpack_config_version_cmake}
    DESTINATION "${MINPACK_INSTALL_LIBDIR}/${minpack_library_name}-${MINPACK_VERSION}"
)
install(
    EXPORT ${minpack_targets_export}
    DESTINATION "${MINPACK_INSTALL_LIBDIR}/${minpack_library_name}-${MINPACK_VERSION}"
)

message(STATUS "")
message(STATUS " ${minpack_library_name} ${MINPACK_VERSION} configuration summary:")
message(STATUS "")
message(STATUS "   Build options:")
message(STATUS "")
message(STATUS "     Build type ...................... : ${CMAKE_BUILD_TYPE}")
message(STATUS "     Build shared libs ............... : ${BUILD_SHARED_LIBS}")
message(STATUS "     Build static libs ............... : ${BUILD_STATIC_LIBS}")
message(STATUS " ")
message(STATUS "   Install directories:")
message(STATUS " ")
message(STATUS "     Install prefix .................. : ${CMAKE_INSTALL_PREFIX}")
message(STATUS "     Binary dir ...................... : ${MINPACK_INSTALL_BINDIR}")
message(STATUS "     Lib dir ......................... : ${MINPACK_INSTALL_LIBDIR}")
message(STATUS "     Include dir ..................... : ${MINPACK_INSTALL_INCLUDEDIR}")
message(STATUS "     Doc dir ......................... : ${MINPACK_INSTALL_DOCDIR}")
message(STATUS "     pkg-config dir .................. : ${MINPACK_INSTALL_PKGCONFIG_DIR}")
message(STATUS "")
message(STATUS "")