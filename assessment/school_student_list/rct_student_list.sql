select distinct b2.name as district,
b1.name as block,
b.name as cluster,
s.id as school_code,
s.name as school_name,
sg.name || sg.section as class_section,
stu.id as student_id,
concat_ws('',c.first_name,' ',c.middle_name,' ',c.last_name) as child_name,
c.gender as gender,
case when c.dob is null then '88' else cast(c.dob as text) end as dob,
rel.father,
rel.mother,
mt.name as mother_tongue
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_student as stu,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg,
schools_moi_type as mt,
schools_child as c,
(select f.child_id as fid, m.child_id as mid, f.first_name as father, m.first_name as mother from schools_relations as f, schools_relations as m where f.child_id=m.child_id and f.relation_type='Father' and m.relation_type='Mother') as rel
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b2.id=433
and s.id=sg.institution_id
and sg.name in ('1','2','3','4','5')
and sg.id=ssg.student_group_id
and ssg.academic_id='123' 
and ssg.student_id=stu.id	
and stu.child_id=c.id
and c.mt_id=mt.id
and c.id=rel.fid
and c.id=rel.mid
order by district,block,cluster,school_name,child_name;
