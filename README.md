

# OWASP Demo CFML Application

A simple demo application used to show some ways of securing CFML to help stop some of the OWASP Top 10 vulnerabilities. It currently has only been tested with CF 2018.

### Database Setup

It is using Flyway for database migrations and currently works with MS SQL server. Here is an example of running a SQL server with Docker.

```
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourS3cureP@ss0rdH3re" -p 1433:1433 --name mssql -d mcr.microsoft.com/mssql/server:2019-latest
```

Then you can connect and create the database like this.

```
docker exec -it mssql bash

mssql@d653475c96de:/$ /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourS3cureP@ss0rdH3re
1> create database RecipeBox;
2> GO
```