child as d,schools_student_studentgrouprelation as e,schools_studentgroup as f,schools_institution as g,schools_assessment as h,schools_programme as i,schools_moi_type as j,schools_moi_type as j1,schools_institution_languages as k where h.id=120 and b.assessment_id=h.id and b.id=a.question_id and a.object_id=c.id and c.child_id=d.id and a.object_id=e.student_id and e.academic_id=121 and h.programme_id=i.id and e.student_group_id=f.id and g.id=f.institution_id and k.institution_id=f.institution_id  and k.moi_type_id=j.id and d.mt_id=j1.id ) as r using(school_code);

select b2.name as district,
b1.name as block,
b.name as cluster,
s.id as school_code,
s.name school_name,
moi.name as moi,
stu.id as student_id,
c.gender as gender,
mt.name as mother_tongue,
sg.name || sg.section as class_section,
assess.name as assessment_name,
prog.name as programme_name,
ques.name as question,
case when ans.status=-99999 then 'AB' else case when ans.status=-1 then 'NA' else cast(ans."answerScore" as text) end end as answerscore 
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2 
schools_answer as ans, 
schools_question as ques,
schools_student as stu,
schools_child as c,
schools_student_studentgrouprelation as ssg,
schools_studentgroup as sg,
schools_assessment as assess,
schools_programme as prog,
schools_moi_type as moi,
schools_moi_type as mt,
schools_institution_languages as lang
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b1.id=586
and assess.id=120
and assess.programme_id=prog.id
and s.id=lang.institution_id  
and lang.moi_type_id=moi.id 
and s.id=sg.institution_id 
and sg.id=ssg.student_group_id
and ssg.academic_id='121' 
and ssg.student_id=stu.id	
and stu.child_id=c.id 
and c.mt_id=mt.id
and stu.id=ans.object_id
and ans.question_id=ques.id 
and ques.assessment_id=assess.id;
