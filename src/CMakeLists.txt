set(MAIN
    BalisticaApplication.vala
    Calculate.vala
    FileUtils.vala
    Main.vala
)

set(LIB_BALISTICA
    LibBalistica/Atmosphere.vala
    LibBalistica/Greenhill.vala
    LibBalistica/LibBalistica.vala
    LibBalistica/Miller.vala
    LibBalistica/PBR.vala
    LibBalistica/Retard.vala
    LibBalistica/Solution.vala
    LibBalistica/Solve.vala
    LibBalistica/Windage.vala
    LibBalistica/Zero.vala

    LibBalistica/conversion/Angle.vala
    LibBalistica/conversion/Mass.vala
    LibBalistica/conversion/Temperature.vala
)

set(DATABASE
    db/DataBase.vala
)

# Vala
find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.20.1" MINIMUM)
include(ValaPrecompile)

# Packages
set(TARGET_GLIB 2.32)

pkg_check_modules(DEPS REQUIRED
    glib-2.0>=${TARGET_GLIB}.0
    gtk+-3.0>=3.4.2
    gee-0.8>=0.8.5
    #sqlite3>=3.8.0
)

set(LIB_BALISTICA_PACKAGES
    glib-2.0 gtk+-3.0 gee-0.8 #sqlite3
)

set(GSETTINGS_DIR ${CMAKE_SOURCE_DIR}/data)

# Compilation options
set(CFLAGS
    ${DEPS_CFLAGS}
    ${DEPS_CFLAGS_OTHER}
    -D_VERSION_MAJOR=\"${VERSION_MAJOR}\"
    -D_VERSION_MINOR=\"${VERSION_MAJOR}\"
    -D_VERSION_REVISION=\"${VERSION_REVISION}\"
    -D_VERSION_COMMIT=\"${VERSION_COMMIT}\"
    -D_VERSION_DESC=\"${VERSION_DESC}\"
    -D_INSTALL_PREFIX=\"${CMAKE_INSTALL_PREFIX}\"
    -D_GSETTINGS_DIR=\"${CMAKE_BINARY_DIR}/gsettings\"
    -D_SOURCE_ROOT_DIR=\"${CMAKE_SOURCE_DIR}\"
)

set(LIB_PATHS ${DEPS_LIBRARY_DIRS})
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

set(VALAC_OPTIONS
    --target-glib=${TARGET_GLIB}
    --thread
    --enable-checking
    --fatal-warnings
)

# Debug vs not-Debug
if(DEBUG OR ADD_COVERAGE)
    set(VALAC_OPTIONS
	${VALAC_OPTIONS}
	--debug
	)

    set(CFLAGS
	${CFLAGS}
	-g
	)

    if(ADD_COVERAGE)
	set(CFLAGS
	    ${CFLAGS}
	    -fprofile-arcs
	    -ftest-coverage
	    )

	set(COVERAGE_LIBS
	    ${COVERAGE_LIBS}
	    gcov
	    )
    endif()
else()
    set(CFLAGS
	${CFLAGS}
	-O2
	)
endif()

# Balistica
#################################################
vala_precompile(BALISTICA_VALA_C balistica
    ${MAIN}
    ${LIB_BALISTICA}
    ${DATABASE}
PACKAGES
    ${LIB_BALISTICA_PACKAGES}
OPTIONS
    ${VALAC_OPTIONS}
)

add_executable(balistica ${BALISTICA_VALA_C})
target_link_libraries(balistica ${DEPS_LIBRARIES} ${COVERAGE_LIBS} gthread-2.0 m)
install(TARGETS balistica RUNTIME DESTINATION bin)
add_custom_command(
    TARGET
        balistica
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy balistica ${CMAKE_BINARY_DIR}/
)

# GSettings
# This needs to be here and not in data/CMakeLists.txt in order to run in the build
# directory
include(GSettings)
add_schemas(balistica ${GSETTINGS_DIR} ${CMAKE_INSTALL_PREFIX})

## Make clean: remove copied files
##################################################
set_property(
    DIRECTORY ..
    APPEND
    PROPERTY ADDITIONAL_MAKE_CLEAN_FILES
        balistica
)
