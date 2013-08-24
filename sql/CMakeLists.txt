set(SQL_DEST share/balistica/sql)

install(FILES create_db.sql DESTINATION ${SQL_DEST})
install(FILES fill_db.sql DESTINATION ${SQL_DEST})
