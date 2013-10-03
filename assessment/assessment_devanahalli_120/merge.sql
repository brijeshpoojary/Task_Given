create or replace function rowtocolumn() returns void as $$
declare
	row record;
	query text;
	strs text;
begin
	create or replace view vw_query as select *from (select district,block,cluster,school_code,school_name,moi,student_id,gender,mother_tongue,section,programme_name,assessment_name,question,answerscore from (select s.id as school_code,b.id as cluster,b1.id as block,b2.id as district from schools_institution as s,schools_boundary as b,schools_boundary as b1,schools_boundary as b2 where s.boundary_id=b.id and b.parent_id=b1.id and b1.parent_id=b2.id and b1.id=586) as t inner join(select g.id as school_code,g.name as school_name,j.name as moi,c.id as student_id,d.gender,j1.name as mother_tongue,f.section,h.name as assessment_name,i.name as programme_name,b.name as question,case when a.status=-99999 then 'AB' else case when a.status=-1 then 'NA' else cast(a."answerScore" as text) end end as answerscore from schools_answer as a, schools_question as b,schools_student as c,schools_child as d,schools_student_studentgrouprelation as e,schools_studentgroup as f,schools_institution as g,schools_assessment as h,schools_programme as i,schools_moi_type as j,schools_moi_type as j1,schools_institution_languages as k where h.id=120 and b.assessment_id=h.id and b.id=a.question_id and a.object_id=c.id and c.child_id=d.id and a.object_id=e.student_id and e.academic_id=121 and h.programme_id=i.id and e.student_group_id=f.id and g.id=f.institution_id and k.institution_id=f.institution_id and k.moi_type_id=j.id and d.mt_id=j1.id) as r using(school_code)) as t1 ;
	query := 'select distinct trim(question) as question from vw_query order by question';
	strs:='select district,block,cluster,school_code,school_name,moi,student_id,gender,mother_tongue,programme_name,assessment_name';
	for row in execute query
	loop
		strs:=strs || ', (case when sum( ' ||substr(trim(row.question),2,1) || substr(trim(row.question),1,1) || ') =-99999 then ''NA'' else case when sum( ' ||substr(trim(row.question),2,1) || substr(trim(row.question),1,1) || ') =-1 then ''AB'' else cast(sum( ' ||substr(trim(row.question),2,1) || substr(trim(row.question),1,1) || ') as text) end end) as ' || substr(trim(row.question),2,1) || substr(trim(row.question),1,1);
	end loop;
	strs:= strs || ' from ( select district,block,cluster,school_code,school_name,moi,student_id,gender,mother_tongue,section,programme_name,assessment_name ';
	for row in execute query
	loop
		strs:=strs || ', (case when trim(question)=''' ||  trim(row.question)  || ''' then answerscore else NULL end) as ' || substr(trim(row.question),2,1) || substr(trim(row.question),1,1);
	end loop;
	strs:= strs || ' from (select district,block,cluster,school_code,school_name,moi,student_id,gender,mother_tongue,section,programme_name,assessment_name,question,case when trim(answerscore)=''NA'' then -99999 else case when trim(answerscore)=''AB'' then -1 else cast(answerscore as float) end end as answerscore from vw_query) as t)  as t1 group by district,block,cluster,school_code,school_name,moi,student_id,gender,mother_tongue,section,programme_name,assessment_name';
	execute 'create or replace view vw_result as select * from ( ' || strs || ' ) as t ';
end;
$$
language plpgsql;

select rowtocolumn();

select *from vw_result;

drop view vw_result;
drop view vw_query;
