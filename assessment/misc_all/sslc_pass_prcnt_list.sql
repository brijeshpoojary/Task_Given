select dist.dist_name, 
ay.name, 
sum(sslc.tot_stu_count) as total, 
sum(sslc.pass_stu_count) as passed, 
(100*sum(sslc.pass_stu_count)/sum(sslc.tot_stu_count)) as pass_percentage 
from 
tb_academic_year as ay, 
tb_sslc_dbstatus_agg as sslc, 
tb_district as dist 
where 
is_govt='G' 
and sslc.ayid=ay.id 
and dist.dist_code=sslc.dist_code 
group by dist.dist_name,ay.name order by 1,2;
