/*---
c:/utl/jnr-jenner-analytics-proc-sql-and-datastep-joins-on-bigint-keys.sas
 ---*/

Jenner Analytics proc sql and datastep joins on bigint keys

 PROBLEM:
   Given two CSVs represemting SDTM datasets, dm and ae, joun on usubjid has bigintdatatype.
   Join dm to ae and subset for females using proc sql and dataset merge

 Process
   1  Convert CSVs dm(demographics), and ae(adverse events) to Jenner parquet files
   2  Use Proc sql and a datastep merge to jon dm to ae

 WHAT I WANT.
 NOTE:  Join dm and ae on usubjid which has dataype bigint using proc sql.

   proc sql;
   drop table prq.dmae;
   create
     table prq.dmae as
   select
     l.usubjid
    ,l.site
    ,l.age
    ,l.sex
    ,r.aeterm
  from
    prq.dm as l, prq.ae as r
  where
    l.usubjid = r.usubjid  /*--- BIGINTS ---*/
    and l.sex='F'
  ;quit;

  CONTENTS
    1 Create Input
    2 Proc sql solution
    3 Datastep solution

/******************************************************************************************************************/
/* 1. CREATE INPUT DM AND CM WITH BIGINT USUSJID                                                                  */
/******************************************************************************************************************/

%utlfkil(d:/csv/dm.csv);
%utlfkil(d:/csv/ae.csv);

/*---CLEAR PARQUET LIBRARY ---*/
libname prq parquet "d:/parquet";
proc datasets lib=prq kill;
run;quit;

/*--- CREATE DM AND AE CSVS ---*/
filename ft15f001 "d:/csv/dm.csv";
parmcards4;
usubjid,site,subjid,dm_domain,age,ageu,sex,date
9091119254740991,909111,40991,DM,67,YEARS,M,2092-03-15
9091119254740993,909111,40993,DM,65,YEARS,M,2091-07-01
9091119254740995,909111,40995,DM,47,YEARS,F,2090-11-20
9091119254740997,909111,40997,DM,43,YEARS,F,2003-01-10
9091119254741999,909111,41999,DM,57,YEARS,M,2003-01-10
;;;;
run;

filename ft15f001 "d:/csv/ae.csv";
parmcards4;
usubjid,site,subjid,ae_domain, edy,estdy,eendy,aeterm
9091119254740991,909111,40991,DM,647,589,589,ABNORMALBEHAVIOUR
9091119254740993,909111,40993,DM,792,639,700,ACUTEPSYCHOSIS
9091119254740995,909111,40995,DM,639,422,478,AFFECTIVEDISORDER
9091119254740997,909111,40997,DM,715,279,288,AGGRESSION
9091119254741999,909111,41999,DM,693,685,818,AFFECTLABILITY
;;;;
run;

/******************************************************************************************************************/
/* CONVERT TO PARQUET FILES INSTEAD OF SAS SAS7BDATS                                                              */
/* NOT THE USE OF A LIBRARY OF PARQUET FILES. LIKE SAS LIBRARIES, LIBNAME                                         */
/******************************************************************************************************************/

data prq.dm;
set "d:/csv/dm.csv";
run;

data prq.ae;
set "d:/csv/ae.csv";
run;

proc print data=prq.ae;
run;

proc print data=prq.dm;
run;

