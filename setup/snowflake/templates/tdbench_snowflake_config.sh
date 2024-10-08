# TdBench 8.0 Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2020, 2024 Teradata Corporation

# ------------------------------------------------------------------------
# The following parameters can be edited to affect the generation of views.
#
# TdBenchServer is the database alias of the server where test will be 
# executed and query log reporting will be setup.
#
# TdBenchDb is the location where test metadata and views will be saved.
# Snowflake identifies tables 3 components: database.schema.tablename.
# schema will default to public.
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
