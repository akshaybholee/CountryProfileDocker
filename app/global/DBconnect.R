# use this connection when running application on local machine
# con <- dbPool(odbc(),
#               Driver = "SQL Server",
#               Server = "iecproduction.database.windows.net",
#               Database = "IECPRODDB",
#               UID = "IECPROD",
#               PWD = "International123")

# use this connection when deploying application to shinyapps.io
url <- httr::parse_url(Sys.getenv("DATABASE_URL"))
# con <- dbPool(odbc(),
#               Driver = Sys.getenv("DATABASE_URL"),
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



con <- RODBC::odbcDriverConnect(connection = "Driver=FreeTDS;TDS_Version=8.0;Server=iecproduction.database.windows.net;Port=1433;Database=IECPRODDB;Uid=IECPROD;Pwd=International123;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;")

