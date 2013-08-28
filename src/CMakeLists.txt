set(MAIN
BalisticaApplication.vala
Calculate.vala
CmdHandler.vala
Main.vala
)

set(LIB_BALISTICA
lib_balistica/Atomsphere.vala
lib_balistica/Greenhill.vala
lib_balistica/LibBalistica.vala
lib_balistica/Miller.vala
lib_balistica/Retard.vala
lib_balistica/Retrieve.vala
lib_balistica/Solve.vala
lib_balistica/Windage.vala
lib_balistica/Zero.vala

lib_balistica/conversion/Angle.vala
lib_balistica/conversion/Temperature.vala
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
    gtk+-3.0>=3.6.0
    sqlite3>=3.7.4
)

set(GSETTINGS_DIR ${CMAKE_SOURCE_DIR}/desktop)

set(CFLAGS 
    ${DEPS_CFLAGS}
    ${DEPS_CFLAGS_OTHER}
    -D_VERSION=\"${VERSION}\"
    -D_INSTALL_PREFIX=\"${CMAKE_INSTALL_PREFIX}\"
    -D_SOURCE_ROOT_DIR=\"${CMAKE_SOURCE_DIR}\"
    -D_GSETTINGS_DIR=\"${CMAKE_BINARY_DIR}/gsettings\"
    -lm
)

if (DEBUG)
    set(CFLAGS
        ${CFLAGS}
        -g
    )
else ()
    set(CFLAGS
        ${CFLAGS}
        -O2
    )
endif ()


if (NOT DEBUG)

endif ()

set(LIB_PATHS ${DEPS_LIBRARY_DIRS})
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

set(VALAC_OPTIONS
    --vapidir=${CMAKE_SOURCE_DIR}/bindings/vapi
    --target-glib=${TARGET_GLIB}
    --thread
    --enable-checking
    --fatal-warnings
    ${EXTRA_VALA_OPTIONS}
)

# Balistica
#################################################
vala_precompile(BALISTICA_VALA_C balistica
    ${MAIN}
PACKAGES
     ${LIB_BALISTICA}
     ${DATABASE}
CUSTOM_VAPIS
OPTIONS
    ${VALAC_OPTIONS}
    --vapidir=${CMAKE_BINARY_DIR}/src
)

add_executable(balistica ${BALISTICA_VALA_C})
target_link_libraries(balistica ${DEPS_LIBRARIES} gthread-2.0 balistica-static)
install(TARGETS balistica RUNTIME DESTINATION bin)
add_custom_command(
    TARGET
        balistica
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy balistica ${CMAKE_BINARY_DIR}/
)

# GSettings
# This needs to be here and not in desktop/CMakeLists.txt in order for Geary to run in the build
# directory
include(GSettings)
add_schemas(balistica ${GSETTINGS_DIR} ${CMAKE_INSTALL_PREFIX})

# Valadoc
#################################################
foreach(pkg ${LIB_BALISTICA})
    list(APPEND valadoc_pkg_opts "--pkg=${pkg}")
endforeach(pkg ${LIB_BALISTICA})

include(FindValadoc)
add_custom_target(
    valadoc
    WORKING_DIRECTORY
        ${CMAKE_SOURCE_DIR}/src
    COMMAND
    ${VALADOC_EXECUTABLE} --force --no-protected -b ${CMAKE_CURRENT_SOURCE_DIR} -o ${CMAKE_SOURCE_DIR}/valadoc --package-name=balistica --package-version=${VERSION} ${LIB_BALISTICA} ${valadoc_pkg_opts} --vapidir=${CMAKE_SOURCE_DIR}/bindings/vapi
)

## Make clean: remove copied files
##################################################
set_property(
    DIRECTORY ..
    APPEND
    PROPERTY ADDITIONAL_MAKE_CLEAN_FILES
        balistica
)

