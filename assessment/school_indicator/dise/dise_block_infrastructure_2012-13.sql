select distinct district as district,
block_name as block,
sum_schools as no_of_schools,
sum_toilet_common as common_toilet,
sum_toilet_girls as girls_toilet,
sum_has_electricity as electricity,
sum_has_playground as playground,
sum_has_ramps as ramps,
sum_has_library as library,
sum_books_in_library as no_of_books,
sum_has_boundary_wall as compound,
sum_has_drinking_water as drinking_water,
sum_has_blackboard as no_of_blackboard,
sum_has_medical_checkup as medical_checkup,
sum_has_cal_lab as computer_lab,
sum_no_of_computers as no_of_computers,
sum_male_tch + sum_female_tch as no_of_teachers,
sum_head_teacher as no_of_headteacher,
sum_tot_clrooms as no_of_classroom
from 
dise_1213_block_aggregations 
where 
block_name in ('MUNDARAGI','KUSTAGI') order by block;
