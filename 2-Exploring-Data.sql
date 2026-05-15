-- Discover number of null values per column
SELECT
  SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride_id_nulls,
  SUM(CASE WHEN rideable_type IS NULL THEN 1 ELSE 0 END) AS rideable_type_nulls,
  SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS started_at_nulls,
  SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS ended_at_nulls,
  SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) AS start_station_name_nulls,
  SUM(CASE WHEN start_station_id IS NULL THEN 1 ELSE 0 END) AS start_station_id_nulls,
  SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) AS end_station_name_nulls,
  SUM(CASE WHEN end_station_id IS NULL THEN 1 ELSE 0 END) AS end_station_id_nulls,
  SUM(CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END) AS start_lat_nulls,
  SUM(CASE WHEN start_lng IS NULL THEN 1 ELSE 0 END) AS start_lng_nulls,
  SUM(CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END) AS end_lat_nulls,
  SUM(CASE WHEN end_lng IS NULL THEN 1 ELSE 0 END) AS end_lng_nulls,
  SUM(CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS member_casual_nulls
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`;

-- Explore each column separately from the left to the right

-- 1) ride_id: The length of rider_id is expected to be uniform
SELECT LENGTH(ride_id) AS length_ride_id
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
GROUP BY LENGTH(ride_id); 
-- length of ride_id is consistently 16 characters

-- 2) rideable_type: discover the kind of bikes offered
SELECT DISTINCT rideable_type as kind_of_bike
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`;
-- There are 2 types of bikes: classic and electric

-- 3) started_at, ended_at: duration of the ride
SELECT ride_id, started_at, ended_at
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
WHERE
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 1
  OR TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1440;
  -- checking if ride duration lasts for less than or equals to a minute 
  -- OR if it lasts for longer than or  equals a day
    -- TIMESTAMP is in YYYY-MM-DD hh:mm:ss UTC format

-- 4) name and id for start_station and end_station
SELECT  
  DISTINCT start_station_name AS start_station_name, 
  COUNT(*) AS start_station_count
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
GROUP BY 1
ORDER BY start_station_count DESC;
-- null values related to start_station_name amount to 1184673

SELECT
  DISTINCT end_station_name as end_station_name,
  COUNT(*) AS end_station_count
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
GROUP BY 1
ORDER BY end_station_count DESC;
-- null values related to end_station_name amount to 1243305

SELECT
  LENGTH(start_station_id) AS length_start_station_id,
  LENGTH(end_station_id) AS length_end_station_id
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
WHERE
  start_station_id IS NOT NULL
  AND end_station_id IS NOT NULL
GROUP BY 1, 2;
-- null values are observed
-- the ids for start stations and end stations are inconsistent. Nonetheless, these will be ignored considering they are not vital in our analysis.

-- 5) Latitude and Longitude of start and end stations
SELECT
  start_station_name,
  end_station_name
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
WHERE
  start_lat IS NULL
  OR start_lng IS NULL
  OR end_lat IS NULL
  OR end_lng IS NULL;
-- a total of 5535 null values are observed

-- 6) member_casual: determine membership types present 
SELECT 
  member_casual,
  COUNT(*) AS member_count
FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
GROUP BY 1;
-- 2 types discovered: member and casual
-- total sum of member_casual count equals total number of rows for the entire dataset
