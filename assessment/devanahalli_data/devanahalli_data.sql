COPY (Select b.name as block,
c.name as cluster,
s.name as school_name,
cat.name as school_type, 
moi.name as medium_of_instruction,
cls.cls1_cnt,
cls.cls2_cnt,
cls.cls3_cnt,
cls.cls4_cnt,
cls.cls5_cnt
from schools_boundary d, 
schools_boundary b, 
schools_boundary c, 
schools_institution_category cat, 
schools_institution_languages lang, 
schools_moi_type moi,schools_institution s left join
(select s.id as sid,
count(distinct case when sg.name='1' then ssg.student_id end) as cls1_cnt,
count(distinct case when sg.name='2' then ssg.student_id end) as cls2_cnt,
count(distinct case when sg.name='3' then ssg.student_id end) as cls3_cnt,
count(distinct case when sg.name='4' then ssg.student_id end) as cls4_cnt,
count(distinct case when sg.name='5' then ssg.student_id end) as cls5_cnt
from schools_institution s left join 
schools_studentgroup sg on s.id=sg.institution_id, 
schools_student_studentgrouprelation ssg where
s.boundary_id in 
(select id from schools_boundary where parent_id=586)
and sg.group_type='Class' 
and sg.id=ssg.student_group_id 
and ssg.academic_id=121 
and ssg.active=2 
and sg.active=2 
and sg.name in ('1','2','3','4','5') group by s.id) as cls on cls.sid = s.id
where s.boundary_id=c.id 
and c.parent_id=b.id 
and b.parent_id=d.id
and s.cat_id=cat.id 
and s.id = lang.institution_id 
and lang.moi_type_id=moi.id 
and s.active=2
and b.id=586) TO '/home/brijesh/assessment/devanahalli_data/devanahalli_data.csv' WITH DELIMITER '|' CSV HEADER;
