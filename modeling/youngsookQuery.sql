--예약추가		
insert into booking(sonnim_id, store_id, bookdate, booktime, bookperson, note)
values(?, ?, ?, ?, ?, ?)

--예약 리스트 가져오기(paging)
SELECT TT1.*
FROM
  (SELECT ROWNUM RNUM,
    T1.*,
    T2.*
  FROM
    ( SELECT * FROM booking ORDER BY store_id DESC
    )T1 natural JOIN
    (SELECT COUNT(*) TOT_CNT FROM booking
    )T2
  )TT1
WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE);


--예약 개수 가져오기
SELECT COUNT(no) AS every,
  SUM(
  CASE
    WHEN booking.bookstate = 0
    THEN 1
  END) AS state0,
  SUM(
  CASE
    WHEN booking.bookstate = 1
    THEN 1
  END) AS state1,
  SUM(
  CASE
    WHEN booking.bookstate = 2
    THEN 1
  END) AS state2
FROM booking
WHERE SONNIM_ID=?;

--예약 취소 시
update booking set bookstate=2 where no=?

--상태에 따른 예약 리스트 가져오기(paging)
SELECT TT1.*
FROM
  (SELECT ROWNUM RNUM,
    T1.*,
    T2.*
  FROM
    ( SELECT * FROM booking WHERE bookstate=? ORDER BY store_id DESC
    )T1 natural JOIN
    (SELECT COUNT(*) TOT_CNT FROM booking WHERE bookstate=?
    )T2
  )TT1
WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE);

--모든 예약 리스트 중에 검색
SELECT TT1.*, store.name
FROM
  (SELECT ROWNUM RNUM,
    T1.*,
    T2.*
  FROM
    ( SELECT * FROM booking WHERE sonnim_id=? ORDER BY store_id DESC
    )T1 natural JOIN
    (SELECT COUNT(*) TOT_CNT FROM booking WHERE sonnim_id=?
    )T2
  )TT1 inner join store
  on TT1.store_id = store.store_id
WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE)
and store.name like '?%';

--상태에 따른 예약 리스트중에 검색
SELECT TT1.*, store.name
FROM
  (SELECT ROWNUM RNUM,
    T1.*,
    T2.*
  FROM
    ( SELECT * FROM booking WHERE bookstate=? and sonnim_id=? ORDER BY store_id DESC
    )T1 natural JOIN
    (SELECT COUNT(*) TOT_CNT FROM booking WHERE bookstate=? and sonnim_id=?
    )T2
  )TT1 inner join store
  on TT1.store_id = store.store_id
WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE)
and store.name like '?%';
