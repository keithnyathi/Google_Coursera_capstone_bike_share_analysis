- # Introduction
---------------------------------------------------------------------------
## Cyclistic Bike-Share Case Study: Maximizing Annual Memberships

### 📌 Executive Summary & Introduction
As a junior data analyst working on the marketing analyst team at **Cyclistic**—a major, fictional bike-share program—the core business goal is clear: **maximize the number of annual memberships**. Historical financial data proves that annual members are significantly more profitable than casual riders. Rather than launching a broad, expensive marketing campaign to target completely new consumers, Cyclistic’s strategic objective is to design targeted digital marketing tactics to **convert existing casual riders into loyal, annual members.**

To unlock these conversions, this end-to-end case study analyzes **5.7+ million rows of raw historical trip data** to answer a vital operational question: **How exactly do casual riders and annual members use Cyclistic bikes differently?** By uncovering distinct, data-driven behavioral archetypes—such as the weekday commuting "Fingerprint" of members versus the weekend leisure "Surge" of casuals—this project delivers actionable recommendations to guide future marketing strategies. Furthermore, a rigorous data quality audit isolated significant digital product failure modes (including hardware timeouts and lock friction) to safeguard the mathematical integrity of the final business insights.

### 🛠️ Technical Stack & Data Pipeline
* **Data Source:** Coursera Goole Professional Certificate Capstone Project [Cyclistic Database](https://divvy-tripdata.s3.amazonaws.com/index.html)
* **Storage & Heavy Engineering:** PostgreSQL (Data aggregation, anomaly isolation, and temporal analysis)
* **Diagnostic Visualization:** Python / Jupyter Notebooks (`pandas`, `matplotlib`, `seaborn`)
* **Interactive Business Intelligence:** [Tableau Public Dashboard](https://public.tableau.com/views/BikeRideGoogleProject/Dashboard2?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

 # 🧐 Questions Answered
  1. *What is the average ride length between casual riders and member riders?*
  2.  *What is the most popular day or days for the casual vs the annual members?*
  3.  *What is the average ride_length by day of the week?*
  4.  *Which of the riders casual or member ride the most during the day (At what hours of the day do the riders (filtered by type) ride their bikes?)?*
  5.  *What is the most popular month for casual and member riders?*
  6.  *Among casual riders, members , what is the most popular bike type?*
  7.  *Which station is most preferred by casual riders and which is preferred by members*
  8.  *How many ride trips were less than  a minute long and also did not have any end station data?*
  9.   *How many rides can be considered as rides left undocked and locked only when they had passed 24hrs
  (system timeout)?*

  
# 🛠️ Tools used
  -----------------------------------------------------------------------------
  - For this analysis i utilised all four of the tools that i learned throughout the duration of the *Google Data Analyst Professional Course* in Coursera.
    1. **Data Cleaning With Excel and Power Query**
    2. **Storage and Analysis Using SQL**
    3. **Data Quality Audit Using Python**
    4. **Version Control Using Git & Github**
    5. **Interactive Visualizations Using Tableau**
  - ## Data Cleaning with Microsoft Excel and Power Query
      ### Using Excel
     - Before I could start any analysis,I felt I had to first understand the data structure and the type of data that i was dealing with, I wanted to first see the rows,columns etc to get a basic comprehension. I used excel to do some basic data cleaning pracitce with one of the spreadsheets (1/12 sheets) this way i could then replicate the cleaning on all the spreadsheets
      ### Using Power Query
    - In power query, I first combined all the spreadsheets into one, then proceeded to do the major data cleaning process such as:
    -  Changing the date formats for the started_at and ended_at columns
    -  Creating new calculated columns for ride_length(ride end time - ride start time) formatted to total mins
    -  Creating day of the week column for the weekly temporal analyis.
    -  Adding another column that filtered the data based on whether the ride length exceeded 1440 mins or 24 hours (is_system_timeout) 
    -  In addition to that, I added a much more word based weekday column to make it easier for analysis in the preceeding steps.
    -  Now that i felt like the data made sense for analysis, before moving to SQL, I separated the combined spreadsheets in power query by filtering for the month in the power query source.name column and then saved the spreadsheets for Jan-Dec 2025.
       
       ![alt text](image.jpg) 
        
  - ## Analysis of behavioral disparity using POSTGRESQL via VS CODE
      - In SQL I attempted to give an answer as to how the casual riders and the annual members use Cyclistic bikes differently and simultaneously draw insights from the data that could help in converting casual riders into annual members for the Cyclistic company.
      - Before I could begin the analysis, I created the database for my data using postgreSQL and then created the table schema for the data for the combined 12 months.
 1.  In order to make sure I did not have any duplicates that could lead to postgresql crashing or giving out an error, I filtered the data from each spreadsheet and funelled it into a temp table and then only inserted distinct values from each spreadsheet into the combined spreadsheet. Below is the run down of all my subsequent steps in the analysis:
        ```sql
        -- Create table to load the excel csvs
        
        CREATE TABLE trips_2025 (
            ride_id VARCHAR(50) PRIMARY KEY,
            rideable_type VARCHAR(50),
            started_at TIMESTAMP,
            ended_at TIMESTAMP,
            ride_length DECIMAL(15,4),
            day_of_week INT,
            weekday VARCHAR(100),
            start_station_name VARCHAR(255),
            start_station_id VARCHAR(100),
            end_station_name VARCHAR(255),
            end_station_id VARCHAR(100),
            start_lat  DECIMAL(10, 8),
            start_lng DECIMAL(11,8),
            end_lat DECIMAL(10,8),
            end_lng DECIMAL(11,8),
            memember_casual VARCHAR(20),
            is_system_timeout BOOLEAN
        
        
        )
        
        COPY trips_2025
        FROM 'C:\\Users\\Public\\Downloads\\january_data.csv' 
        WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
        
        /*Start Here*/
        COPY trips_2025
        FROM 'C:\\Users\\Public\\Downloads\\february_data.csv' 
        WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
        
        
        
        /* In order to filter for any duplicates that may have been missed in the excel data cleaning i use a temp table 
            to first out the data in the temp table then insert only the distinct values into the trips_2025 table*/
        
        
        --create temp table to store the each month's table 
        CREATE TABLE trips_temp AS SELECT * FROM trips_2025 WITH NO DATA;
        
        -- Copy the month's csv into temp table
        COPY trips_temp
        FROM 'C:\\Users\\Public\\Downloads\\december_data.csv' 
        WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
        
        -- Insert only the unique values from month's table into the trips 2025 schema
        INSERT INTO trips_2025
        SELECT DISTINCT ON(ride_id) * FROM trips_temp
        ON CONFLICT (ride_id) DO NOTHING;
        
        
        --Empty all the data in trips_temp table
        TRUNCATE TABLE trips_temp; 
        
        
        -- Altering name of the column that i made a mistake on
        ALTER TABLE trips_2025
        RENAME COLUMN memember_casual TO member_casual
        ```
        
   1. Checked to ensure data completeness by counting all the rows to see if they matched or were close(if duplicates that excel might have missed removed) to the original data.
        ```sql
          -- Checking the table for any errors in data migration via counting

          -- Query will show number of rides grouped by month 
          SELECT 
              EXTRACT(MONTH FROM started_at) AS month_date,
              CASE 
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 1 THEN 'January'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 2 THEN 'February'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 3 THEN 'March'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 4 THEN 'April'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 5 THEN  'May'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 6 THEN 'June'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 7 THEN 'July'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 8 THEN 'August'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 9 THEN 'September'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 10 THEN 'October'
                  WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 11 THEN 'November'
                  ELSE 'December'
              END AS months,
              COUNT(*)
          FROM trips_2025
          GROUP BY
              month_date
          ORDER BY
              month_date
      
      
        ```
### Analysis


  1. **What is the variance in average trip duration when contrasting annual members against casual riders?**   
      *🔍Methodology*
      - *Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute*
      - *Calculated the average ride length grouped by member type*
      - *Ordered the results by the average ride length*
      ```sql
      SELECT
      ROUND(AVG(ride_length),2) AS average_ride_length,
      member_casual AS rider_type
      FROM trips_2025
      WHERE
      -- Filter out rides where the bike rider didn't dock the bike 
      -- Filter out rides where the bike was only unlocked for a few seconds and then redocked
          is_system_timeout != TRUE
          AND ride_length > 1
      GROUP BY
      -- Group by member type 
          member_casual
      ORDER BY
          average_ride_length DESC
        ```
     *📊Key Metrics*  
        - *Casual members on average ride for longer times (19.93 minutes) when compared to annual members who ride at an average of 12,19 minutes*

     *💡Data Interpretation & Business Takeaway*  
        - *Although member riders account for the most frequent type of riders from the data provided,casual riders  have the highest average riding time as the riders ride mostly for leisure and annual members ride the bikes most likely as a transport means to and from work or other engagements that may not necessarily need them ride for a long time*
     
     
  2. **Which day or days of the week exhibit peak ridership volume when contrasting annual members against casual riders?**
     
     *🔍Methodology*
     - *Filtered out rides exceeding 24 hours ( > 1440 minutes) and those rides that had ride length less than 1 minute*
     - *Calculated using aggregation method COUNT, the number of rides taken during the 7 days of the week.*
     - *Grouped the results by day of the week and the rider type(member or casual)*
     - *Ordered the results by the number of rides with the most rides first going down*
     
     ```sql
      SELECT
        COUNT(ride_id) AS number_of_rides,
        weekday,
        member_casual
       FROM trips_2025
       WHERE
           is_system_timeout != TRUE
           AND ride_length > 1
       GROUP BY
           weekday,
           member_casual
       ORDER BY
           number_of_rides DESC
      ```
     *📊Key Metrics*   
     - *The query shows that for annual members Mondays to Fridays are the days that see the highest volume of bike traffic
      When it comes to the casual riders, weekends (Saturday and Sunday) are the days with the most bike traffic*

     *💡Data Interpretation & Business Takeaway*  
     - *Annual members show an increased and more visible usage of the bikes for days (Mon - Friday) which are work days on the calendar further suggesting that annual members ride the bike as a transport means to and from work or they use the bikes for activities that require repeated attendance during the week*
     - *Casual riders also have a high frequency of bike riding on weekends than the rest of the weekdays, hinting at them using the bikes for leisure related purposes (traveling tourists, one time users, etc)*
     

 3. **How do mean trip durations fluctuate across the days of the week when comparing annual members and casual riders?**   

    *🔍Methodology*
    - *Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute*
    - *Calculated the average ride length grouped by member type and weekday*
    - *Ordered the results by the average ride length in descending order*
    
    ```sql
    SELECT
    ROUND(AVG(ride_length),2) AS Average_ride_time,
    weekday,
    member_casual AS rider_type
    FROM trips_2025
    WHERE
        is_system_timeout != TRUE
        AND ride_length > 1
    GROUP BY
        weekday,
        member_casual
    ORDER BY
        Average_ride_time DESC
    ```
    *📊Key Metrics*   
    - *Casual riders have higher average riding times during the entire 7 days of the week, however Saturday and Sunday are the days where they ride longest in comparison to the rest of the week*
    - *Annual members take up the bottom 7 positions as they don't ride as long on average, for members as well Saturday and Sunday are the days when they ride longest*

    *💡Data Interpretation & Business Takeaway*    
     - *Since the casual riders have a noticeably higher average ride time , their influence is visible on the average ride time by day of the week, weekends (Sat and Sun) have the highest average ride time due to casual riders riding the most during the weekend because most of the leisure bike riding, city exploration etc is done commonly during the weekends when the users aren't working.*
     - *The notion of riding during the weekends not for work related engagements but for relaxation,exploring,leisure proves true even with annual members as their average ride time also peaks during the weekend when they're likely not working.*
    

4. **Which customer demographic dominates daily ridership volume?**     
    *🔍Methodology*
    - *Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute*
    - *Extracted the hour from the started_at column as ride_hour*
    - *Filtered for specific hours during the day relevant to the question*
    - *Ordered the results by the the number of rides*
   
   ```sql
   SELECT
    EXTRACT(HOUR FROM started_at) AS ride_hour,
    member_casual AS rider_type,
    COUNT(ride_id) AS total_rides
   FROM trips_2025
   WHERE
       is_system_timeout != TRUE
       AND EXTRACT(HOUR FROM started_at) IN (6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)
       AND ride_length > 1
   GROUP BY
       ride_hour,rider_type
   ORDER BY
       total_rides DESC
   ```
     *📊Key Metrics*    
      - *Members take more rides during the specific hours (6am - 10am) and (3pm - 8pm) than casual riders*   
      - *For hours such as 7am, 8 am members take twice as many rides as casual riders*   
      - *For the hours of (4,5,6 pm), the late hours of the afternoon, members take between 290,000 to almost 400,000 rides while casual riders take between 150,000 to 180,000 rides*   

    *💡Data Interpretation & Business Takeaway*
     - *There is an increased number of member riders in general compared to casual riders. The surge in bike ride traffic during these hours for member riders is a result of the riders going and coming from work.*
     - *Casual riders do take rides during those hours as well but the number varies quite a lot in comparison to the members.*

  5. **What are the peak operational months for Cyclistic, segmented by user type?**
     
     *🔍Methodology*   
     - *Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute*  
     - *Calculated the total rides taken using COUNT() aggregation* 
     - *Used CASE statement to create a column containing the names for months of the year*
     - *Ordered the results by the ride count*
     - *Grouped the results by month and rider status (member or casual)*
           
     ```sql
      SELECT 
      member_casual AS rider_status,
      EXTRACT(MONTH FROM started_at) AS month_date,
      CASE 
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 1 THEN 'January'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 2 THEN 'February'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 3 THEN 'March'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 4 THEN 'April'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 5 THEN  'May'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 6 THEN 'June'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 7 THEN 'July'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 8 THEN 'August'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 9 THEN 'September'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 10 THEN 'October'
          WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 11 THEN 'November'
          ELSE 'December'
      END AS months,
      COUNT(ride_id)AS ride_count
      FROM trips_2025
      WHERE   
          is_system_timeout != TRUE -- Filter out the system docked bikes
          AND ride_length > 1 -- Filter out redoced after one minute rides
      GROUP BY
          month_date, member_casual 
      ORDER BY
          ride_count DESC
        ```
     
     *📊Key Metrics* 
     - *For both casual and member riders the months of June - September are the most popular for bike riding*
  
  
     *💡Data Interpretation & Business Takeaway*
     - *The popularity for bike riding during the months from June to September is because in the US or the Northern hemisphere, these are summer months or warmer months of the year and this makes bike riding much more enjoyable and a popular choice*
    
  6. **What is the distribution of fleet preferences across annual members and casual riders?**

     *🔍Methodology*
     - *Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute*
     - *Counted the number of bikes* 
     - *Grouped the data by rider type and the bike type*
     - *Ordered the results by the average ride length*
    
     ```sql
      SELECT
      member_casual AS rider_status,
      COUNT(rideable_type) AS bike_type_sum,
      rideable_type
      FROM
          trips_2025
      WHERE
          is_system_timeout != TRUE AND
          ride_length > 1
      GROUP BY
          member_casual, rideable_type
      ORDER BY
          bike_type_sum DESC
     ```

     *📊Key Metrics*
     - *Annual members ride the bikes much more frequently and as such the count for them is higher but for both the casual riders and the members, electric bikes are the most frequently used compared to classic bikes.*
 
     *💡Data Interpretation & Business Takeaway*
     - *For both the members and the casual riders, electric bikes are the most popular mode of transportation likely due to the ease and convenience of riding of the e-bikes. E-bikes don't require manual pedalling and stamina like classic bikes and that might lead users to prefer them as a mode of movement.*
    
 7. **Which specific docking stations serve as the primary departure hubs for annual members versus casual riders?**     

     *🔍Methodology*  
      - *Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute*
      - *Counted the number of bike rides*
      - *Grouped the data by station name and the rider type*
      - *Ordered the results by the ride count*
      - *Limited the results to the top ten stattions*

     ```sql
      SELECT
    start_station_name,
    COUNT(ride_id) AS ride_count,
    member_casual AS rider_type
    FROM
        trips_2025
    WHERE
        is_system_timeout != TRUE
        AND ride_length > 1 
        AND start_station_name IS NOT NULL  -- This filters out 20% start station data values as they are nulls 
    GROUP BY
        start_station_name, rider_type
    ORDER BY
        ride_count DESC
    LIMIT
        10
     ```
     *📊Key Metrics*
     - *The analysis shows the top ten sations, and in the result "DuSable Lake Shore Dr & Monroe st" and "Kingsbury St & Kinzie St" are the popularly used stations for casual riders and annual members respectively.*

    *💡Data Interpretation & Business Takeaway*
     - *For the Casual rider , the station "DuSable Lake Shore Dr & Monroe St" is the most popular station as it is connected to a number of tourist attractions and leisure establishments within the area luring in the casual riders*
    - *For the annual members "Kingsbury St & Kinzie St" is the place to be as it sees quite a number of the members take off from its docking area. This is likely because it is located right in a dense hub of tech headquarters and transit connections, as well as busy office buildings buzzing with workers who commute there daily using the bikes.*
        
        
     

  - ## Data Audit and Quality assurance with Python
  - ## Visualizations in Tableau
 # 📚 What I learned
 # 🔐 Conclusions
