SELECT * FROM artist;
SELECT * FROM canvas_size;
SELECT * FROM image_link;
SELECT * FROM museum;
SELECT * FROM museum_hours;
SELECT * FROM product_size;
SELECT * FROM subject;
SELECT * FROM work;

-- Display the painting that are not displayed in any museum 

SELECT *
FROM work
WHERE museum_id IS NULL;

-- Check if there is any museum without paintings
SELECT *
FROM museum m
WHERE m.museum_id NOT IN(
SELECT w.museum_id
FROM work w);

-- Another way

SELECT *
FROM museum m 
WHERE NOT EXISTS(
	SELECT *
	FROM work w
	where w.museum_id = m.museum_id);
	
-- Display all the paintings which are listed higher compared to the regular price

SELECT *
FROM product_size 
WHERE sale_price > regular_price

-- Display the paintings which the sale price is less than 50% of the regular price

SELECT *
FROM product_size 
WHERE sale_price < (regular_price / 2);

-- Another way 

SELECT * 
FROM product_size
WHERE sale_price < (regular_price*0.5);

-- Which canva size cost the most
				 
SELECT cs.label AS canva, ps.sale_price
FROM canvas_size cs
	JOIN (
		SELECT *
		FROM product_size
		WHERE sale_price IN(
			SELECT MAX(Sale_price)
			FROM product_size))ps
	ON cs.size_id::text = ps.size_id;

-- Remove the duplicate rows from work table

DELETE 
	FROM WORK
	WHERE ctid NOT IN (SELECT MIN(ctid)
						FROM WORK
						 Group BY work_id);

-- Another way

ALTER TABLE WORK ADD COLUMN row_num int GENERATED ALWAYS AS IDENTITY;

DELETE 
	FROM WORK
	WHERE row_num NOT IN (SELECT MIN(row_num)
						FROM WORK
						 Group BY work_id);

ALTER TABLE WORK DROP COLUMN row_num;

-- Another way

CREATE TABLE work_bkp AS
SELECT DISTINCT *
FROM work;

SELECT *
FROM work_bkp; 

TRUNCATE TABLE WORK;

INSERT INTO work 
SELECT *
FROM work_bkp;

DROP TABLE work_bkp;

-- Display the museum that has invalid values for city type text

select * from museum 
	where city ~ '^[0-9]'

-- Check for duplicates by museum_id and day and remove it

DELETE 
FROM museum_hours
WHERE ctid NOT IN (
		SELECT MIN(ctid)
		FROM museum_hours
		GROUP BY museum_id, day)

-- Display the top 10 most famous painting subjects

SELECT s.subject, count(*) AS Count_of_painting
FROM subject s
GROUP BY s.subject
ORDER BY count(*) DESC 
LIMIT 10;

-- Another way

SELECT * 
	FROM (
		SELECT s.subject,COUNT(*) as no_of_paintings
		,RANK() OVER(ORDER BY  COUNT(*) DESC) AS ranking
		FROM work w
		JOIN subject s ON s.work_id=w.work_id
		GROUP BY s.subject ) x
	WHERE ranking <= 10;

-- Display museums which are open on sunday and monday display the museum and city 

SELECT DISTINCT m.museum_id, m.name AS museum_name, m.city AS museum_city
FROM museum m
WHERE m.museum_id IN(
	SELECT DISTINCT mh.museum_id
	FROM museum_hours mh
	where day = 'Sunday'
	AND EXISTS
		(
		SELECT DISTINCT mh2.museum_id
		FROM museum_hours mh2
		WHERE mh2.museum_id = mh.museum_id AND day ='Monday'
		)
	)
	
-- Another way
	
SELECT DISTINCT m.name AS museum_name, m.city
	FROM museum_hours mh 
	JOIN museum M ON m.museum_id=mh.museum_id
	WHERE day ='Sunday'
	AND EXISTS (SELECT mh2.museum_id FROM museum_hours mh2 
				WHERE mh2.museum_id=mh.museum_id 
			    AND mh2.day='Monday');



-- Count how many museums which are open every day of the week

SELECT count(*) 
FROM (
		SELECT museum_id
		FROM museum_hours
		GROUP BY museum_id
		HAVING count(*) = 7);

-- Display museums with the most paintings

SELECT m.museum_id, m.city,m.country, top5.number_of_painting
FROM (
SELECT museum_id, count(museum_id) AS number_of_painting
FROM work
GROUP BY museum_id
ORDER BY count(museum_id) DESC
LIMIT 5
	) top5
JOIN museum m
on top5.museum_id = m.museum_id;

-- Another way

