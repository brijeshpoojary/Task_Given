select year, 
	class, 
	sum(male) as male, 
	sum(female) as female, 
	sum(male)+sum(female) as total,
	round((sum(male)*100)/(sum(male)+sum(female)),2) as male,
	round((sum(female)*100)/(sum(male)+sum(female)),2) as female 
from (select ay.name as year,
	sg.name as class,
	case when gender='male' then count(stud.id) else 0 end as male,
	case when gender='female' then count(stud.id) else 0 end as female
from schools_boundary as dist,
	schools_boundary as blck,
	schools_boundary as clst,
	schools_institution as inst,
	schools_student_studentgrouprelation as stgr,
	schools_studentgroup as sg,
	schools_student as stud,
	schools_child as chld,
	schools_academic_year as ay
where dist.id=blck.parent_id
	and blck.id=clst.parent_id
	and clst.id=inst.boundary_id
	and blck.id in (494,587,497)
	and stgr.student_group_id=sg.id
	and stgr.student_id=stud.id
	and sg.institution_id=inst.id
	and stud.child_id=chld.id
	and ay.id=stgr.academic_id
	and sg.name in ('1','2','3','4','5')
	and stgr.academic_id in (102,121,122)
group by year, class, gender) as t
group by year, class
order by year, class;
