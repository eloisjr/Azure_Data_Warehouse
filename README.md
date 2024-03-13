# Building an Azure Data Warehouse for Bike Share Data Analytics
 
 # **Project**

 This project called "Data Warehouse for Bike Share Data Analytics" is an assignment from the UDACITY course "Data Engineering with Microsoft Azure".

# **Project Overview**

Divvy is a bike-sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data.
There are 3 CSV files called payments, riders, stations, and trips. Since the data from Divvy are anonymous, we have created fake rider and account profiles along with fake payment data to go along with the data from Divvy. The data schema looks like this: 
![image](https://github.com/eloisjr/Azure_Data_Warehouse/assets/81710422/1df39285-110e-4c68-9a7c-50bd7509baeb)

# **Objetive**

The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. You will:
1.	Design a star schema based on the business outcomes listed below
2.	Import the data into Synapse
3.	Transform the data into the star schema
4. Finally, view the reports from Analytics.

# **Business outcomes**
The business outcomes you are designing for are as follows:
1. Analyze how much time is spent per ride
 -	Based on date and time factors such as day of week and time of day
 - Based on which station is the starting and / or ending station
 - Based on age of the rider at time of the ride
 - Based on whether the rider is a member or a casual rider
2.	Analyze how much money is spent.
 - 	Per month, quarter, year
 - 	Per member, based on the age of the rider at account start
3.	EXTRA CREDIT - Analyze how much money is spent per member
 - Based on how many rides the rider averages per month
 - Based on how many minutes the rider spends on a bike per month

# **Task 1: Create your Azure resources**

1.	Create an Azure Database for PostgreSQL.
2.	Create an Azure Synapse workspace.
3. Use the built-in serverless SQL pool and database within the Synapse workspace.


# **Task 2: Design a star schema**

You are being provided a relational schema that describes the data as it exists in PostgreSQL. In addition, you have been given a set of business requirements related to the data warehouse. Below is the star schema using fact and dimension tables.

![star_schema_bikes](https://github.com/eloisjr/Azure_Data_Warehouse/assets/81710422/02e335d1-c1f5-4419-b63e-8c92523437cb)

# **Task 3: Create the data in PostgreSQL** 

You first must create the data in PostgreSQL. This will simulate the production environment where the data is being used in the OLTP system. This can be done using the Python script provided for you in Github: ProjectDataToPostgres.py.

1. Download the script file and place it in a folder where you can run a Python script
2. Download the data files(opens in a new tab) from the classroom resources
3. Open the script file in VS Code and add the host, username, and password information for your PostgreSQL database
4. Run the script and verify that all four data files are copied/uploaded into PostgreSQL
5. You can verify this data exists by using pgAdmin or a similar PostgreSQL data tool.

# **Task 4: EXTRACT the data from PostgreSQL**

In your Azure Synapse workspace, you will use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse.

# **Task 5: LOAD the data into external tables in the data warehouse**

Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. From here, you can use the script-generating function to load the data from blob storage into external staging tables in the data warehouse you created using the serverless SQL Pool.

# **Task 6: TRANSFORM the data to the star schema using CETAS**

Write SQL scripts to transform the data from the staging tables to the final star schema you designed.

The serverless SQL pool won't allow you to create persistent tables in the database, as it has no local storage. So, use CREATE EXTERNAL TABLE AS SELECT (CETAS) instead. CETAS is a parallel operation that creates external table metadata and exports the SELECT query results to a set of files in your storage account.

