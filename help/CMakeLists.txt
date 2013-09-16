set(HELP_DEST share/gnome/help/balistica/C)

set(HELP_FILES
        C/basic_usage.page
        C/bugs.page
        C/greenhill.page
        C/index.page
        C/introduction.page
        C/limitations.page
        C/miller_twist.page
)

install(FILES ${HELP_FILES} DESTINATION ${HELP_DEST})
