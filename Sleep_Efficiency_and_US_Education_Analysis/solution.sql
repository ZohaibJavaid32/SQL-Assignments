use campusx;

SELECT * FROM sleep_efficiency
LIMIT 5;




-- Question No : 1

SELECT * FROM sleep_efficiency
WHERE gender = 'Male'
AND Sleep_duration >= 7.5;


-- Question  No: 2

SELECT ROUND(AVG(sleep_duration  * (Deep_sleep_percentage / 100)),2) as avg_deep_sleep_time
FROM sleep_efficiency;

-- Question No : 3

WITH ranked AS (
	SELECT age,
		   light_sleep_percentage,
           deep_sleep_percentage,
		   ROW_NUMBER() OVER (ORDER BY light_sleep_percentage ASC) AS rn
	FROM sleep_efficiency
    WHERE deep_sleep_percentage BETWEEN 25 AND 45
)
SELECT age , light_sleep_percentage , deep_sleep_percentage
FROM ranked
WHERE rn BETWEEN 10 AND 30;


-- Question No: 4

SELECT ROUND(AVG(sleep_duration  * (Deep_sleep_percentage / 100)),2) as avg_deep_sleep_time,
       ROUND(AVG(sleep_duration * (Light_sleep_percentage / 100)),2) as avg_light_sleep_time,
       ROUND(AVG(sleep_duration * (REM_sleep_percentage / 100)),2) as avg_rem_sleep_time
FROM sleep_efficiency
GROUP BY exercise_frequency , smoking_status;


-- Question No: 5

SELECT ROUND(AVG(Caffeine_consumption),2) AS avg_caffeine_cosumption,
	   ROUND(AVG(sleep_duration  * (Deep_sleep_percentage / 100)),2) AS avg_deep_sleep_time,
       ROUND(AVG(Alcohol_consumption),2) AS avg_alcohol_consumption
FROM sleep_efficiency
WHERE exercise_frequency = 3
GROUP BY awakenings
ORDER BY awakenings DESC;


-- Question No : 6


SELECT ROUND(AVG(value),2) as avg_value,
	   State,
       COUNT(State) as no_of_occurance
FROM nces330_20
WHERE Year IN ('2013','2017','2021') AND Type = 'Public In-State' 
GROUP BY State
HAVING COUNT(State) BETWEEN 6 AND 10;


-- Question No : 7

SELECT State , MIN(value) as min_tuition
FROM nces330_20
WHERE Expense = 'Fees/Tuition'
AND Type = 'Public In-State'
GROUP BY State
ORDER BY min_tuition ASC
LIMIT 1;


-- Question No : 8

SELECT State , SUM(Value) as total_cost
FROM nces330_20
WHERE Type = 'Private'
	AND Year = 2021
	AND Expense IN ('Fees/Tuition' , 'Room/Board') 
GROUP BY State
ORDER BY total_cost ASC
LIMIT 1;

