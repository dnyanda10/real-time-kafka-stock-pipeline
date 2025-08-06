# Real-Time Kafka Stock Pipeline 

This project showcases a real-time data streaming pipeline that simulates stock market data flow from a Kafka producer to a Snowflake data warehouse, leveraging AWS S3 and Snowpipe for storage and automated ingestion.

## 🎯 Project Overview

**Goal:**  
Build an end-to-end real-time data pipeline using open-source and cloud technologies.

## 🔁 Workflow:

1. **Kafka Producer**: Reads data from a CSV file and sends records to Kafka topic `demo_testing`.  
2. **Kafka Consumer**: Reads the topic data and writes it to `.json` files.  
3. **AWS S3**: Stores the JSON files.  
4. **Snowflake + Snowpipe**: Automatically ingests new data from S3 into a structured table.  
5. **Snowflake Data Warehouse**: Data is now available in Snowflake for querying and analytics.


## 🛠️ Tech Stack

- Apache Kafka (Producer/Consumer)
- Python (Kafka interaction, file handling)
- AWS S3 (Data lake storage)
- Snowflake (Data warehouse)
- Snowpipe (Continuous data ingestion)
- IAM (Secure access between Snowflake and S3)

## 📁 Project Structure

```text
Kafka real time project/
├── producer/                # Kafka producer script (producer.py)
├── consumer/                # Kafka consumer script (consumer.py)
├── snowflake/               # SQL scripts: stage, pipe, table creation
├── data/                    # JSON files (streamed from consumer)
├── logs/                    # Log files for producer and consumer
├── architecture_diagram.png# Project architecture image
├── .gitignore
└── README.md
```



## ❄️ Snowflake Objects Created

- **Database**: `kafka_project`  
- **Schema**: `kafka_s3_schema`  
- **Storage Integration**: `my_s3_integration` (with AWS IAM Role)  
- **External Stage**: `kafka_s3_stage`  
- **Table**: `stock_data`  
- **File Format**: `json_format`  
- **Snowpipe**: `stock_pipe` with auto-ingest enabled  


## 🌟 Highlights

- Real-time stream processing with **Kafka**
- Automation with **Snowpipe** for seamless data ingestion
- Clean modular structure with logs for debugging
- Cloud-native architecture using **AWS S3** and **Snowflake**


## 📷 Architecture Diagram

![Kafka Real-Time Pipeline Architecture](architecture_diagram.png)

