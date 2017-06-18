set(MAIN_SRC
    balistica_application.vala
    calculate.vala
    file_utils.vala
    main.vala
    pbr_window.vala
    DragMain.vala
)

set(LIB_BALISTICA_SRC
    libbalistica/atmosphere.vala
    libbalistica/greenhill.vala
    libbalistica/libbalistica.vala
    libbalistica/miller.vala
    libbalistica/pbr.vala
    libbalistica/retard.vala
    libbalistica/solution.vala
    libbalistica/solve.vala
    libbalistica/windage.vala
    libbalistica/zero.vala

    libbalistica/conversion/angle.vala
    libbalistica/conversion/mass.vala
    libbalistica/conversion/temperature.vala
)

# Vala
find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.30.1" MINIMUM)
include(ValaPrecompile)

# Packages
set(TARGET_GLIB 2.40)

pkg_check_modules(DEPS REQUIRED
    glib-2.0>=${TARGET_GLIB}.0
    gtk+-3.0>=3.10.8
    gee-0.8>=0.18.0
)

set(LIB_BALISTICA_PACKAGES
    glib-2.0 gee-0.8
)

set(BALISTICA_PACKAGES
    gtk+-3.0 gio-2.0
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

# libbalistica
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

# Valadoc
#################################################
find_package(Valadoc)

if(VALADOC_FOUND)
    foreach(pkg ${LIB_BALISTICA_PACKAGES})
        list(APPEND valadoc_pkg_opts "--pkg=${pkg}")
    endforeach(pkg ${LIB_BALISTICA_PACKAGES})

    include(FindValadoc)
    add_custom_target(
        valadoc
        WORKING_DIRECTORY
        ${CMAKE_SOURCE_DIR}/src
    COMMAND
        ${VALADOC_EXECUTABLE}
        --verbose --force --deps
        --package-name=lib-balistica
        --package-version=${VERSION}
        --target-glib=${TARGET_GLIB}
        -b ${CMAKE_CURRENT_SOURCE_DIR}
        -o ${CMAKE_SOURCE_DIR}/valadoc
        ${valadoc_pkg_opts}
        ${LIB_BALISTICA_SRC}
    )
endif()

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
    --gresources ${CMAKE_SOURCE_DIR}/ui/resources.xml
)

include(GResource)
GLIB_COMPILE_RESOURCES(BALISTICA_RESOURCES SOURCE ../ui/resources.xml)

message(${BALISTICA_RESOURCES})
add_executable(balistica ${BALISTICA_VALA_C} ${BALISTICA_RESOURCES})
target_link_libraries(balistica ${DEPS_LIBRARIES} ${COVERAGE_LIBS} gthread-2.0 lib-balistica)
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
