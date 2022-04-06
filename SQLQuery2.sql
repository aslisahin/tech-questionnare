SELECT DISTINCT
    country,
    MEDIAN(score) OVER (PARTITION BY daily_vaccinates) score_median
FROM country_vacc;

SELECT p.date, COALESCE(a.value, 0) value
  FROM
(
  SELECT  date
    FROM
  (
    SELECT MEDIAN(daily_vacc) median_value
      FROM tableA
     GROUP BY country
  ) q CROSS JOIN tableb b 
   WHERE b.date BETWEEN q.min_date AND q.max_date
) p LEFT JOIN TableA a
    ON p.grp_no = a.grp_no 
   AND p.date = a.date

    
update country_vacc
set daily_vacc = '0'
WHERE daily_vacc = 'NaN'