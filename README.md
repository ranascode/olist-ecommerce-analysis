# Brazilian E-Commerce Sales Analysis | Olist

## Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using SQL to explore sales performance, product category trends, and data quality.

The objective is to transform raw transactional data into meaningful business insights that can support data-driven decision-making.

## Business Questions

1. How does sales performance change over time?
2. Which product categories generate the highest revenue?
3. What is the average order value?
4. How do order statuses affect sales analysis?
5. What data quality issues should be considered before reporting?

## Dataset

**Source:** Brazilian E-Commerce Public Dataset by Olist (Kaggle)

The dataset contains approximately 100,000 orders placed between 2016 and 2018, including order information, products, customers, payments, and reviews.

## Tools & Technologies

- **SQL (SQLite):** Data exploration, aggregation, JOIN operations, and analytical queries
- **DB Browser for SQLite:** Database management and SQL execution
- **GitHub:** Version control and project documentation
- **Tableau:** Planned dashboard development

## Key Findings

### Sales Performance

- Delivered orders: **96,478**
- Analyzed product sales value: approximately **BRL 13.22 million**
- Previously calculated average sales value per delivered order: approximately **BRL 137.04**
- November 2017 showed approximately **52.37% month-over-month sales growth**.

### Product Category Performance

The leading product categories by sales value included:

| Category | Sales Value (BRL) |
|---|---:|
| Health & Beauty | 1,233,131.72 |
| Watches & Gifts | 1,166,176.98 |
| Bed, Bath & Table | 1,023,434.76 |
| Sports & Leisure | 954,852.55 |
| Computers & Accessories | 888,724.61 |

### Data Quality

Data quality checks identified missing delivery dates across several order statuses.

For example, eight orders marked as delivered had missing customer delivery dates. This highlights the importance of validating data before conducting delivery performance analysis.

## Project Structure

- `sql/01_data_exploration.sql` — Initial exploration and data validation
- `sql/02_sales_performance.sql` — Sales and monthly growth analysis
- `sql/03_product_analysis.sql` — Product category performance analysis

## Next Steps

- Extend the analysis to customer behavior and geographic trends
- Build an interactive Tableau dashboard
- Develop actionable business recommendations based on the findings

## Data Source

[Olist Brazilian E-Commerce Dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
