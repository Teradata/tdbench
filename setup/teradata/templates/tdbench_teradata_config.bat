@echo off
rem TdBench 8.0 Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2020, 2024 Teradata Corporation

rem ------------------------------------------------------------------------
rem The following parameters can be edited to affect the generation of views.
rem
rem TdBenchServer is the server where DBQL and Resusage Reporting will be setup.
rem 
rem TdBenchDb is the location where test metadata, views, and macros will
rem be saved. You must have read/write/create function rights to this user.
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

rem ------------------------------------------------------------------------
rem If the TdBenchPdcrDb is blank, views will only reference DBC tables.
rem 
rem If you fill in TdBenchPdcrDb, the database will be checked to exist and
rem union views will be created.
rem 
rem If you have non-standard table names, you can change the tablenames below.
rem If you want to UNION to a prior DBC database, you would probably remove the
rem _Hst suffixes from the tablenames below.
rem ------------------------------------------------------------------------

set TdBenchPdcrDb=
set TdBenchPdcrDBQLExplainTbl=DBQLExplainTbl_Hst
set TdBenchPdcrDBQLObjTbl=DBQLObjTbl_Hst
set TdBenchPdcrDBQLogTbl=DBQLogTbl_Hst
set TdBenchPdcrDBQLSqlTbl=DBQLSqlTbl_Hst
set TdBenchPdcrDBQLStepTbl=DBQLStepTbl_Hst
set TdBenchPdcrResUsageSawt=ResUsageSawt_Hst
set TdBenchPdcrResUsageScpu=ResUsageScpu_Hst
set TdBenchPdcrResUsageShst=ResUsageShst_Hst
set TdBenchPdcrResUsageSldv=ResUsageSldv_Hst
set TdBenchPdcrResUsageSpdsk=ResUsageSpdsk_Hst
set TdBenchPdcrResUsageSpma=ResUsageSpma_Hst
set TdBenchPdcrResUsageSps=ResUsageSps_Hst
set TdBenchPdcrResUsageSvdsk=ResUsageSvdsk_Hst
set TdBenchPdcrResUsageSvpr=ResUsageSvpr_Hst
