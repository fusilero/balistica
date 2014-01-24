set(SQL_DEST share/balistica/sql)

install(FILES Version-001.sql DESTINATION ${SQL_DEST})
install(FILES Version-002.sql DESTINATION ${SQL_DEST})
install(FILES fill_db.sql DESTINATION ${SQL_DEST})
