# TdBench - A Multi-DBMS Database Workload Simulation Tool

TdBench installation zip file is free and available for download from the [Teradata Developer Portal](https://downloads.teradata.com/download/tools/tdbench-8-0-for-any-dbms). This github repository supports updated materials for multiple DBMSs. We welcome contributions of new materials supporting any vendor's DBMS and over time, those materials may be included in new releases of the installation zip file. We also welcome the posting of issues.

### Objectives and Features of TdBench

Realistic simulation of workloads is vital when:
- Developing a multi-user application
- Supporting software or physical data model changes on a DBMS platform
- Evaluating relative performance of DBMS platforms
- Engineering DBMS features

After running a simulation, the analysis may involve the following:
- <b>Overall completion</b> of a set of scripts/programs is easy and usually presented on the output log or with a stop watch.
- <b>Comparison of each script/program performance</b> between tests is complicated as the number of scripts/programs increase. It is only possible if each one carries some sort of identification. Other query drivers may only provide performance metrics as observed from the client platform.
- <b>Analysis of DBMS query logs</b> behind the execution of each script/program answers how DBMS resources were used. While query logging is easily enabled on DBMS platforms, it can be challenging to identify the records associated with a given test. If the DBMS platform has other workloads, it is vital to understand how they may have affected test results. 

TdBench has evolved over 15 years of real-world benchmark engagements and now supports:
- fixed work, fixed period, and workload replay simulations
- multiple queues of work with a variable number of concurrent threads per queue
- queues of SQL scripts or OS programs (e.g. ETL or BI tools)
- scheduled query or program initiation, paced arrival, and paced percentage executions
- built-in logging of every query execution for every test in its internal H2 database
- coordination of test start/stop timestamps and test notes to table on host DBMS
- Reporting views for some DBMSs joining the test tracking table to query log table(s)
- Scripting language to automate single or multiple tests

### Supporting Materials

TdBench installation zip file is free and available for download from the [Teradata Developer Portal](https://downloads.teradata.com/download/tools/tdbench-8-0-for-any-dbms). The prior release between 2018 and 2024 had over 3,000 downloads (including by multiple DBMS vendors and consultancies). That site also has links to videos. Once you've registered and logged on, you can get access to the zip file, user guide and white papers. 

TdBench has over 70 help files built in to describe commands, provide examples, describe built-in variables, and basic first-time usage. While using TdBench interactively you can type ? to get a status of what you've defined so far and what is needed to complete the definition of a test. 

There is a reference manual both on this github site and on the Teradata Developer Portal that will guide you in setting up tests.

You can post to this github repository to get answers to questions.

### Installing TdBench

- Download the TdBench distribution zip file from [Teradata Developer Portal](https://downloads.teradata.com/download/tools/tdbench-8-0-for-any-dbms) to your Linux server or your personal computer.
- Your platform will need to have Java JRE or JDK installed.
- You may need to download the JDBC driver supporting your DBMS. (Only the Teradata JDBC driver is included in the zip file due to licensing issues)
- Start TdBench by typing ./tdbench.sh or tdbench.bat
- Issue the SETUP command.  (TdBench scripting/commands are not case sensitive with the exception of file references in Linux)

You will be presented a list of DBMSs. Some have setup for host reporting while others may only have a readme.txt with instructions for downloading the query driver and configuring a startup script to connect to your DBMS.  As of the formal 8.01.03 release, the following materials are in the distribution zip file and are subdirectories under the setup directory:
- databricks - readme.txt only
- google_bigquery - create TestTracking table and analytic reporting view
- greenplum - readme.txt only
- ibm_netezza - readme.txt only
- ibm_sailfish - readme.txt only
- oracle_exadata - readme.txt only
- redshift - create TestTracking table, basic reporting view and history table
- snowflake - create database, TestTracking table, basic reporting view, and query history table
- teradata - Define user/database, TestTracking table, and reporting views/macros against DBQL and Resusage tables in DBC and PDCR
- teradata_lake - Define user/databse, TestTracking table, and reporting views/macros against DBQL and Resusage tables in TD_METRIC_SVC

Each DBMS subdirectory has a version_history.txt file. Compare that version history to the corresponding subdirectory under setup on this github repository to see if there are updates. 
