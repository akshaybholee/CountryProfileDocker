# use this connection when running application on local machine
con <- dbPool(odbc(),
              Driver = "SQL Server",
              Server = "iecproduction.database.windows.net",
              Database = "IECPRODDB",
              UID = "IECPROD",
              PWD = "International123")

# use this connection when deploying application to shinyapps.io
# print(odbc::odbcListDrivers())
# 
# con <- dbPool(odbc(),
#               Driver = "ODBC Driver 17 for SQL Server",
#               Server = "iecproduction.database.windows.net",
#               Database = "IECPRODDB",
#               UID = "IECPROD",
#               PWD = "International123",
#               port = 1433)

# con <- dbPool(odbc::odbc(),
#               Driver = "psqlodbcw",
#               Server = url$hostname,
#               Database = url$path,
#               UID = url$user,
#               PWD = url$password,
#               port = url$port)

