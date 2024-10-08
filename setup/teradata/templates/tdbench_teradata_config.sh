# TdBench 8.0 Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2020, 2024 Teradata Corporation

# ------------------------------------------------------------------------
# The following parameters can be edited to affect the generation of views.
#
# TdBenchServer is the database alias of the server where DBQL and Resusage 
# Reporting will be setup. You need to have the DB statement executed
# prior to including setup/teradata/setup_dbms.tdb
#
# TdBenchDb is the location where test metadata, views, and macros will 
# be saved. You must have read/write/create function rights to this user. 
#
# The TdBenchPrefix is the username prefix of the worker logons, used to 
# distinguish tdbench workload from competing workload in reporting views.
# For example, the benchmark user might be test_benchmark and the tactical
# workers might be test_tac_user01, test_tac_user02, ... and the reporting
# workers might be test_rpt_user01, test_rpt_user02, ... In the reporting
# views, any usage by logon IDs beginning with 'test%' would be labeled
# benchmark usage and the rest considered "noise". 
#
# Simply: We will run tests on TdBenchServer and report results in TdBenchDB
# of work done by logons with a prefix of TdBenchPrefix.
#
# ------------------------------------------------------------------------

export TdBenchServer=not_set
export TdBenchDb=not_set
export TdBenchPrefix=not_set

# ------------------------------------------------------------------------
# If the TdBenchPdcrDb is blank, views will only reference DBC tables.
# The normal name for the TdBenchPdcrDb is PDCRINFO. If you fill in 
# TdBenchPdcrDb, the database will be checked to exist and  union views 
# will be created.
#
# If you have non-standard table names, you can change the tablenames below.
# If you want to UNION to a prior DBC database, you would probably remove the
# _Hst suffixes from the tablenames below which are usually used in PDCR.
#
# ------------------------------------------------------------------------

export TdBenchPdcrDb=
export TdBenchPdcrDBQLExplainTbl=DBQLExplainTbl_Hst
export TdBenchPdcrDBQLObjTbl=DBQLObjTbl_Hst
export TdBenchPdcrDBQLogTbl=DBQLogTbl_Hst
export TdBenchPdcrDBQLParamTbl=DBQLParamTbl_Hst
export TdBenchPdcrDBQLSqlTbl=DBQLSqlTbl_Hst
export TdBenchPdcrDBQLStepTbl=DBQLStepTbl_Hst
export TdBenchPDCRDBQLUtilityTbl=DBQLUtilityTbl_Hst
export TdBenchPdcrResUsageSawt=ResUsageSawt_Hst
export TdBenchPdcrResUsageScpu=ResUsageScpu_Hst
export TdBenchPdcrResUsageShst=ResUsageShst_Hst
export TdBenchPdcrResUsageSldv=ResUsageSldv_Hst
export TdBenchPdcrResUsageSmhm=ResUsageSmhm_Hst
export TdBenchPdcrResUsageSpdsk=ResUsageSpdsk_Hst
export TdBenchPdcrResUsageSpma=ResUsageSpma_Hst
export TdBenchPdcrResUsageSps=ResUsageSps_Hst
export TdBenchPdcrResUsageSvdsk=ResUsageSvdsk_Hst
export TdBenchPdcrResUsageSvpr=ResUsageSvpr_Hst
