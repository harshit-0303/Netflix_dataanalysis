CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	show_type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);
-- To retrieve all values.
SELECT * FROM netflix;

1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV shows
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.


-- Problem 1. Count the number of Movies vs TV Shows
SELECT show_type, COUNT(*)
FROM netflix
GROUP BY show_type;

-- Problem 2. Find the most common rating for movies and TV shows
SELECT * FROM 
(SELECT  rating , COUNT(*) AS Count
FROM netflix 
WHERE show_type = 'Movie'
GROUP BY rating
ORDER BY Count DESC
LIMIT 1) AS Top_Movie

UNION

SELECT * FROM (SELECT rating , COUNT(*) AS Count
FROM netflix 
WHERE show_type = 'TV Show'
GROUP BY rating
ORDER BY Count DESC
LIMIT 1) AS Top_TvShow;

-- Problem 3. List all movies released in a specific year (e.g., 2020)
SELECT * FROM netflix
WHERE show_type = 'Movie'
AND release_year= 2020;

-- Problem 4. Find the top 5 countries with the most content on Netflix
SELECT country , COUNT(*) AS Count
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY Count DESC
LIMIT 5;

-- Problem 5. Identify the longest movie
SELECT * FROM netflix
WHERE show_type = 'Movie' 
AND duration IS NOT NULL
ORDER BY CAST(SPLIT_PART(duration,' ',1)AS INTEGER) DESC;

-- Problem 6. Find content added in the last 5 years
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

-- Problem 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT * 
FROM netflix
WHERE director = 'Rajiv Chilaka';

-- Problem 8. List all TV shows with more than 5 seasons
SELECT * 
FROM netflix
WHERE show_type = 'TV Show' 
AND CAST(SPLIT_PART(duration,' ',1) AS INTEGER) > 5 ;

-- Problem 9. Count the number of content items in each genre
SELECT listed_in,COUNT(*)
FROM netflix
GROUP BY listed_in;

-- Problem 10. Find each year and the average numbers of content release in India on netflix.
--Return top 5 year with highest avg content release.
SELECT release_year, COUNT(*) AS Count
FROM netflix
WHERE country = 'India'
GROUP BY release_year
ORDER BY  Count DESC
LIMIT 5;

-- Problem 11. List all movies that are documentaries.
SELECT *
FROM netflix
WHERE show_type = 'Movie' 
AND listed_in LIKE '%Documentaries%';

-- Problem 12. Find all content without a director.
SELECT *
FROM netflix
WHERE director IS NULL;

-- Problem 13. Find in how many movies actor 'Salman Khan' appeared in last 10 years.
SELECT * FROM netflix
WHERE casts LIKE '%Salman Khan%' 
AND release_year  > EXTRACT(YEAR FROM CURRENT_DATE) - 10 ;

-- Problem 14.  Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10











