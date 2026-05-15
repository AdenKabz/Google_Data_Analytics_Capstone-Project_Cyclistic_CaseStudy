-- Create a new table with clean data
-- Create new columns of "month" and "day_of_the_week"
-- Obtain ride length in minutes
-- Remove null values

CREATE TABLE `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025_cleaned` AS(
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    ride_length_in_minutes,
    FORMAT_DATE('%B', started_at) AS month,
    FORMAT_DATE('%A', started_at) AS day_of_the_week,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`
  JOIN 
    (SELECT 
      ride_id,
      TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_in_minutes
    FROM `tibachap.Divvy_tripdata.Cyclistic_tripdata_2025`)
    USING (ride_id)
  WHERE 
    ride_length_in_minutes > 1 AND ride_length_in_minutes < 1440 AND
    start_station_name IS NOT NULL AND
    start_station_id IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_station_id IS NOT NULL AND 
    end_lat IS NOT NULL AND 
    end_lng IS NOT NULL
);
