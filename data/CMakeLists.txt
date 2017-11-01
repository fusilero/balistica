set(DESKTOP_DEST ${CMAKE_INSTALL_PREFIX}/share/applications)
set(APPDATA_DEST ${CMAKE_INSTALL_PREFIX}/share/appdata)

set(DESKTOP_FILES
        balistica.desktop
)

set(APPDATA_FILES
        balistica.appdata.xml
)

install(FILES ${DESKTOP_FILES} DESTINATION ${DESKTOP_DEST})
install(FILES ${APPDATA_FILES} DESTINATION ${APPDATA_DEST})

# Application icon goes in theme directory
install(FILES "hicolor/16x16/apps/balistica.png" DESTINATION share/icons/hicolor/16x16/apps)
install(FILES "hicolor/24x24/apps/balistica.png" DESTINATION share/icons/hicolor/24x24/apps)
install(FILES "hicolor/32x32/apps/balistica.png" DESTINATION share/icons/hicolor/32x32/apps)
install(FILES "hicolor/48x48/apps/balistica.png" DESTINATION share/icons/hicolor/48x48/apps)
install(FILES "hicolor/48x48/apps/balistica.png" DESTINATION share/icons/hicolor/128x128/apps)
install(FILES "hicolor/256x256/apps/balistica.png" DESTINATION share/icons/hicolor/256x256/apps)
install(FILES "hicolor/512x512/apps/balistica.png" DESTINATION share/icons/hicolor/512x512/apps)
install(FILES "hicolor/scalable/apps/balistica.svg" DESTINATION share/icons/hicolor/scalable/apps)

# Optional: update icon cache at install time.
if (ICON_UPDATE)
    install(
        CODE
            "execute_process (COMMAND gtk-update-icon-cache -t -f ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor)"
        CODE
            "message (STATUS \"Updated icon cache in ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor\")"
    )
    
    add_custom_target(
        uninstall-icon-cache
        COMMAND
            gtk-update-icon-cache -t -f ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor
        COMMENT
            "Updated icon cache after uninstall in ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor"
    )
    
    add_dependencies(post-uninstall uninstall-icon-cache)
endif ()

# Optional: run update-desktop-database at install time.
# (This has to happen after the org.gnome.Geary.desktop file is installed.)
if (DESKTOP_UPDATE)
    install(
        CODE
            "execute_process (COMMAND update-desktop-database)"
        CODE
            "message (STATUS \"Updating desktop database\")"
    )
    
    add_custom_target(
        uninstall-desktop-update
        COMMAND
            update-desktop-database
    )
    
    add_dependencies(post-uninstall uninstall-desktop-update)
else ()
    install(
        CODE "message (STATUS \"Not updating desktop database\")"
    )
endif ()
