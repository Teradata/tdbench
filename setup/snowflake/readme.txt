TdBench can be used with any DBMS that supports JDBC. Below are the steps for setting it up 
with Snowflake. 

IMPORTANT: These instructions were created by ChatGPT. See disclaimer at the end of this file.

Steps:

1. Download the Snowflake JDBC Driver:
    - Download the latest Snowflake JDBC driver from the Snowflake website:
      https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc.
    - Place the JDBC driver file in the home directory of TdBench (where tdbench.sh and 
      tdbench.bat reside).

2. Initial TdBench Setup:
    - After starting TdBench, use the SETUP command to copy in templates of the configuration 
      and TdBench startup commands.
    - If you’ve already set up a different DBMS, use the SETUP menu options to manually edit 
      the following:
        - tdbench_config.sh or tdbench_config.bat to specify Snowflake as your default DBMS.
        - tdbench.tdb for any common session setup you want across all DBMSs.

3. Update Configuration Scripts:
    - Edit the tdbench_snowflake_config.sh or tdbench_snowflake_config.bat to specify the following setup 
      details:
        - DBMS Alias: The alias name you will define to reference your Snowflake instance 
          (e.g., TdBenchServer=mydb).
        - User Name: The name of the Snowflake database where the TestTracking table will be stored. 
          (e.g., TdBenchDB=acme_benchmark).
        - Prefix: A prefix for multiple usernames running different parts of the workload to 
          distinguish them from other users (e.g., TdBenchPrefix=acme). This will be saved on
          the tdbenchinfo table table which could be built into reporting views. 

4. Update the TdBench Script:
    - Modify two commands in the tdbench_snowflake.tdb script to run every time TdBench starts:
        - CLASS Statement: Requires three pieces of information:
            - The class name for Snowflake: net.snowflake.client.jdbc.SnowflakeDriver.
            - The protocol available when connecting to the URL: Snowflake: jdbc:snowflake.
            - The file name of the JDBC driver: snowflake-jdbc*.jar.
            - Example:
                class net.snowflake.client.jdbc.SnowflakeDriver jdbc:snowflake snowflake-jdbc*.jar
        - DB Statement: References the CLASS statement and provides credentials:
            - Database Alias: Any text string to reference Snowflake (e.g., mydb).
            - The protocol to be used when connecting to the URL Snowflake: jdbc:snowflake.
            - Followed by the URL of your Snowflake instance and JDBC driver options.

               - use_cached_result=false to get realitic results simulating variety of users
               - insecureMode=true will stop warning message about CA OCSP responder

            - Username: Default Snowflake username for logging in.
            - Password: Password for that username.
            - Example:
                db mydb jdbc:snowflake://xxxxxxx-yyyyyyy.gcp.snowflakecomputing.com acme_benchmark  benchpwd
    - the tdbench_snowflake.tdb script also has 3 TdBench commands providing linkage to 
      simplify analysis of host DBMS query logging provided on the Snowflake DBMS. 
      You may uncomment them if you want to use them:
        - before_run - this defines an insert statement that will be executed immediately
          before each test begins to create a row in TestTracking with a RunID, TestName, 
          TestDescription, and the precise host DBMS starttime of the test.
        - after_run - defines an update statement which will record the precises stop 
          timestamp when the test completes along with counts of queries executed and 
          errors encountered during the run. The testTracking table can be built into a 
          view allowing simple extraction of query log rows by RunId using the associated
          timestamps.
        - after_note - will cause any note applied to TdBench's internal database to 
          be applied to the host DBMS's TestTracking table.
      (See discussion below on query logging for Snowflake).

5. Restart TdBench:
    - After editing the tdbench_snowflake.tdb script, restart TdBench to execute the CLASS and 
      DB statements.

6. Run a Test to Validate Setup:
    - Run a TdBench command on the platform to test the connection:
        sql mydb select current_timestamp;
    - Alternatively, return to the SETUP menu to execute the test_connect script.

7. Edit and Execute the SQL Script:
    - Use the SETUP menu to edit the create_tdbench.sql. This script will create the database where 
      the TestTracking table will reside, and where you might place views for query log 
      reporting.
    - Use the SETUP menu to execute the create_tdbench.sql.

8. Begin Running Tests:
    - Once the setup is complete, you can start running tests. Issue the following command in 
      TdBench to get started:
        help firsttime

Query logging for Snowflake:

While TdBench has an internal database (H2) for storing the results of query executions for each
workload test, it can only record what the Snowflake users would have experienced. Each DBMS
has some level of query logging that provides information about what the DBMS was doing during
the execution of the workload test. Analysis of that data can answer questions like:
- How much CPU and I/O did the query use?
- What clusters were involved in the execution?
- Some DBMSs record information about the steps, tables and indexes involved in the execution.
- How much of the platform's capacity was used during the workload test?
- Were there any competing queries being executed during the test that impacted the results?

Query logs on Snowflake may not be immediately available at the end of a test. In most cases, 
the delay is a few seconds, but it can occasionally be longer under heavy load or high concurrency.

Query log data on Snowflake may only be retained by the system for 2-5 days depending on the load 
and activity on the cluster. You might want to create a TdBench script to run after each test to 
save the query log data to your own history table and use that for your analysis. To be general, 
pass the most recent runid as a parameter.  Example:

   exec savelog.tdb  :runid

The code for “savelog.tdb” assumes you used the "after_run" query from the template. You can add 
the execution of the savelog.tdb as a second after_run query and tune for your platform by using
sleep command (commented out below).  The example code:

------------------------------------------------------------------------------------------------

if :i1 not set then echo Error: You must provide the RunID as a parameter
if :i1 not set then goto end_script
# sleep 10s
set saverunid = :i1
sql ${TdBenchServer} select start_time, query_text from SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY where query_text like '%update%testtracking%RunId%=%:saverunid%';
if :linecnt > 0 then goto copy_test
echo The query logs from :runid are not complete yet. In a few minutes, issue: exec savelog.tdb :saverunid
goto end_script

label copy_test
sql {TdBenchServer} insert into ${createddl}my_query_history_tbl select * from SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY ql join testtracking tt on ql.starttime between tt.starttime and tt.actualstoptime where runid = :saverunid;
label end_script

------------------------------------------------------------------------------------------------

DISCLAIMER:

These instructions were created by ChatGPT and have not been tested with Snowflake. Neither
Teradata nor ChatGPT provide any warranty as to the accuracy or completeness of these instructions. 
You are solely responsible for testing and validating the installation process. For detailed 
and accurate instructions, please refer to the official documentation provided by Snowflake.

