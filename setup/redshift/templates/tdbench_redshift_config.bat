@echo off
rem TdBench 8.0 Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2020, 2024 Teradata Corporation

rem ------------------------------------------------------------------------
rem The following parameters can be edited to affect the generation of views.
rem
rem TdBenchServer is the database alias of the server where test will be
rem executed and query log reporting will be setup.
rem 
rem TdBenchDb is the location where test metadata and views will be saved.
rem Redshift identifies tables 3 components: database.schema.tablename.
rem We will assume that schema is public.
rem 
rem The TdBenchUser is the username used for control of tdbench
rem 
rem The TdBenchPrefix is the username prefix of the worker logons, used to 
rem distinguish tdbench workload from competing workload
rem
rem Simply: We will run tests on TdBenchServer and report results in TdBenchDB
rem  of work done by logons with a prefix of TdBenchPrefix.
rem
rem ------------------------------------------------------------------------

set TdBenchServer=not_set
set TdBenchDb=not_set
set TdBenchPrefix=not_set

