set(MAN_DEST ${CMAKE_INSTALL_PREFIX}/man)
set(DESKTOP_DEST ${CMAKE_INSTALL_PREFIX}/share/applications)

set(MAN_FILES
        balistica.1
)

set(DESKTOP_FILES
        balistica.desktop.in
)

install(FILES ${MAN_FILES} DESTINATION ${MAN_DEST})
install(FILES ${DESKTOP_FILES} DESTINATION ${DESKTOP_DEST})
