@echo off
rem TdBench 8.0 Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2020, 2024 Teradata Corporation

rem ------------------------------------------------------------------------
rem The following parameters can be edited to affect the generation of views.
rem
rem TdBenchProject is the Google Project_ID where the dataset and tables will
rem be created.
rem
rem TdBenchDataset is the container of the tables (similar to the use of
rem database on other DBMS platforms).
rem
rem TdBenchDb is the concatonation of project and dataset for compatibility
rem with scripts common across DBMSs as the fully qualified container of
rem tables and views.
rem
rem TdBenchServer is the database alias of the server where query log
rem Reporting will be setup. You need to have the DB statement executed
rem prior to including setup/google_bigquery/setup_dbms.tdb
rem
rem Simply: We will run tests on TdBenchServer and report results in TdBenchDB
rem  of work done by logons with a prefix of TdBenchPrefix.
rem
rem ------------------------------------------------------------------------

set TdBenchProject=not_set
set TdBenchDataset=not_set
set TdBenchDb=${TdBenchProject}.${TdBenchDataset}
set TdBenchServer=not_set


