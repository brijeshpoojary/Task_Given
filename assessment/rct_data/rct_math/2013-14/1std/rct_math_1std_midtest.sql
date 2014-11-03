select b2.name as district,
b1.name as block,
b.name as cluster,
s.id as school_code,
s.name as school_name,
stu.id as student_id,
concat_ws('',c.first_name,' ',c.middle_name,' ',c.last_name) as child_name,
c.gender as gender,
case when c.dob is null then '88' else cast(c.dob as text) end as dob,
case when f.relation_type='Father' then f.first_name else null end as father_name, 
case when m.relation_type='Mother' then m.first_name else null end as mother_name,
mt.name as mother_tongue,
sg.name || sg.section as class_section,
prog.name as programme_name,
assess.start_date as start_date,
assess.name as assessment_name,
ques.name as question,
case when ans.status=-99999 then '99' else case when ans.status=-1 then '0' else case when ans.answer_grade is null then '0' else cast(ans.answer_grade as text) end end end as answer_grade 
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_answer as ans, 
schools_question as ques,
schools_student as stu,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg,
schools_assessment as assess,
schools_programme as prog,
schools_moi_type as mt,
schools_child as c,
schools_relations as f,
schools_relations as m
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b1.id in (586,587)
and assess.id=197
and assess.programme_id=prog.id
and s.id=sg.institution_id
and sg.id=ssg.student_group_id
and ssg.academic_id='122' 
and ssg.student_id=stu.id	
and stu.child_id=c.id
and f.child_id=c.id
and f.child_id=m.child_id
and c.mt_id=mt.id
and stu.id=ans.object_id
and ans.question_id=ques.id
and ans.double_entry=2 
and ques.assessment_id=assess.id
order by district,block,cluster,school_name,child_name;
