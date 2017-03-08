select * from (
select * from (
select A.seq_no, A.store_id, A.title, A.content
from (
SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,          
    store_id, title, content, writedate, readcount, parent, notice, reply_yn                                      
    FROM  store_help                                                     
    WHERE parent IS NULL) A
join (select * from store) B
on (A.store_id=B.store_id)
union all
SELECT seq_no, store_id, title, content                        
FROM store_help s                                                         
WHERE EXISTS ( 		    
  SELECT T2.seq_no
  FROM (     
    SELECT ROW_NUMBER() OVER (ORDER BY seq_no DESC) rnum, seq_no,          
    store_id, title, content, writedate, readcount, parent, notice, reply_yn                                      
    FROM  store_help                                                     
    WHERE parent IS NULL AND store_id=2000900017) T2
  where T2.seq_no=s.parent)) A
  left outer join 
  (select sonnim_id admin, name
from sonnim
where sonnim_id=999999999) B
on A.store_id=admin(+)) AA
left outer join
(select store_id as sdmin, name
from store) BB
on AA.store_id=sdmin(+);