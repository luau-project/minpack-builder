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
# Start(Description of function)                                              #
###############################################################################
#                                                                             #
# [function] download_minpack_sources                                         #
#                                                                             #
#   [param] [in]                                                              #
#    destination_dir: directory to store downloaded files from ${minpack_url} #
#                                                                             #
#   [param] [out-var]                                                         #
#    minpack_source_files: LIST containing full paths of the downloaded       #
#    fortran files                                                            #
#                                                                             #
#   [param] [out-var]                                                         #
#    minpack_copyright: STRING containing a full path for the downloaded      #
#    copyright file                                                           #
#                                                                             #
###############################################################################
# End(Description of function)                                                #
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

function(download_minpack_sources destination_dir minpack_source_files minpack_copyright)

    message(STATUS "")
    message(STATUS " Starting download ...")
    message(STATUS "")

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

    set(minpack_copyright_file_url "${minpack_url}/${minpack_copyright_basename}")
    set(minpack_copyright_file_destination "${destination_dir}/${minpack_copyright_basename}")

    message(STATUS "")
    if (EXISTS ${minpack_copyright_file_destination})
        message(STATUS " Found copyright file (${minpack_copyright_basename}) at:")
        message(STATUS "     ${minpack_copyright_file_destination}")
    else()
        message(STATUS " Downloading copyright file (${minpack_copyright_basename})")
        message(STATUS "     with expected SHA256 sum ${minpack_sha256_sum_for_copyright}")

        file(DOWNLOAD
            ${minpack_copyright_file_url}
            ${minpack_copyright_file_destination}
            EXPECTED_HASH SHA256=${minpack_sha256_sum_for_copyright}
            STATUS DOWNLOAD_STATUS
        )

        list(GET DOWNLOAD_STATUS 0 STATUS_CODE)
        if (NOT (${STATUS_CODE} EQUAL 0))
            list(GET DOWNLOAD_STATUS 1 ERROR_MESSAGE)
            message(FATAL_ERROR "Failed to download minpack copyright: ${ERROR_MESSAGE}.")
        endif()
    endif()

    set(downloaded_source_files "")

    foreach(key_value IN ZIP_LISTS minpack_source_basenames minpack_sha256_sums_for_source_files)
        set(minpack_fortran_file ${key_value_0})
        set(minpack_fortran_file_sha256 ${key_value_1})
        set(minpack_fortran_file_url "${minpack_url}/${minpack_fortran_file}")
        set(minpack_fortran_file_destination "${destination_dir}/${minpack_fortran_file}")

        if (EXISTS ${minpack_fortran_file_destination})
            message(STATUS " Found fortran file (${minpack_fortran_file}) at")
            message(STATUS "     ${minpack_fortran_file_destination}")
        else()
            message(STATUS " Downloading fortran file (${minpack_fortran_file})")
            message(STATUS "     with expected SHA256 sum ${minpack_fortran_file_sha256}")

            file(DOWNLOAD
                ${minpack_fortran_file_url}
                ${minpack_fortran_file_destination}
                EXPECTED_HASH SHA256=${minpack_fortran_file_sha256}
            )

            list(GET DOWNLOAD_STATUS 0 STATUS_CODE)
            if (NOT (${STATUS_CODE} EQUAL 0))
                list(GET DOWNLOAD_STATUS 1 ERROR_MESSAGE)
                message(FATAL_ERROR "Failed to download ${minpack_fortran_file}: ${ERROR_MESSAGE}.")
            endif()
        endif()

        list(APPEND downloaded_source_files ${minpack_fortran_file_destination})
    endforeach()
    message(STATUS "")
    message(STATUS " Download completed.")
    message(STATUS "")

    set(${minpack_source_files} "${downloaded_source_files}" PARENT_SCOPE)
    set(${minpack_copyright} "${minpack_copyright_file_destination}" PARENT_SCOPE)
endfunction()
