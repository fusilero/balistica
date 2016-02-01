enable_testing(true)
set(LIBS ${LIBS} balistica) 
include_directories(. ../src)

find_package(PkgConfig)
find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.28.0" MINIMUM)
include(ValaPrecompile)

set(TARGET_GLIB 2.46)

pkg_check_modules(DEPS REQUIRED
    glib-2.0>=${TARGET_GLIB}.0
    gee-0.8>=0.18.0
)

set(BALISTICA_TEST_PACKAGES
    glib-2.0 gee-0.8
)
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

vala_precompile(BALISTICA_TEST balistica_test
    TestMain.vala
    TestCase.vala 
    Angle.vala
PACKAGES
    ${BALISTICA_TEST_PACKAGES}
OPTIONS
    ${VALAC_OPTIONS}
)

add_executable(balistica_test ${BALISTICA_TEST})
target_link_libraries(balistica_test ${DEPS_LIBRARIES} glib-2.0 gthread-2.0 m)
add_test(balistica_test ${CMAKE_CURRENT_BINARY_DIR})
