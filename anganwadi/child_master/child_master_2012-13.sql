select b2.name as district,
b1.name as block,
b.name as cluster,
s.name school_name,
stu.id as student_id,
c.gender as gender,
c.dob as d_o_b, 
date_part('year',age(cast(c.dob as timestamp))) || '.' || date_part('mon',age(cast(c.dob as timestamp))) || 'yrs' as age,
mt.name as mother_tongue
from
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2,
schools_student as stu,
schools_child as c,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg,
schools_moi_type as mt
where
s.boundary_id=b.id
and b.parent_id=b1.id
and b1.parent_id=b2.id
and b2.name='bangalore'
and s.cat_id in(10,11,12)
and s.active=2
and s.id=sg.institution_id
and sg.id=ssg.student_group_id
and ssg.academic_id='121'
and ssg.student_id=stu.id  
and stu.child_id=c.id
and c.mt_id=mt.id order by district,block,cluster,school_name, d_o_b;
