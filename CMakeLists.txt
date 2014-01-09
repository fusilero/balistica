# Check http://webdev.elementaryos.org/docs/developer-guide/cmake for documentation

cmake_minimum_required(VERSION 2.8)
cmake_policy(VERSION 2.6)

project(balistica C)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )

# We use this so we can append the latest commit hash
# to the version string
include(cmake/FindGit.cmake)
if(GIT_FOUND)
    GIT_WC_INFO(${PROJECT_SOURCE_DIR} Project)
endif()

#
# Version information
#
set(VERSION_MAJOR 0)
set(VERSION_MINOR 0)
set(VERSION_REVISION 1)
set(VERSION_COMMIT ${Project_WC_REVISION_HASH})
# Anything other than "Release" will add the latest commit 
# hash when built to the version string
set(VERSION_DESC "Development")

# Packaging filenamesnames
set(ARCHIVE_BASE_NAME ${CMAKE_PROJECT_NAME}-${VERSION})
set(ARCHIVE_FULL_NAME ${ARCHIVE_BASE_NAME}.tar.xz)
set(ARCHIVE_DEBUILD_FULL_NAME ${CMAKE_PROJECT_NAME}_${VERSION}.orig.tar.xz)

option(DEBUG "Build for debugging." OFF)

if (DEBUG)
	message("Compiling with DEBUG options")
endif ()

find_package(PkgConfig)

#
# Uninstall target
#
configure_file(
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
	"${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
	IMMEDIATE @ONLY
)

add_custom_target(
	uninstall-base
	COMMAND 
		${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake
	COMMAND 
		${glib_schema_compiler} ${GSETTINGS_DIR}
)

add_custom_target(
	uninstall
)

# We add this dependency using add_dependencies (which makes it run first) rather than
# a depends clause in add_custom_target (which would make it run last).
add_dependencies(uninstall uninstall-base)

# This gets fired in the root-level Makefile to ensure an post-uninstall cleanup happens after
# everything has has been removed
add_custom_target(
	post-uninstall
)

# Dist
# This generates the dist tarballs
add_custom_target(
	dist
	COMMAND 
		git archive --prefix=${ARCHIVE_BASE_NAME}/ HEAD
		| xz -z > ${CMAKE_BINARY_DIR}/${ARCHIVE_FULL_NAME}
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

add_subdirectory(help)
add_subdirectory(sql)
add_subdirectory(src)
add_subdirectory(ui)
