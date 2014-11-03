select dist.name as district,
blck.name as block, 
clst.name as cluster, 
inst.id as klp_id, 
inst.name as school_name, 
count(distinct st.id) as st_count 
from schools_institution as inst,
    schools_boundary as dist,
    schools_boundary as blck,
    schools_boundary as clst,
    schools_staff as st
where dist.id=blck.parent_id
    and blck.id=clst.parent_id
    and clst.id=inst.boundary_id
    and inst.active=2
    and inst.id=st.institution_id
    and st.staff_type_id=2
    and dist.id in (420,419)
group by district,block,cluster,klp_id,school_name
order by district, block, cluster, school_name ;

