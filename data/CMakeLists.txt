set(MAN_DEST ${CMAKE_INSTALL_PREFIX}/man)
set(DESKTOP_DEST ${CMAKE_INSTALL_PREFIX}/share/applications)
set(APPDATA_DEST ${CMAKE_INSTALL_PREFIX}/share/appdata)

# org.gnome.balistica.gschmea.xml is installed through the
# add_schemas command under the GSettings section in 
# balistica/src/CMakeLists.txt

set(MAN_FILES
        balistica.1
)

set(DESKTOP_FILES
        balistica.desktop
)

set(APPDATA_FILES
        balistica.appdata.xml
)

install(FILES ${MAN_FILES} DESTINATION ${MAN_DEST})
install(FILES ${DESKTOP_FILES} DESTINATION ${DESKTOP_DEST})
install(FILES ${APPDATA_FILES} DESTINATION ${APPDATA_DEST})
