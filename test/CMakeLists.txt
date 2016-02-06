enable_testing(true)
set(LIBS ${LIBS} balistica lib-balistica) 
include_directories(${CMAKE_BINARY_DIR}/src)

set(BALISTICA_TEST_PACKAGES
    glib-2.0 gee-0.8
)

set(CFLAGS
    ${DEPS_CFLAGS}
    ${DEPS_CFLAGS_OTHER}
    -D_INSTALL_PREFIX=\"${CMAKE_INSTALL_PREFIX}\"
    -D_SOURCE_ROOT_DIR=\"${CMAKE_SOURCE_DIR}\"
)

set(LIB_PATHS ${DEPS_LIBRARY_DIRS})
link_directories(${LIB_PATHS})
add_definitions(${CFLAGS})

set(TEST_SRC
    TestMain.vala
    TestCase.vala 
    
    LibBalistica/Conversion.vala
) 

vala_precompile(BALISTICA_TEST balistica_test
    ${TEST_SRC}
PACKAGES
    ${BALISTICA_TEST_PACKAGES}
CUSTOM_VAPIS
    "${CMAKE_BINARY_DIR}/src/lib-balistica.vapi"
OPTIONS
    ${VALAC_OPTIONS}
)

add_executable(balistica_test ${BALISTICA_TEST})
target_link_libraries(balistica_test ${DEPS_LIBRARIES} glib-2.0 gthread-2.0 m lib-balistica)

add_test(balistica_test ${CMAKE_BINARY_DIR}/test/balistica_test)
