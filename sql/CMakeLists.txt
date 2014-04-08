set(SQL_DEST share/balistica/sql)

# Database versions
install(FILES Version-001.sql DESTINATION ${SQL_DEST})
install(FILES Version-002.sql DESTINATION ${SQL_DEST})

# Data
install(FILES data/fill_bullets.sql DESTINATION ${SQL_DEST})
install(FILES data/fill_calibers.sql DESTINATION ${SQL_DEST})
install(FILES data/fill_gauges.sql DESTINATION ${SQL_DEST})
