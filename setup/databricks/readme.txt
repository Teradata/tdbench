While benchmarks have been executed on Databricks, we have not
captured the setup information from those engagements.
You can look at one of the other non-Teradata DBMS setup directories
as a guide for creating setup scripts you can use on Databricks.

Basic instructions:

You will need to download the JDBC driver for Databricks.
You can use Google or ChatGPT to get the current location.
The following location may be valid:

https://www.databricks.com/spark/jdbc-drivers-download

The driver should be saved in the TdBench home directory (the same
directory where tdbench.sh and tdbench.bat are located).
The file name will be something like: 
   spark-jdbc_2.12-<version>.jar 
(where <version> is the specific version number you are downloading)

If this is the only DBMS you will be using with TdBench,
you should create a tdbench.tdb file with a CLASS and DB statement
that will define your connection on every startup.

The following is probably a valid CLASS statement for Databricks:
CLASS  org.apache.spark.sql.execution.datasources.jdbc.JdbcDialect  jdbc:spark  spark-jdbc_2.12-*.jar

The DB statement creates an alias that will allow you to logon to Databricks.
It provides the URL, database name, user and password. It is highly
recommended that you validate the user and password using a tool other
than TdBench to ensure your platform has access and the user and
password are valid.  The DB statement will be something like:

DB  <alias>  jdbc:spark://<host>:443/<database>  <user name>  <password>

Where:
-  Alias is a string you make up to reference the connection in SQL and WORKER statements
-  <host> provides the URL or IP address of your server
-  <database> created for holding the data used in tests, usually: default
-  <user name>  <password> - credentials for logon to the GreenPlum DBMS.

Assuming you gave "brick" as the alias on the DB statement, use the following
to test your connection:

   sql brick select current_timestamp as current_time;

For other DBMSs, we have created a TestTracking table on the target
DBMS and used the BEFORE_RUN and AFTER_RUN statements to run queries on the
host DBMS to add a row with the starting timestamp and other test metadata
before the test begins and after the test is complete, to update the ending
time and basic statistics observed by TdBench.

This TestTracking table can be joined to the host DBMS query logging
to select rows based on a simple constraint against RunID, leveraging
the precise StartTime and ActualStopTime in the TestTracking table.
Instead of complex reference to timestamps in a BETWEEN constraint, use:

   where runid = 21

or compare several tests:

   where runid in (21, 33, 46)

There is also an AFTER_NOTE statement that can synchronize notes that
you add to TdBench's internal H2 database to the TestTracking table
on the host DBMS.

If you develop any setup scripts, we would welcome submitting those to
https://github.com/Teradata/tdbench.  You can also use github discussions 
for questions or raise issues there.

