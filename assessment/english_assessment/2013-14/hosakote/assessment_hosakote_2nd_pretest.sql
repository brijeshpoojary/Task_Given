select b2.name as district,
b1.name as block,
b.name as cluster,
s.id as school_code,
s.name as school_name,
stu.id as student_id,
concat_ws('',c.first_name,' ',c.middle_name,' ',c.last_name) as child_name,
c.gender as gender,
case when f.relation_type='Father' then f.first_name else null end as father_name, 
case when m.relation_type='Mother' then m.first_name else null end as mother_name,
mt.name as mother_tongue,
sg.name || sg.section as class_section,
prog.name as programme_name,
assess.start_date as start_date,
assess.name as assessment_name,
ques.name as question,
case when ans.status=-99999 then 'AB' else case when ans.status=-1 then 'NA' else case when ans.answer_score is null then '0' else cast(ans.answer_score as text) end end end as answer_score
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_answer as ans, 
schools_question as ques,
schools_student as stu,
schools_child as c,
schools_relations as f,
schools_relations as m,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg,
schools_assessment as assess,
schools_programme as prog,
schools_moi_type as mt
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b1.id=587
and assess.id=127
and assess.programme_id=prog.id
and s.id=sg.institution_id
and sg.id=ssg.student_group_id
and ssg.academic_id='121' 
and ssg.student_id=stu.id	
and stu.child_id=c.id 
and c.mt_id=mt.id
and f.child_id=c.id
and f.child_id=m.child_id
and stu.id=ans.object_id
and ans.question_id=ques.id
and ques.assessment_id=assess.id
order by district,block,cluster,school_name,student_id,child_name;
