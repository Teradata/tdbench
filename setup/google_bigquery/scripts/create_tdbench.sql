-- NOTE - you must create the dataset referenced by ${TdBenchDb} from tdbench_google_bigquery_config  (.sh or .bat)
-- it is easiest to do that from BigQuery Studio or using the os command: bq mk --dataset xxxx.yyyy
-- where xxxx is the project id used in the URL to logon, and yyyy is the dataset name

CREATE TABLE ${TdBenchDb}.testtracking (
  RunId SMALLINT NOT NULL,
  TestName STRING(50),
  StartTime TIMESTAMP,
  ActualStopTime TIMESTAMP,
  ReportingStopTime TIMESTAMP,
  ReportingSeconds INTEGER DEFAULT 0,
  ResultCount INTEGER,
  ErrorCount INTEGER,
  SessionCnt SMALLINT DEFAULT 1,
  RunTitle STRING(100),
  RunNotes STRING(8000)
);

CREATE TABLE ${TdBenchDb}.tdbenchinfo (
      InfoKey STRING(30),
      InfoData STRING(256)
);

INSERT INTO ${TdBenchDb}.tdbenchinfo VALUES('VERSION','${TdBenchVersion}');

-- reporting view that accesses current history - Use constraint against RunId
-- in query text, include comment string giving query name, e.g. select /* tdb=query123 */ ...

create view ${TdBenchDb}.query_history as 
select tt.RunId, tt.TestName,
  case
    when strpos(ql.query, 'tdb=') > 0
    then substr(ql.query, strpos(ql.query, 'tdb=') + 4, strpos(substr(ql.query, strpos(ql.query, 'tdb=') + 4), ' '))
    else 'NA'
  end as QueryName,
  case
    when ql.end_time between tt.StartTime and tt.ReportingStopTime then true
    else false
  end as FinishInTime,
  timestamp_diff(ql.end_time, ql.start_time, millisecond) / 1000 as RunSecs,
  timestamp_diff(ql.end_time, ql.start_time, millisecond) as RunSecs_ms,
  ql.total_slot_ms,
  round(safe_divide(ql.total_slot_ms, (timestamp_diff(ql.end_time, ql.start_time, millisecond))), 4) as avg_slots,
  ql.total_bytes_billed,
  round(ql.total_bytes_billed / pow(1024, 4) * 5, 4) as total_billed,
  ql.cache_hit as results_cache,
  (
    select
      slot_capacity
    from
      `region-us`.INFORMATION_SCHEMA.RESERVATION_CHANGES_BY_PROJECT
    where
      change_timestamp > timestamp '2021-01-01'
    order by
      change_timestamp desc
    limit 1
   ) as reserved_slot_capacity,
  case
    when ql.reservation_id is null then true
    else false
  end as on_demand,
  cast(ql.creation_time as datetime) as creation_time,
  cast(ql.start_time as datetime) as start_time,
  cast(ql.end_time as datetime) as end_time,
  ql.job_id,
  ql.project_id,
  ql.query
from
  `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT ql
inner join
  ${TdBenchDb}.testtracking tt
  on ql.end_time between tt.StartTime and tt.ActualStopTime
;

