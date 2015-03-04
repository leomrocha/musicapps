# Install script for directory: /home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/home/leo/.vmpk")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/vmpk" TYPE FILE FILES
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/azerty.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vkeybd-default.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/it-qwerty.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/german.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/gmgsxg.ins"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/spanish.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/pc102x11.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/pc102mac.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/pc102win.xml"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/txt2ins.awk"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/hm.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/hm_es.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/hm_ru.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/help.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/help_de.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/help_es.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/help_fr.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/help_nl.html"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/help_ru.html"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/16x16/apps" TYPE FILE RENAME "vmpk.png" FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vmpk_16x16.png")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/32x32/apps" TYPE FILE RENAME "vmpk.png" FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vmpk_32x32.png")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/48x48/apps" TYPE FILE RENAME "vmpk.png" FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vmpk_48x48.png")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/64x64/apps" TYPE FILE RENAME "vmpk.png" FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vmpk_64x64.png")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/128x128/apps" TYPE FILE RENAME "vmpk.png" FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vmpk_128x128.png")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/scalable/apps" TYPE FILE FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/data/vmpk.svgz")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/applications" TYPE FILE FILES "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/vmpk.desktop")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/src/cmake_install.cmake")
  INCLUDE("/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/cmake_install.cmake")
  INCLUDE("/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/man/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

IF(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
ELSE(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
ENDIF(CMAKE_INSTALL_COMPONENT)

FILE(WRITE "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/${CMAKE_INSTALL_MANIFEST}" "")
FOREACH(file ${CMAKE_INSTALL_MANIFEST_FILES})
  FILE(APPEND "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/${CMAKE_INSTALL_MANIFEST}" "${file}\n")
ENDFOREACH(file)
