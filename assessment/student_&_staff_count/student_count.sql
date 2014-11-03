select district, 
block, 
cluster, 
klp_id, 
school_name, 
sum(class_1) as class_1, 
sum(class_2) as class_2, 
sum(class_3) as class_3, 
sum(class_4) as class_4, 
sum(class_5) as class_5, 
sum(class_6) as class_6, 
sum(class_7) as class_7, 
sum(class_1)+sum(class_2)+sum(class_3)+sum(class_4)+sum(class_5)+sum(class_6)+sum(class_7) as total
from (select district, block, cluster, klp_id, school_name,
    case when class='1' then st_count else 0 end as class_1,
    case when class='2' then st_count else 0 end as class_2,
    case when class='3' then st_count else 0 end as class_3,
    case when class='4' then st_count else 0 end as class_4,
    case when class='5' then st_count else 0 end as class_5,
    case when class='6' then st_count else 0 end as class_6,
    case when class='7' then st_count else 0 end as class_7
from (select dist.name as district,
    blck.name as block,
    clst.name as cluster,
    inst.id as klp_id,
    inst.name as school_name,
    sg.name as class,
    count(distinct ssgr.student_id) as st_count
from schools_institution as inst,
    schools_boundary as dist,
    schools_boundary as blck,
    schools_boundary as clst,
    schools_studentgroup as sg,
    schools_student_studentgrouprelation as ssgr
where dist.id=blck.parent_id
    and blck.id=clst.parent_id
    and clst.id=inst.boundary_id
    and inst.active=2
    and inst.id=sg.institution_id
    and sg.active=2
    and sg.name in ('1','2','3','4','5','6','7')
    and sg.id=ssgr.student_group_id
    and ssgr.active=2
    and blck.id=587
    and ssgr.academic_id=122
group by district, block, cluster, klp_id, school_name, class
order by district, block, cluster, school_name, class) as t) as t1 group by district, block, cluster, klp_id, school_name;