SELECT m.name AS museum, m.city,m.country,top5.no_of_painintgs
	FROM (	SELECT m.museum_id, count( w.museum_id) as no_of_painintgs
			, RANK () OVER (ORDER BY COUNT ( w.museum_id ) DESC ) AS rnk
			FROM work w
			JOIN museum m ON m.museum_id=w.museum_id
			GROUP BY m.museum_id) top5
	JOIN museum m ON m.museum_id=top5.museum_id
	WHERE top5.rnk<=5;

-- Display artists with the most number of paintings 

SELECT a.full_name, a.nationality, top5.number_of_paintings
FROM (
	SELECT w.artist_id, COUNT (w.artist_id) AS number_of_paintings , RANK() OVER (ORDER BY COUNT (w.artist_id) DESC) AS rnk
	FROM work w
	JOIN artist a
		ON a.artist_id = w.artist_id
	GROUP BY w.artist_id
)top5
	JOIN artist a
	ON top5.artist_id = a.artist_id
WHERE top5.rnk <=5;

-- Another way
SELECT a.full_name, a.nationality, top5.number_of_paintings
FROM (
	SELECT w.artist_id, COUNT(w.artist_id) AS number_of_paintings
	FROM work w
	GROUP BY w.artist_id
	ORDER BY COUNT(w.artist_id) DESC
	LIMIT 5
	) top5
		JOIN artist a
		ON top5.artist_id = a.artist_id

-- Display the less popular canva size
	

SELECT label,ranking,least3.no_of_paintings
	FROM (
		SELECT cs.size_id,cs.label, COUNT (1) AS no_of_paintings
		, dense_rank () OVER ( ORDER BY COUNT (1) ) AS ranking
		FROM work w
			JOIN product_size ps on ps.work_id=w.work_id
				JOIN canvas_size cs on cs.size_id::text = ps.size_id
		GROUP BY cs.size_id,cs.label) least3
	WHERE least3.ranking<=3;

-- Which museum is open the longest during the day

SELECT 
	*
FROM (
		SELECT m.name, m.state,mh.day, (TO_TIMESTAMP(close,'HH:MI PM' )- TO_TIMESTAMP(open, 'HH:MI AM') ) AS Duration
		, rank() OVER (ORDER BY (TO_TIMESTAMP(close,'HH:MI PM' )- TO_TIMESTAMP(open, 'HH:MI AM') )DESC)   AS rnk  
		FROM museum_hours mh
		JOIN museum m
			ON m.museum_id = mh.museum_id
) ranking
where ranking.rnk = 1;

-- Display the museum with the most number of the most popular painting

WITH style_ranking
	AS
	(
		SELECT style
		, RANK() OVER(ORDER BY COUNT(style) DESC) AS rnk
		FROM work
		GROUP BY style
	), 

CTE AS
	(
		SELECT w.museum_id, m.name, sr.style, count(*) AS no_of_paintings
		, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnking
		FROM work w	
			JOIN museum m 
				ON m.museum_id = w.museum_id
			JOIN style_ranking sr
				ON sr.style = w.style
			WHERE w.museum_id IS NOT NULL AND sr.rnk =1
			GROUP BY w.museum_id, m.name, sr.style)
SELECT *
FROM CTE
	WHERE rnking =1;
-- Display the artists which have paintings in multiple countries

WITH CTE 
	AS
 	(SELECT DISTINCT a.full_name AS artist_name , w.name AS painting, m.name AS museum
FROM work w
	JOIN artist a
		ON w.artist_id = a.artist_id	
			JOIN museum m
				ON m.museum_id = w.museum_id)

SELECT artist_name, COUNT(*)
FROM CTE
GROUP BY artist_name
HAVING COUNT(*) > 1
ORDER BY 2 DESC;

-- Display country and city with the most number of museums
WITH cte_country AS 
			(SELECT country, COUNT(*)
			, RANK () OVER ( ORDER BY COUNT (*) DESC ) AS rnk
			FROM museum
			GROUP BY country),
		cte_city AS
			(SELECT city, COUNT (*)
			, RANK () OVER (ORDER BY COUNT (1) DESC ) AS rnk
			FROM museum
			GROUP BY city)
	
	SELECT string_agg(DISTINCT country.country,', ') AS Country , string_agg(city.city,', ') AS City
	FROM cte_country country
	CROSS JOIN cte_city city
	WHERE country.rnk = 1
	AND city.rnk = 1;

-- Display top 5 countries with the highest paintings

WITH cte AS
		(SELECT m.country, COUNT (*) AS no_of_Paintings
		, RANK () OVER (ORDER BY COUNT (*) DESC ) AS rnk 
		FROM work w
		JOIN museum m ON m.museum_id=w.museum_id
		GROUP BY m.country)
	
	SELECT country, no_of_Paintings
	FROM cte 
	WHERE rnk<=5;




