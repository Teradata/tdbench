-- NOTE: for Redshift, the database must be created in advance since the database
-- name is built into the connection URL. 

CREATE TABLE testtracking (
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

CREATE TABLE tdbenchinfo (
      InfoKey VARCHAR(30),
      InfoData VARCHAR(256)
);

INSERT INTO tdbenchinfo VALUES('PREFIX','${TdBenchPrefix}');
INSERT INTO tdbenchinfo VALUES('VERSION','${TdBenchVersion}');

-- reporting view that accesses current history 
create view query_history as 
select tt.RunId, tt.TestName, ql.* 
from testtracking as tt join stl_query ql
on ql.starttime between tt.starttime and tt.actualstoptime;

-- Create empty table that can be maintained to hold only query log history from tests
create table my_query_history_tbl as
select ql.* 
from testtracking tt join stl_query ql
on tt.StartTime = ql.starttime   -- will always be false
where tt.RunId = -1  -- will always be false, prevents any join
and ql.starttime = current_timestamp -- will always be false
and 0 = 1;

-- create reporting view against saved query history
create view my_query_history as
select tt.RunId, tt.TestName, ql.*
from testtracking as tt join my_query_history_tbl ql
on ql.starttime between tt.starttime and tt.actualstoptime;

