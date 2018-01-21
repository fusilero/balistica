set(MAIN_SRC
    BalisticaApplication.vala
    Calculate.vala
    Database.vala
    Logging.vala
    LogMsg.vala
    Main.vala

    # Calculations
    gui/PbrDialog.vala
    gui/DragBox.vala
    gui/TwistBox.vala
    gui/StabilityBox.vala
    gui/LogViewerDialog.vala

    # Reloading
    gui/CaseBox.vala
    gui/PowderBox.vala
    gui/PrimerBox.vala
    gui/ProjectileBox.vala
)

set(LIB_BALISTICA_SRC
    LibBalistica/Atmosphere.vala
    LibBalistica/Greenhill.vala
    LibBalistica/LibBalistica.vala
    LibBalistica/Miller.vala
    LibBalistica/Pbr.vala
    LibBalistica/Retard.vala
    LibBalistica/Solution.vala
    LibBalistica/Solve.vala
    LibBalistica/Windage.vala
    LibBalistica/Zero.vala

    LibBalistica/conversion/Angle.vala
    LibBalistica/conversion/Mass.vala
    LibBalistica/conversion/Temperature.vala
)

# Vala
find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.36.8" MINIMUM)
include(ValaPrecompile)

# Packages
set(TARGET_GLIB 2.40)

pkg_check_modules(DEPS REQUIRED
    glib-2.0>=${TARGET_GLIB}.0
    gtk+-3.0>=3.10.8
    gee-0.8>=0.20.0
)

set(LIB_BALISTICA_PACKAGES
    glib-2.0 gee-0.8
)

set(BALISTICA_PACKAGES
    gtk+-3.0 gio-2.0 sqlite3
)

set(GSETTINGS_DIR ${CMAKE_SOURCE_DIR}/data)

# Compilation options
set(CFLAGS
    ${DEPS_CFLAGS}
    ${DEPS_CFLAGS_OTHER}
    -D_VERSION_MAJOR=\"${VERSION_MAJOR}\"
    -D_VERSION_MINOR=\"${VERSION_MINOR}\"
    -D_VERSION_COMMIT=\"${VERSION_COMMIT}\"
    -D_VERSION_DESC=\"${VERSION_DESC}\"
    -D_INSTALL_PREFIX=\"${CMAKE_INSTALL_PREFIX}\"
    -D_SOURCE_ROOT_DIR=\"${CMAKE_SOURCE_DIR}\"
)

set(LIB_PATHS ${DEPS_LIBRARY_DIRS})
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

set(VALAC_OPTIONS
    --target-glib=${TARGET_GLIB}
    --thread
    --enable-checking
)

# Debug vs Release
if(DEBUG OR ADD_COVERAGE)
    set(VALAC_OPTIONS
	${VALAC_OPTIONS}
	--debug -C
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

# LibBalistica
#################################################
vala_precompile(LIB_BALISTICA_VALA_C lib-balistica
    ${LIB_BALISTICA_SRC}
PACKAGES
    ${LIB_BALISTICA_PACKAGES}
GENERATE_VAPI
    lib-balistica
OPTIONS
    ${VALAC_OPTIONS}
)

add_library(lib-balistica STATIC ${LIB_BALISTICA_VALA_C})
target_link_libraries(lib-balistica ${DEPS_LIBRARIES} gthread-2.0 m)
install (
    TARGETS lib-balistica
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(
    FILES ${CMAKE_BINARY_DIR}/src/lib-balistica.h
    DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}
)

# Balistica
#################################################
vala_precompile(BALISTICA_VALA_C balistica
    ${MAIN_SRC}
PACKAGES
    ${BALISTICA_PACKAGES}
    ${LIB_BALISTICA_PACKAGES}
CUSTOM_VAPIS
    "${CMAKE_BINARY_DIR}/src/lib-balistica.vapi"
OPTIONS
    ${VALAC_OPTIONS}
    --gresources ${CMAKE_SOURCE_DIR}/ui/gresources.xml
)

include(GResource)
GLIB_COMPILE_RESOURCES(BALISTICA_RESOURCES SOURCE ../ui/gresources.xml)

add_executable(balistica ${BALISTICA_VALA_C} ${BALISTICA_RESOURCES})
target_link_libraries(balistica ${DEPS_LIBRARIES} ${COVERAGE_LIBS} gthread-2.0 lib-balistica sqlite3)
install(TARGETS balistica RUNTIME DESTINATION bin)

# Copy the executable to the top-level build directory to make testing easier
add_custom_command(
    TARGET
        balistica
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy balistica ${CMAKE_BINARY_DIR}/
)

## Make clean: remove copied files
##################################################
set_property(
    DIRECTORY ..
    APPEND
    PROPERTY ADDITIONAL_MAKE_CLEAN_FILES
        balistica
)