/******************************************************************************************************************/
/*  LIST: 15:20:57                                                                                                */
/*    Obs           usubjid    site  subjid  ae_domain   edy  estdy  eendy             aeterm                     */
/*                                                                                                                */
/*      1  9091119254740991  909111   40991  DM          647    589    589  ABNORMALBEHAVIOUR                     */
/*      2  9091119254740993  909111   40993  DM          792    639    700  ACUTEPSYCHOSIS                        */
/*      3  9091119254740995  909111   40995  DM          639    422    478  AFFECTIVEDISORDER                     */
/*      4  9091119254740997  909111   40997  DM          715    279    288  AGGRESSION                            */
/*      5  9091119254741999  909111   41999  DM          693    685    818  AFFECTLABILITY                        */
/*                                                                                                                */
/*    Obs           usubjid    site  subjid  dm_domain  age   ageu  sex        date                               */
/*                                                                                                                */
/*      1  9091119254740991  909111   40991  DM          67  YEARS  M    2092-03-15                               */
/*      2  9091119254740993  909111   40993  DM          65  YEARS  M    2091-07-01                               */
/*      3  9091119254740995  909111   40995  DM          47  YEARS  F    2090-11-20                               */
/*      4  9091119254740997  909111   40997  DM          43  YEARS  F    2003-01-10                               */
/*      5  9091119254741999  909111   41999  DM          57  YEARS  M    2003-01-10                               */
/******************************************************************************************************************/

 /******************************************************************************************************************/
 /*  LOG                                                                                                           */
 /******************************************************************************************************************/
NOTE: Copyright (c) 2026 Jenner Analytics Ltd., London, England.
NOTE: Jenner v1.5.79 (build v1.5.79+99efef4c00.20260921T112419Z.x86_64-pc-windows-msvc)
      Licensed to Roger DeAngelis, Serial 3BF7B3E6.
NOTE: DATA _null_

autexec started.

NOTE: DATA elapsed:
  wall  0.01 seconds
  cpu   0.01 seconds
NOTE: DATA _null_

LOG:  12:56:11
NOTE: DATA _null_ completed. Output written to FILE PRINT
NOTE: Option SASAUTOS changed to c:/otojnr.
NOTE: Library WORKX assigned path=d:\wpswrkx.
NOTE: DATA _null_

NOTE: Reading from fileref c:/jnr/runsas_selection.sas (c:/jnr/runsas_selection.sas)
    1
    2 /******************************************************************************************************************/
    3 /* CREATE INPUT DM AND CM WITH BIGINT USUSJID                                                                    */
    4 /******************************************************************************************************************/
    5
    6 %utlfkil(d:/csv/dm.csv);
    7 %utlfkil(d:/csv/ae.csv);
    8
    9 /*---CLEAR PARQUET LIBRARY ---*/
   10 libname prq parquet "d:/parquet";
   11 proc datasets lib=prq kill;
   12 run;quit;
   13
   14 /*--- CREATE DM AND AE CSVS ---*/
   15 filename ft15f001 "d:/csv/dm.csv";
   16 parmcards4;
   17 usubjid,site,subjid,dm_domain,age,ageu,sex,date
   18 9091119254740991,909111,40991,DM,67,YEARS,M,2092-03-15
   19 9091119254740993,909111,40993,DM,65,YEARS,M,2091-07-01
   20 9091119254740995,909111,40995,DM,47,YEARS,F,2090-11-20
   21 9091119254740997,909111,40997,DM,43,YEARS,F,2003-01-10
   22 9091119254741999,909111,41999,DM,57,YEARS,M,2003-01-10
   23 ;;;;
   24 run;
   25
   26 filename ft15f001 "d:/csv/ae.csv";
   27 parmcards4;
   28 usubjid,site,subjid,ae_domain, edy,estdy,eendy,aeterm
   29 9091119254740991,909111,40991,DM,647,589,589,ABNORMALBEHAVIOUR
   30 9091119254740993,909111,40993,DM,792,639,700,ACUTEPSYCHOSIS
   31 9091119254740995,909111,40995,DM,639,422,478,AFFECTIVEDISORDER
   32 9091119254740997,909111,40997,DM,715,279,288,AGGRESSION
   33 9091119254741999,909111,41999,DM,693,685,818,AFFECTLABILITY
   34 ;;;;
   35 run;
   36
   37 /******************************************************************************************************************/
   38 /* CONVERT TO PARQUET FILES INSTEAD OF SAS SAS7BDATS                                                              */
   39 /* NOT THE USE OF A LIBRARY OF PARQUET FILES. LIKE SAS LIBRARIES, LIBNAME                                         */
   40 /******************************************************************************************************************/
   41
   42 data prq.dm;
   43 set "d:/csv/dm.csv";
   44 run;
   45
   46 data prq.ae;
   47 set "d:/csv/ae.csv";
   48 run;
   49
   50 proc print data=prq.ae;
   51 run;
   52
   53 proc print data=prq.dm;
   54 run;

