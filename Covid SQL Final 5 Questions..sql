======================================================================================================================
-- 1. GLOBAL Infection count, death count and death percentage:

With global_no as (
				Select location, population,
					   coalesce(sum(new_cases), 0) as total_cases, 
					   coalesce(sum(new_deaths), 0) as total_deaths, 
					   concat((sum(new_deaths)/sum(new_cases))*100,' ','%') as Death_percentage,
					   concat((sum(new_cases)/max(population))*100,' ','%') as Infected_percentage
				from Covid_Death
				where continent is not null
						and location not in ('World', 'High income', 'Upper middle income', 
									 'Lower middle income', 'International', 'Low income')
				group by location, population)

select /*sum(population) as total_population,*/ sum(total_cases) as total_cases, sum(total_deaths) as total_deaths,
	   /*concat((sum(total_cases)/sum(population))*100,' ','%') as Overall_infected_percent,*/
	   (sum(total_deaths)/sum(total_cases))*100 as Overall_death_percent
from global_no; 


======================================================================================================================

-- 2. Total deaths as per CONTINENTS:

Select location, max(total_deaths) as total_deaths
from Covid_Death
where continent is  null
and location not in ('World', 'High income', 'Upper middle income', 
					 'Lower middle income', 'International', 'Low income', 'European Union')
group by location
order by total_deaths desc;



======================================================================================================================

-- 3. Total population, total infection count and infection percentage by COUNTRIES:

Select location, population
	   ,coalesce(sum(new_cases), 0) as infection_count 
	   ,(sum(new_cases)/max(population))*100 as Infection_percentage
from Covid_Death
where continent is not null
	and location not in ('World', 'High income', 'Upper middle income', 
						'Lower middle income', 'International', 'Low income')
group by location, population
order by location;



======================================================================================================================

-- 4. Infection cases per day according to their COUNTRIES and percentage of infection:

Select location, population, date, 
	   max(total_cases) as total_infection_cases, 
	   max(total_cases/population)*100 as Infection_percentage
from Covid_Death
where continent is not null
		and location not in ('World', 'High income', 'Upper middle income', 
					 'Lower middle income', 'International', 'Low income')
group by location, population, date
order by location;


======================================================================================================================

-- 5. CONTINENT wise Death Percentage: 

Select location, max(total_deaths) as total_deaths,
max((total_deaths/population))*100 as Death_percentage
from Covid_Death
where continent is  null
and location not in ('World', 'High income', 'Upper middle income', 
					 'Lower middle income', 'International', 'Low income', 'European Union')
group by location
order by total_deaths desc;

======================================================================================================================