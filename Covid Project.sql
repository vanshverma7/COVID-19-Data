--Dataset to be utilized
select location, date, total_cases, new_cases, total_deaths,
population from CovidDeaths
order by location, date

--Setting total_cases and total_deaths to NULL where their values are 0 for calculations

begin transaction
update CovidDeaths
set total_cases = NULL
where total_cases = 0

update CovidDeaths
set total_deaths = NULL
where total_deaths = 0
commit --To save the changes 
-- rollback -> To undo the changes if something goes wrong


--Total Cases vs. Total Deaths
--Probability of death if contracting COVID in each respective country
select location, date, total_cases, total_deaths,
cast((total_deaths / total_cases)*100 as decimal(10,2)) [death_percentage]
from CovidDeaths
where continent is not NULL
order by location, date


--Total Cases vs. Population
--Displays the percentage of the population that has encountered COVID


select * from (
select location, date, total_cases, population,
cast((cast(total_cases as decimal)) / (cast(population as decimal)) as decimal(38,10))*100 [percentage_affected]
from CovidDeaths
where continent is not NULL) as x
order by percentage_affected desc


--Examining countries with the highest infection rates relative to their population

select location, population, MAX(total_cases) [max_cases],
max(cast((cast(total_cases as decimal)) / (cast(population as decimal)) as decimal(38,10)))*100 [percentage_affected]
from CovidDeaths
where continent is not NULL
group by location, population
order by percentage_affected desc

--Examining countries with the highest death rates relative to their population

SELECT location, population, MAX(CAST(total_deaths AS BIGINT)) AS max_deaths,
MAX(CAST((CAST(total_deaths AS BIGINT) / CAST(population AS DECIMAL(38,10))) * 100 AS DECIMAL(38,10))) AS percentage_died
FROM CovidDeaths
where continent is not NULL
GROUP BY location, population
ORDER BY percentage_died DESC

--Countries with the highest number of deaths

select location, max(total_deaths) [max_deaths] from CovidDeaths
where continent is not NULL
group by location
order by max_deaths desc

create view Death_Countries as 
select location, max(total_deaths) [max_deaths] from CovidDeaths
where continent is not NULL
group by location


--Global data by date

select (date), SUM(new_cases) [cases_reported], SUM(new_deaths)[deaths_reported], 
round((sum(new_deaths) / nullif(sum(new_cases), 0))*100, 5) [case_fatility_rate] --The NULLIF function converts cells with a value of 0 to NULL; This is done for calculations.
from CovidDeaths
where continent is not null
group by date
order by date

--Global data by month for each year

select year(date)[years], MONTH(date)[month_number], format(date, 'MMMM')[months], 
SUM(new_cases) [cases_reported], SUM(new_deaths)[deaths_reported], 
round((sum(new_deaths) / nullif(sum(new_cases), 0))*100, 5) [case_fatility_rate] --The NULLIF function converts cells with a value of 0 to NULL; This is done for calculations.
from CovidDeaths
where continent is not null
group by year(date), MONTH(date), format(date, 'MMMM')
order by years, month_number


--Global data by year

select year(date)[date], SUM(new_cases) [cases_reported], SUM(new_deaths)[deaths_reported], 
round((sum(new_deaths) / nullif(sum(new_cases), 0))*100, 5) [case_fatility_rate] --The NULLIF function converts cells with a value of 0 to NULL; This is done for calculations.
from CovidDeaths
where continent is not null
group by year(date)
order by date

--Total population, number of vaccinations administered, and the percentage of the population vaccinated

with cte as (
select a.location, a.date, a.population, b.new_vaccinations,
SUM(cast(b.new_vaccinations as bigint)) over (partition by a.location order by a.location, a.date)[rolling_vaccinations]
from CovidDeaths a
join CovidVaccines b
on a.location = b.location and a.date = b.date
where a.continent is not null) 

select *, round((rolling_vaccinations / population)*100, 5) [% population vaccinated]  from cte
order by location, date

--Percentage of the population vaccinated for each country

with cte as (
select a.location, a.date, a.population, b.new_vaccinations,
SUM(cast(b.new_vaccinations as bigint)) over (partition by a.location order by a.location, a.date)[rolling_vaccinations]
from CovidDeaths a
join CovidVaccines b
on a.location = b.location and a.date = b.date
where a.continent is not null) 

, cte_2 as (
select *, round((rolling_vaccinations / population)*100, 5) [% population vaccinated]  from cte
)

select location, MAX([% population vaccinated]) [Population Vaccinated]  from cte_2
group by location
order by location

--Percentage of the population vaccinated for each continent and grouped locations

with cte as (
select a.location, a.date, a.population, b.new_vaccinations,
SUM(cast(b.new_vaccinations as bigint)) over (partition by a.location order by a.location, a.date)[rolling_vaccinations]
from CovidDeaths a
join CovidVaccines b
on a.location = b.location and a.date = b.date
where a.continent is null) 

, cte_2 as (
select *, round((rolling_vaccinations / population)*100, 5) [% population vaccinated]  from cte
)

select location, MAX([% population vaccinated]) [Population Vaccinated]  from cte_2
group by location
order by location

-- Creating view for the same

create view Populationvaccinated_LocationWise as
with cte as (
select a.location, a.date, a.population, b.new_vaccinations,
SUM(cast(b.new_vaccinations as bigint)) over (partition by a.location order by a.location, a.date)[rolling_vaccinations]
from CovidDeaths a
join CovidVaccines b
on a.location = b.location and a.date = b.date
where a.continent is null) 

, cte_2 as (
select *, round((rolling_vaccinations / population)*100, 5) [% population vaccinated]  from cte
)

select location, MAX([% population vaccinated]) [Population Vaccinated]  from cte_2
group by location

