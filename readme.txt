TdBench 8.01.04 Readme

This product will enable you to simulate realistic production conditions with
complex workloads consisting of multiple queues of queries and OS commands 
executed in multiple threads (by "workers"). History of all tests and query 
executions are captured in a built-in SQL database. There are hooks to
automatically maintain test metadata on the host DBMS. This simplifies analysis 
of the host DBMS query logs to investigate HOW each query executed.

There is a complete reference to the 50+ commands within the application via the 
HELP command. You can also get coaching on what to do next with the ? command. 

Resources:

   downloads.teradata.com - most recent release, a reference manual and videos

   https://github.com/Teradata/tdbench - latest setups for non-Teradata DBMS,
       and place you can raise issues and submit your improvements to 
       query log reporting on your DBMS. There is also a Discussions forum
       where you can ask questions, provide feedback and submit ideas. 

****************************
* Basic Usage Instructions *
****************************

TdBench is started with:
   ./tdbench.sh - will validate your environment is ready to run TdBench
   tdbench.bat - same, but for the Windows environment

On startup, there are default OS config shell scripts and default TdBench scripts 
that are executed. These can be customized by you with the TdBench SETUP command. 
A single install of TdBench can be used to run tests on multiple DBMSs. The startup 
scripts define how to connect to each and define the current default DBMS for tests. 

For TdBench to execute SQL on your DBMS, you will need the DBMS's JDBC driver 
on the platform which is running TdBench. The jar file for that JDBC driver should
be placed in the same directory as this readme.txt. To find out how to get the file(s) 
making up the JDBC driver, use Google or ChatGPT to search for 
   "download xxxx JDBC driver". 

You should also search for 2 additional pieces of information:
   "what is the class name for the xxx jdbc driver" ... e.g. com.teradata.jdbc.TeraDriver
   "what is the url for the xxx jdbc driver" ... e.g. jdbc:teradata

The TdBench CLASS command loads the JDBC driver and has 3 parameters:

   CLASS [class-name] [URL-of-JDBC-driver] [jdbc file-name(s) | directory/*]

To complete the connection to your DBMS, it is necessary to provide the location,
username and password to the JDBC driver. The DB command provides an alias name
for each connection which may be multiple logons to the same DBMS, possibly for 
different priviledges or workloads, or for different platforms. 

   DB [alias] [URL-of-JDBC-driver]://[IP or URL of server] [username] [password]

More information is available for your DBMS when you run the TdBench SETUP command
and respond "HELP n" where n is the number of one of the setup menu items, or by
issuing HELP DB or HELP CLASS. Assuming you used SETUP to define "mydb" on the DB
everytime TdBench starts, you would use it on the SQL or WORKER statements as follows:

   sql mydb select current_timestamp
   worker queue1 mydb

Note: commands in TdBench are not case sensitive. Only file references in non-Windows
platforms are case sensitive. 

Once you are in TdBench, use the HELP command to get started. Examples:
   help   ... will give overview, simple example and reference to other help topics
   help index   ... will show you all of the commands
   help example   ... will show you a number of examples

You can run TdBench interactively or you can put TdBench commands into file(s)
(by convention with a .tdb suffix) and put the file name(s) or commands on the TdBench 
command line to run the test(s) in batch mode. Multiple files can be included.
If you are using parameters in your TdBench scripts, enclose file and parameters in " ".  

*******************************
*        Sample Usage         *
*******************************

Assuming you are doing a benchmark to tune the Finance application tables, you put 
a set of 25 files in a directory scripts/finance. Interactively you could type:

define finance Test all finance interactive queries
queue fin scripts/finance/*
worker fin mydb 3
run 10m

The above would create a queue named "fin" with 25 queries and define 3 workers to 
process the queries over and over for 10 minutes.  To run the test after each change
to the physical data model, you could save the 4 statements above into
scripts/finance_test1.tdb and execute them with:

./tdbench.sh scripts/finance_test1.tdb

or

tdbench.bat scripts\finance_test1.tdb

*******************************
* Advanced Usage Instructions *
*******************************

TdBench is an advanced, multi-DBMS benchmarking tool with the capability to simulate 
complex, realistic workloads. You can define multiple queues with arrival rates, 
arrival replay, arrival events, and control percentages of workload type executions. 
It has variables, if statements, and nested scripting to simplify and automate tests.
It can recognize DBMS crashes and resume tests after reporting the duration of the outage. 

For details on the above, you should refer to the manual from downloads.teradata.com.

This describes the capabilities to support multiple DBMSs with a single install using
config and startup files and advanced command line options.  

Startup Files:

After validating the environment, tdbench.sh or tdbench.bat will first run 
tdbench.config.sh or tdbench.config.bat to set the name of the tdbench jar file to run
and the default DBMS in the TdBench_DBMS variable.  That default setting can be 
overriden with -d parameter on the command line followed by the DBMS name to use. 
Examples:  tdbench.bat -d snowflake   or   ./tdbench.sh -d redshift

The config file for the current ${TdBench_DBMS} is then executed. The config 
.sh or .bat files can set environment variables to be referenced by scripts, 
prompt for passwords, or run cleanup/setup activities to be performed before each
TdBench execution. 

When the TdBench java program starts, it executes the tdbench.tdb file. In prior 
releases, all of the CLASS and DB statements for all of the DBMSs to be used during
an engagement were defined there.  The distribution of defaults for this release 
suggests for multi-DBMS testing, to put common statements in the tdbench.tdb file
such as LOG, TRACE, etc, and platform specific commands in one invoked by tdbench.tdb
by the statement in the tdbench.tdb file:
   if tdbench_${TdBench_DBMS}.tdb exists then include tdbench_${TdBench_DBMS}.tdb

TdBench Command line:

If the tdbench.config.sh or tdbench.config.bat scripts are run without parameters,
TdBench will execute in an interactive mode. You can use the HELP command for syntax
information, type in simple tests, and execute scripts. With the 8.01 release, the 
Linux users can now use vi and less under TdBench with the OS command.  Windows users
have always been able to run GUIs like notepad for editing files. You can assign your
favorite editor or file viewer to the TdBench variables edit or view. To see the
variables that are set by default, issue the TdBench SET command without parameters. 

You can put one or more script files on the command line. TdBench will execute 
them left to right and then exit unless you include the -i parameter to enter 
interactive mode after runing the scripts. New for the 8.01 release is the ability
to put TdBench commands in the list of tokens on the command line. If the first 
word in a token is a valid file name reference, then it will be executed as a script. 
Otherwise it will be taken as a command.

To get help on command line options use:  ./tdbench.sh --help   or   tdbench.bat --help

        
Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2021, 2024 Teradata Corporation, All Rights Reserved
