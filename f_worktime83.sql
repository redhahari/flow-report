CREATE OR REPLACE FUNCTION f_worktime83(
    t_start timestamp without time zone,
    t_end timestamp without time zone)
  RETURNS interval AS
$BODY$

SELECT (count(*) - 1) * interval '1 min' -- fix off-by-one error
FROM   (
   SELECT $1 + generate_series(0, (extract(epoch FROM $2 - $1)/60)::int)
             * interval '1 min' AS t
   ) sub
WHERE  
t::time between '00:45'::time and '04:45'::time
or t::time between '05:01'::time and '12:00'::time
or t::time between '13:01'::time and '16:00'::time
or t::time between '16:16'::time and '18:15'::time
or t::time between '20:01'::time and '23:59'::time
