#                                                                             #
#                                                                             #
###############################################################################
# License                                                                     #
###############################################################################
#                                                                             #
# Copyright (c) 2024 luau-project https://github.com/luau-project/minpackex   #
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
# [function] get_minpack_sources                                              #
#                                                                             #
#   [param] [out-var]                                                         #
#    minpack_source_basenames: LIST containing the basename of all Fortran    #
#    files                                                                    #
#                                                                             #
#   [param] [out-var]                                                         #
#    minpack_sha256_sums_for_source_files: LIST containing sha256sum for each #
#    Fortran file                                                             #
#                                                                             #
#   [param] [out-var]                                                         #
#    minpack_copyright: basename of the copyright file                        #
#                                                                             #
#   [param] [out-var]                                                         #
#    minpack_sha256_sum_for_copyright: sha256sum for copyright file           #
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

function(
    get_minpack_sources
    minpack_source_basenames
    minpack_sha256_sums_for_source_files
    minpack_copyright
    minpack_sha256_sum_for_copyright
)
    # Fortran source basenames
    set(${minpack_source_basenames}
        "chkder.f"
        "dogleg.f"
        "dpmpar.f"
        "enorm.f"
        "fdjac1.f"
        "fdjac2.f"
        "hybrd1.f"
        "hybrd.f"
        "hybrj1.f"
        "hybrj.f"
        "lmder1.f"
        "lmder.f"
        "lmdif1.f"
        "lmdif.f"
        "lmpar.f"
        "lmstr1.f"
        "lmstr.f"
        "qform.f"
        "qrfac.f"
        "qrsolv.f"
        "r1mpyq.f"
        "r1updt.f"
        "rwupdt.f"
        PARENT_SCOPE
    )

    # sha256 sums for source files
    set(
        ${minpack_sha256_sums_for_source_files}
        "6a71d2df5e75a800b42386d1096d4a55c32cdcd1e930a8957bed845dc77e5ef1"
        "5d29950bfbfa6415b4e07ce536b0388edd3ceb4d6b260b23eb11d9c3b6f135ba"
        "5c56b40119ddb0d00f60730a2f6ad8ceaac70422172b51af8dbde3944b324e7e"
        "c8ec66eeb809e5a1a8c896037597c73bd8966511a3b028fcc1f8be0e47310dd7"
        "b87bc037c7b1f728d1ec6417bc228a7cdb7a37c85627e8730f6c40267ef53009"
        "30ca8685efeab6f47bb40fb7c6f20f84d8467f39308bf10a54c9dac41c061391"
        "427ee1ab96f8583ccb661e76173758b8a98ae06af710bdce1acf8022ed27ac7b"
        "dae9685deaf24a3625ab65fc25c896cf0416aee1e09c93be17204273a381f521"
        "8cdb1da05e2bc9c2356c966136bef0f452f8d8a74ff0ff8d44988ef9a46da5c6"
        "f1f5994dba9b9e2a392bbc08ae1b1b74075dd0f8f6339531011fdedeb4654f96"
        "bd9bec43c803c20ab523410cd55476833bec63c96b10088c0d87c2a7c1df6ec4"
        "bcb863d4e71751e9c2e8bc163f3606823b206d4ded525645704238694d4b2cca"
        "bc6fac1d9b45d0331587705b47c0bc403b485883bcd8c9af9b1a2a858f57c1f7"
        "5e59e7d18e53bb588411f411d108851f8b3e24221c5983afe718dbf897874856"
        "01495a05ec1c0ba4ec3ace1f8f5e0db0eb5a2b8cc38991213792083005d73b3a"
        "1371ac7d94b943a647bc81bdf2df5826114c744a016a6ce78fe559c4205f1e61"
        "d2a59ac39a1d5c1dc6ff69a3dcc317509df89ef7775ce53f30ca44e184e03503"
        "2663c845eaefcbd398f13525f33e090b8dfe005fa4b4a3157caa8c06599f1bc5"
        "8183b99d4550d2f20b1ffc7456d0afa756e9d0ac3d8976148628416632b3aa42"
        "768eb92e2d4d257f81202b8de83d30e390ca92a0763e96b59175aee02bf45e7f"
        "a8e8e5038e60823c273898b8c723f423bb9abbb5da377a73c33bce8f152b5b12"
        "33924ea50382e1c74b7f8b0662bea19c7f6772468b5d07e3250384c7c18d1666"
        "d5a5c0a934368be75905c0620898d6061970f4553f4045f8f19be25e492043c3"
        PARENT_SCOPE
    )

    # copyright file
    set(${minpack_copyright} "disclaimer" PARENT_SCOPE)

    # sha256sum for copyright
    set(
        ${minpack_sha256_sum_for_copyright}
        "f5b330efdad110cdd84d585ec61220b0650461fa599e36b13e1726c9346dcfb9"
        PARENT_SCOPE
    )

endfunction()
