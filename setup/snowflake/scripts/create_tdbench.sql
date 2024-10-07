CREATE DATABASE ${TdBenchDb};

CREATE TABLE ${TdBenchDb}.public.testtracking (
  RunId SMALLINT NOT NULL,
  TestName VARCHAR(50),
  StartTime TIMESTAMP,
  ActualStopTime TIMESTAMP,
  ReportingStopTime TIMESTAMP,
  ReportingSeconds INTEGER DEFAULT 0,
  ResultCount INTEGER,
  ErrorCount INTEGER,
  SessionCnt SMALLINT DEFAULT 1,
  RunTitle VARCHAR(100),
  RunNotes VARCHAR(8000)
);

CREATE TABLE ${TdBenchDb}.public.tdbenchinfo (
      InfoKey VARCHAR(30),
      InfoData VARCHAR(256)
);

INSERT INTO ${TdBenchDb}.public.tdbenchinfo VALUES('PREFIX','${TdBenchPrefix}');
INSERT INTO ${TdBenchDb}.public.tdbenchinfo VALUES('VERSION','${TdBenchVersion}');

-- reporting view that accesses current history 
create view ${TdBenchDb}.public.query_history as 
select tt.RunId, tt.TestName, ql.* 
from ${TdBenchDb}.public.testtracking as tt join SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY ql
on ql.start_time between tt.starttime and tt.actualstoptime;

-- Create empty table that can be maintained to hold only query log history from tests
create table ${TdBenchDb}.public.my_query_history_tbl as
select ql.* 
from ${TdBenchDb}.public.testtracking tt join SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY ql
on tt.StartTime = ql.start_time   -- will always be false
where tt.RunId = -1  -- will always be false, prevents any join
and ql.start_time = current_timestamp -- will always be false
and 0 = 1;

-- create reporting view against saved query history
create view ${TdBenchDb}.public.my_query_history as
select tt.RunId, tt.TestName, ql.*
from ${TdBenchDb}.public.testtracking as tt join ${TdBenchDb}.public.my_query_history_tbl ql
on ql.start_time between tt.starttime and tt.actualstoptime;

