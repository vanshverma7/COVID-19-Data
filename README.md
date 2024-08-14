# COVID-19 Data Analysis

This project contains SQL queries designed to analyze COVID-19 data from January 1, 2020, to August 12, 2024. The queries offer insights into various aspects of the pandemic, including infection rates, death rates, vaccination rates, and global statistics.

**Note:** The queries provided can be used on updated datasets as per the user's choice. The latest version of the dataset can be downloaded from [CLICK HERE](https://ourworldindata.org/covid-deaths).

## Features

- **Dataset Utilization:** Retrieves basic COVID-19 data including total cases, new cases, total deaths, and population.
- **Handling Missing Data:** Updates the dataset to set `total_cases` and `total_deaths` to `NULL` where their values are `0` for more accurate calculations.
- **Total Cases vs. Total Deaths:** Calculates the probability of death if contracting COVID-19 in each country.
- **Total Cases vs. Population:** Displays the percentage of the population that has encountered COVID-19.
- **Countries with Highest Infection Rates:** Identifies countries with the highest infection rates relative to their population.
- **Countries with Highest Death Rates:** Examines countries with the highest death rates relative to their population.
- **Countries with Highest Number of Deaths:** Lists countries with the highest number of total deaths.
- **Global Data by Date:** Provides global COVID-19 data by date, including cases reported, deaths reported, and case fatality rate.
- **Global Data by Month and Year:** Aggregates global COVID-19 data by month and year.
- **Global Data by Year:** Aggregates global COVID-19 data by year.
- **Vaccination Data and Percentage:** Analyzes the total population, number of vaccinations administered, and percentage of the population vaccinated.
- **Percentage of Population Vaccinated by Country:** Shows the percentage of the population vaccinated for each country.
- **Percentage of Population Vaccinated by Continent:** Displays the percentage of the population vaccinated for each continent.
- **Create Views for Vaccination Data:** Creates views to simplify the analysis of vaccination data.

## Usage

You can execute these SQL queries on the dataset to perform various analyses and gain insights into the COVID-19 pandemic.

**Note:** The latest version of the dataset can be downloaded from [https://ourworldindata.org/covid-deaths](https://ourworldindata.org/covid-deaths).
