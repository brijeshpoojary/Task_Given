select distinct b2.name as district, 
b1.name as block,
b.name as cluster,
s.id as pre_school_code,
s.name as anganwadi,
assess.start_date as start_date,
assess.end_date as end_date,
ques.order as question_seq,
ques.name as question,
case when ans.status=-99999 then 'AB' else case when ans.status=-1 then 'NA' else case when ans.answer_score is null then '0' else cast(ans.answer_score as text) end end end as answerscore 
from 
schools_institution as s,
schools_boundary as b,
schools_boundary as b1,
schools_boundary as b2, 
schools_answer as ans, 
schools_question as ques,
schools_assessment as assess
where 
s.boundary_id=b.id 
and b.parent_id=b1.id 
and b1.parent_id=b2.id 
and b2.id in (8773,9064,9115)
and assess.id=229
and ques.assessment_id=assess.id
and ans.question_id=ques.id 
and ans.object_id=s.id
order by block,cluster,pre_school_code,anganwadi,question_seq;
