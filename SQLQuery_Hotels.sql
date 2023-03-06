-- We want only one big table with those 3 years so:
with Hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )
-- Query 1: Where adr is the averate daily rate
-- Question: Is our hotel revenue growing by year? We have to create a new column that calculate this value
Select 
arrival_date_year,
round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),0) as Revenue
from Hotels
group by arrival_date_year

-- Revenue increased for 2019, almost 5 times more than in 2018 but fell again in 2020

-- Query 2: I will join the other 2 tables where have the information about the cost of the meal and the discount offered according to the category
with Hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select * from Hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal

-- This lines i am going to read in power bi so i can do some usefull visualizations
