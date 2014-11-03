select b2.name as district,
b1.name as block,
b.name as cluster,
s.id as school_code,
s.name as school_name,
sg.name as class,
stu.id as student_id,
concat_ws('',c.first_name,' ',c.middle_name,' ',c.last_name) as child_name,
c.gender as sex,
c.dob as dob,
concat_ws('',r.first_name,' ',r.middle_name,' ',r.last_name) as father_name,
concat_ws('',r1.first_name,' ',r1.middle_name,' ',r1.last_name) as mother_name
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_student as stu,
schools_child as c,
schools_relations as r,
schools_relations as r1,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b1.id in (8880,8881,8882,8883,8884,8885,8886,8887,8888,8879) 
and s.id=sg.institution_id
and sg.id=ssg.student_group_id
and sg.name in ('3','4','5')
and ssg.academic_id='123'
and ssg.student_id=stu.id
and stu.child_id=c.id
and c.id=r.child_id
and r.relation_type='Father'
and c.id=r1.child_id
and r1.relation_type='Mother'
order by district,block,cluster,school_Name,class,child_name;
