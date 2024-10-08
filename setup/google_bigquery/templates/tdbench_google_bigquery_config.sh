# TdBench 8.0 Copyright (c) 2010, 2011, 2013, 2015, 2016, 2018, 2019, 2020, 2024 Teradata Corporation

# ------------------------------------------------------------------------
# The following parameters can be edited to affect the generation of views.
#
# TdBenchProject is the Google Project_ID where the dataset and tables will
# be created.
#
# TdBenchDataset is the container of the tables (similar to the use of
# database on other DBMS platforms).
#
# TdBenchDb is the concatonation of project and dataset for compatibility 
# with scripts common across DBMSs as the fully qualified container of
# tables and views. 
#
# TdBenchServer is the database alias of the server where query log 
# Reporting will be setup. You need to have the DB statement executed
# prior to including setup/google_bigquery/setup_dbms.tdb
#
# Simply: We will run tests on TdBenchServer and report results in TdBenchDB
# of work done by logons with a prefix of TdBenchPrefix.
#
# ------------------------------------------------------------------------

export TdBenchProject=not_set
export TdBenchDataset=not_set
export TdBenchDb=${TdBenchProject}.${TdBenchDataset}
export TdBenchServer=not_set
