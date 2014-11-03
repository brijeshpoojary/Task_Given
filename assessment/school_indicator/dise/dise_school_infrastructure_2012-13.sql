select count(school_code,no_of_teachers,no_of_students) from (
select distinct district as district,
block_name as block,
cluster_name as cluster,
school_code,
school_name,
male_tch + female_tch as no_of_teachers,
total_boys + total_girls as no_of_students
from 
dise_1213_basic_data 
where 
sch_management=1
and sch_category=1) as t;
