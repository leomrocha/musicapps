# Install script for directory: /home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/vmpk/locale" TYPE FILE FILES
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/vmpk_cs.qm"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/vmpk_de.qm"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/vmpk_es.qm"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/vmpk_fr.qm"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/vmpk_ru.qm"
    "/home/leo/projects/music/MusicChallenge/candidate_libs/keyboards/vmpk-0.5.1/translations/vmpk_sv.qm"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

