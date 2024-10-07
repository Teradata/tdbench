While benchmarks have been executed on Netezza, we have not
captured the setup information from those engagements.
You can look at one of the other non-Teradata DBMS setup directories
as a guide for creating setup scripts you can use on Netezza.

Basic instructions:

You will need to download the JDBC driver for Netezza.
You can use Google or ChatGPT to get the current location.
The following location may be valid:

https://www.ibm.com/docs/en/netezza?topic=dls-installing-configuring-jdbc

The driver should be saved in the TdBench home directory (the same
directory where tdbench.sh and tdbench.bat are located).
The file name will likely be: nzjdbc.jar

If this is the only DBMS you will be using with TdBench,
you should create a tdbench.tdb file with a CLASS, DB and OPTION
statement that will define your connection on every startup.

The following is probably a valid CLASS statement for Netezza:
CLASS  org.netezza.Driver  jdbc:netezza  nzjdbc.jar

The DB statement creates an alias that will allow you to logon to Netezza.
It provides the URL, database name, user and password. It is highly
recommended that you validate the user and password using a tool other
than TdBench to ensure your platform has access and the user and
password are valid.  The DB statement will be something like:

DB  <alias>  jdbc:netezza://<host>:<port>/<database>  <user name>  <password>

Where:
-  Alias is a string you make up to reference the connection in SQL and WORKER statements
-  <host> provides the URL or IP address of your server
-  <port> generally is 5480 but may be different. You should validate by connecting using another tool
-  <database> created for holding the data used in tests
-  <user name>  <password> - credentials for logon to the GreenPlum DBMS.

The Netezza JDBC does not automatically close one query when another is opened on
the same connection, so it is necessary to instruct TdBench to open a record set
on each query and close it so the driver doesn't think we are trying to keep
open multiple concurrent queries for one worker's connection. Put the OPTION
statement in your tdbench.tdb startup file if the TdBench installation will
be used exclusively with Netezza, and either comment the line out or prompt
the user or set an environment variable to determine whether the OPTION
should be changed.  Example:

   OPTION  createrecordset on workerclose off

Assuming you gave "nz" as the alias on the DB statement, use the following
to test your connection:

   sql nz select current_timestamp;

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
https://github.com/Teradata/tdbench.  You can also raise issues there.