NOTE: Read 54 rows from c:/jnr/runsas_selection.sas.
NOTE: DATA elapsed:
  wall  0.03 seconds
  cpu   0.03 seconds
NOTE: DATA _null_

autexec completed.

NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: Library PRQ assigned path=d:/parquet.
NOTE: PROC DATASETS library=PRQ

NOTE:
                       Directory

       Libref             PRQ
       Engine             PARQUET
       Physical Name      d:/parquet

       (no members)

NOTE: KILL option deleted 0 member(s) from library PRQ.
NOTE: Fileref FT15F001 assigned to d:/csv/dm.csv.
NOTE: PARMCARDS4 wrote 6 record(s) to fileref FT15F001.
NOTE: Fileref FT15F001 assigned to d:/csv/ae.csv.
NOTE: PARMCARDS4 wrote 6 record(s) to fileref FT15F001.
NOTE: DATA prq.dm


NOTE: Read 5 rows from d:/csv/dm.csv.
NOTE: The data set PRQ.DM has 5 observations and 8 variables.
NOTE: DATA elapsed:
  wall  0.02 seconds
  cpu   0.02 seconds
NOTE: DATA prq.ae


NOTE: Read 5 rows from d:/csv/ae.csv.
NOTE: The data set PRQ.AE has 5 observations and 8 variables.
NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: PROC PRINT data=prq.ae

NOTE: PROC PRINT completed: 5 observations printed, 8 variables
NOTE: PROC PRINT data=prq.dm

NOTE: PROC PRINT completed: 5 observations printed, 8 variables

/******************************************************************************************************************/
/* 2. PROC SQL SOLUTION                                                                                           */
/******************************************************************************************************************/

libname prq "d:/parquet";

proc delete data=prq.dmae;
run;

proc sql;
   drop table prq.dmae;
   create
     table prq.dmae as
   select
     l.usubjid
    ,l.site
    ,l.age
    ,l.sex
    ,r.aeterm
  from
    prq.dm as l, prq.ae as r
  where
    l.usubjid = r.usubjid  /*--- BIGINTS ---*/
    and l.sex='F'
  ;quit;

proc print data=prq.dmae;
    title just=l "Proc SQL join";
run;

/*******************************************************************************************************************/
/* LIST: 13:02:42                                                                                                  */
/*                                                      Proc SQL join                                              */
/*   Obs           usubjid    site  age  sex             aeterm                                                    */
/*                                                                                                                 */
/*     1  9091119254740995  909111   47  F    AFFECTIVEDISORDER                                                    */
/*     2  9091119254740997  909111   43  F    AGGRESSION                                                           */
/*******************************************************************************************************************/

/******************************************************************************************************************/
/* LOG                                                                                                            */
/******************************************************************************************************************/

NOTE: Copyright (c) 2026 Jenner Analytics Ltd., London, England.
NOTE: Jenner v1.5.79 (build v1.5.79+99efef4c00.20260921T112419Z.x86_64-pc-windows-msvc)
      Licensed to Roger DeAngelis, Serial 3BF7B3E6.
NOTE: DATA _null_

autexec started.

NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: DATA _null_

LOG:  13:02:42
NOTE: DATA _null_ completed. Output written to FILE PRINT
NOTE: Option SASAUTOS changed to c:/otojnr.
NOTE: Library WORKX assigned path=d:\wpswrkx.
NOTE: DATA _null_

