-- Combine data from Jan to Dec 2025 into one table called Cyclistic_tripdata_2025

CREATE TABLE tibachap.Divvy_tripdata.Cyclistic_tripdata_2025 AS(
  SELECT * FROM `tibachap.Divvy_tripdata.Jan-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Feb-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Mar-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Apr-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.May-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Jun-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Jul-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Aug-2025`
  UNION ALL 
  SELECT * FROM `tibachap.Divvy_tripdata.Sep-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Oct-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Nov-2025`
  UNION ALL
  SELECT * FROM `tibachap.Divvy_tripdata.Dec-2025`
);
