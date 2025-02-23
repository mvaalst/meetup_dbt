# dbt Repository for Meetup Project

## Project Structure

This repository is organized into the following layers to support a streamlined data transformation process:

- **Staging Layer**: Contains raw base tables, where data is ingested and undergoes basic transformations and cleaning processes to prepare for further analysis.
- **Marts Layer**: Aggregated and combined insights at the entity level, such as user and group data, as well as event-level summaries.
- **Reporting Layer**: Finalized models that feed directly into the reporting layer (e.g., [Google Looker Studio Dashboard](https://lookerstudio.google.com/reporting/a7d57b25-3b2c-4c63-8ffa-92a2de18214d/page/9D1wE)) for visualization.

## dbt Model Details

Each dbt model includes a corresponding `.yml` file, which contains essential information for the model, including:
- **Model Description**: A high-level overview of the model's purpose and function.
- **Grain of the Data**: Clear definition of the model's unique key or the lowest level of aggregation.
- **Testing & Validations**: Assertions applied to various columns to ensure data quality and integrity.
