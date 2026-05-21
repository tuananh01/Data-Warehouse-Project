# Data Warehouse project
## Overview
A project is create with the purpose of learning SQL. 
The target of the project is to build a small data warehouse used to store data about customers, products, and sales. <br>
This project involves:
1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports. <br>

Divided into 3 stages:
- **Stage 1**: Buidling the data architecture in SQL Server, extract raw data from source datasets.
- **Stage 2**: Transform, cleanse data and load fine-tuned data into fact and dimension tables.
- **Stage 3**: Perform data analytics using the Exploratory Data Analysis (EDA) concept.

**Tools used**: SSMS 22, SQL Server, Draw.io  
Progression Tracking on **Notion**: https://notion-url-shortener.vercel.app/sql-data-warehouse-project

---
## Stage 1
### Assignments:
- [x] Building the data warehouse's database SCHEMAs (bronze, silver, gold) in SQL Server
- [x] Import raw dataset from CRM and ERP files into the bronze layer.
####  The Medallion Architecture:
![Data Architecture](materials/Data%20Architecture.png)

#### Data Flow
![Data Architecture](materials/Data%20Flow%20Diagram.png)


---
## Stage 2
### Assignments:
- [x] Perform data cleansing and import fine-tuned data from the bronze layer into the silver layer.
- [x] Perform data intergration between tables.
- [x] Turn tables from the silver layers into dimension and fact and import them into the gold layer.
#### Data Cleansing
- Duplicates and NULL in the Primary key
- Whitespaces
- Data Standardization & Normalization
- Intergration Capability
#### Data intergration
![Data Integration](materials/Data%20OBJECT.png)
#### Gold Layer's Data Model: Star Scheme
![Data Integration](materials/Star%20Cheme.png)