NOTE: Reading from fileref c:/jnr/runsas_selection.sas (c:/jnr/runsas_selection.sas)
    1 libname prq "d:/parquet";
    2
    3 proc sql;
    4    drop table prq.dmae;
    5    create
    6      table prq.dmae as
    7    select
    8      l.usubjid
    9     ,l.site
   10     ,l.age
   11     ,l.sex
   12     ,r.aeterm
   13   from
   14     prq.dm as l, prq.ae as r
   15   where
   16     l.usubjid = r.usubjid  /*--- BIGINTS ---*/
   17     and l.sex='F'
   18   ;quit;
   19
   20 proc print data=prq.dmae;
   21     title just=l "Proc SQL join";
   22 run;

NOTE: Read 22 rows from c:/jnr/runsas_selection.sas.
NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: DATA _null_

autexec completed.

NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: Library PRQ assigned path=d:/parquet.
NOTE: PROC SQL

ERROR: Table prq.dmae does not exist.
NOTE: Table prq.dmae created.
NOTE: PROC SQL statement used.
NOTE: PROC PRINT data=prq.dmae

NOTE: PROC PRINT completed: 2 observations printed, 5 variables


/******************************************************************************************************************/
/* 3. DATASTEP SOLUTION                                                                                           */
/******************************************************************************************************************/

libname prq "d:/parquet";

proc delete data=prq.dmae;
run;

data prq.dmae;
  merge prq.dm prq.ae;
  by usubjid;
  if sex='F';
  drop ageu ae_domain dm_domain subjid;
;quit;

proc print data=prq.dmae;
    title just=l "Datastep join";
run;

/******************************************************************************************************************/
/* LIST: 13:23:07                                                                                                 */
/*                                                      Datastep join                                             */
/*   Obs           usubjid    site  age  sex        date   edy  estdy  eendy             aeterm                   */
/*                                                                                                                */
/*     1  9091119254740995  909111   47  F    2090-11-20   639    422    478  AFFECTIVEDISORDER                   */
/*     2  9091119254740997  909111   43  F    2003-01-10   715    279    288  AGGRESSION                          */
/******************************************************************************************************************/

/******************************************************************************************************************/
/* LOG                                                                                                            */
/******************************************************************************************************************/

NOTE: Copyright (c) 2026 Jenner Analytics Ltd., London, England.
NOTE: Jenner v1.5.79 (build v1.5.79+99efef4c00.20260921T112419Z.x86_64-pc-windows-msvc)
      Licensed to Roger DeAngelis, Serial 3BF7B3E6.
NOTE: DATA _null_

autexec started.

NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: DATA _null_

LOG:  13:23:07
NOTE: DATA _null_ completed. Output written to FILE PRINT
NOTE: Option SASAUTOS changed to c:/otojnr.
NOTE: Library WORKX assigned path=d:\wpswrkx.
NOTE: DATA _null_

NOTE: Reading from fileref c:/jnr/runsas_selection.sas (c:/jnr/runsas_selection.sas)
    1
    2 libname prq "d:/parquet";
    3
    4 proc delete data=prq.dmae;
    5 run;
    6
    7 data prq.dmae;
    8   merge prq.dm prq.ae;
    9   by usubjid;
   10   if sex='F';
   11   drop ageu ae_domain dm_domain subjid;
   12 ;quit;
   13
   14 proc print data=prq.dmae;
   15     title just=l "Datastep join";
   16 run;
   17

NOTE: Read 17 rows from c:/jnr/runsas_selection.sas.
NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: DATA _null_

autexec completed.

NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: Library PRQ assigned path=d:/parquet.
NOTE: PROC DELETE datasets=prq.dmae

NOTE: Deleting PRQ.DMAE (memtype=DATA).
NOTE: 1 dataset(s) deleted.
NOTE: DATA prq.dmae

NOTE: Stream 1 processed 5 rows, max BY-group size: 1 (O(1) memory verified)
NOTE: Stream 2 processed 5 rows, max BY-group size: 1 (O(1) memory verified)

NOTE: The data set PRQ.DMAE has 2 observations and 9 variables.
NOTE: DATA elapsed:
  wall  0.00 seconds
  cpu   0.00 seconds
NOTE: PROC PRINT data=prq.dmae

NOTE: PROC PRINT completed: 2 observations printed, 9 variables

/*--- END ---*/
