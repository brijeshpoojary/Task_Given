select b2.name as district,
b1.name as block,
b.name as cluster,
s.id as school_code,
s.name as school_name,
moi.name as moi,
sg.name || sg.section as class_section,
stu.id as student_id,
concat_ws('',c."firstName",' ',c."middleName",' ',c."lastName") as child_name,
c.gender as sex,
c.dob as dob,
concat_ws('',r.first_name,' ',r.middle_name,' ',r.last_name) as father_name,
concat_ws('',r1.first_name,' ',r1.middle_name,' ',r1.last_name) as mother_name,
prog.name as programme_name,
assess.name as assessment_name,
ques.name as question,
case when ans.status=-99999 then 'AB' else case when ans.status=-1 then 'NA' else cast(ans."answerScore" as text) end end as answerscore
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_answer as ans, 
schools_question as ques,
schools_student as stu,
schools_child as c,
schools_relations as r,
schools_relations as r1,
schools_student_studentgrouprelation as ssg,
schools_assessment_studentgroup_association as asga,
schools_studentgroup as sg,
schools_assessment as assess,
schools_programme as prog,
schools_moi_type as moi,
schools_institution_languages as lang
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b1.id in (493,494)
and s.id=lang.institution_id  
and lang.moi_type_id=moi.id 
and s.id=sg.institution_id
and sg.id=ssg.student_group_id
and sg.name='5'
and ssg.academic_id='121'
and ssg.student_group_id=asga.student_group_id 
and asga.assessment_id=assess.id
and assess.id=123
and assess.programme_id=prog.id
and prog.id=35
and ssg.student_id=stu.id
and stu.child_id=c.id
and c.id=r.child_id
and r.relation_type='Father'
and c.id=r1.child_id
and r1.relation_type='Mother'
and stu.id=ans.object_id
and ans.question_id=ques.id 
and ques.assessment_id=assess.id;
