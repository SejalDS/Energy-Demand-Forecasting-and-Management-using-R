# 🏡 Energy Demand Forecasting and Management

This project was developed as part of the *IST 687 - Introduction to Data Science* course at Syracuse University. The goal was to help a utility provider (eSC) better manage residential energy demand during peak summer periods by leveraging statistical modeling and exploratory data analysis on large-scale consumption data.

## 📌 Project Objective

To analyze hourly residential energy consumption, weather patterns, and building metadata in South Carolina and North Carolina, and:

- Predict peak energy demand using statistical modeling
- Identify key factors driving energy usage
- Recommend actionable energy-saving strategies
- Build an interactive dashboard for stakeholders using R Shiny

## 📂 Data Sources

The datasets used include:

- **Static House Data:** ~5,000 homes with building attributes
- **Energy Usage Data:** Hourly energy consumption by device
- **Weather Data:** Hourly temperature and humidity by county
- **Metadata:** Descriptions for all fields used

> **Note**: Due to privacy concerns, raw data files are not included in this repository.

## 🧠 Methodology

### 1. Data Preprocessing

- Merged house, weather, and energy datasets using `dplyr` and `data.table`
- Cleaned missing values, standardized column names, and removed constant variables
- Applied data transformations and feature selection

### 2. Exploratory Data Analysis

- Used `ggplot2` to visualize distributions, correlations, and energy trends
- Investigated the impact of:
  - Climate zone
  - Building vintage
  - Heating fuel type
  - Household size (bedrooms)

### 3. Statistical Modeling

- Built a linear regression model (`lm()`) using the `caret` package
- Achieved **R² = 0.87**, indicating strong predictive performance
- Evaluated using Mean Absolute Percentage Error (MAPE)

### 4. Demand Reduction Strategy

- Proposed solar integration, IoT device adoption, peak pricing, and awareness campaigns

### 5. Shiny Dashboard

An interactive dashboard was built to visualize and explore energy consumption patterns.

🔗 [Shiny App Deployment](https://smitadeulkar.shinyapps.io/shinyapp/)

## 🛠️ Tools & Technologies

- **Languages:** R
- **Environment:** RStudio
- **Libraries:** `dplyr`, `tidyr`, `data.table`, `ggplot2`, `caret`, `shiny`, `readr`
- **Modeling:** Linear Regression, R², MAPE
- **Visualization:** Boxplots, bar charts, scatterplots, histograms

## 📊 Key Outcomes

- Integrated and analyzed 5,000+ residential records
- Identified building vintage and climate zone as major energy usage factors
- Built a deployable model to forecast energy usage during peak summer days
- Recommended strategic interventions to reduce energy consumption

## 👥 Team

- Sejal Sardal
- Smita Deulkar
- Harika Gangu
- Indraneel Karandikar
- Sukesh Meda

## 📝 License

This project is for academic purposes only and is not intended for commercial use.

