/* 손님 */
CREATE TABLE SONNIM (
	sonnim_id NUMBER(10) NOT NULL, /* ID */
	email VARCHAR2(100 byte) NOT NULL, /* 이메일 */
	password VARCHAR2(200 byte) NOT NULL, /* 비밀번호 */
	phone VARCHAR2(30 byte) NOT NULL, /* 전화번호 */
	birthday DATE NOT NULL, /* 생년월일 */
	name VARCHAR2(50 byte) NOT NULL /* 이름 */
);

COMMENT ON TABLE SONNIM IS '손님';

COMMENT ON COLUMN SONNIM.sonnim_id IS 'ID';

COMMENT ON COLUMN SONNIM.email IS '이메일';

COMMENT ON COLUMN SONNIM.password IS '비밀번호';

COMMENT ON COLUMN SONNIM.phone IS '전화번호';

COMMENT ON COLUMN SONNIM.birthday IS '생년월일';

COMMENT ON COLUMN SONNIM.name IS '이름';

CREATE UNIQUE INDEX PK_SONNIM
	ON SONNIM (
		sonnim_id ASC
	);

CREATE UNIQUE INDEX UIX_SONNIM
	ON SONNIM (
		email ASC
	);

ALTER TABLE SONNIM
	ADD
		CONSTRAINT PK_SONNIM
		PRIMARY KEY (
			sonnim_id
		);

ALTER TABLE SONNIM
	ADD
		CONSTRAINT UK_SONNIM
		UNIQUE (
			email
		);

/* 손님 기본키 */
CREATE SEQUENCE SEQ_SONNIM START WITH 1000000000 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER TRG_SONNIM BEFORE
  INSERT
    ON SONNIM FOR EACH ROW WHEN
    (
      NEW.sonnim_id IS NULL
    )
    BEGIN :NEW.sonnim_id := SEQ_SONNIM.nextval;
END;
/

/* 음식점 */
CREATE TABLE STORE (
	store_id NUMBER(10) NOT NULL, /* ID */
	email VARCHAR2(100 byte) NOT NULL, /* 이메일 */
	password VARCHAR2(200 byte) NOT NULL, /* 비밀번호 */
	phone VARCHAR2(30 byte) NOT NULL, /* 전화번호 */
	name VARCHAR2(300 byte) NOT NULL, /* 이름 */
	zonecode VARCHAR2(20 byte) NOT NULL, /* 우편번호 */
	sido VARCHAR2(50 byte) NOT NULL, /* 시도 */
	sigungu VARCHAR2(50 byte) NOT NULL, /* 시군구 */
	address1 VARCHAR2(4000 byte) NOT NULL, /* 주소1 */
	address2 VARCHAR2(4000 byte) NOT NULL, /* 주소2 */
	maxbooking NUMBER(10) NOT NULL, /* 최대예약 */
	imageuri1 VARCHAR2(4000 byte), /* 이미지1 */
	imageuri2 VARCHAR2(4000 byte), /* 이미지2 */
	imageuri3 VARCHAR2(4000 byte), /* 이미지3 */
	imageuri4 VARCHAR2(4000 byte), /* 이미지4 */
	imageuri5 VARCHAR2(4000 byte), /* 이미지5 */
	open NUMBER(6) DEFAULT 9 NOT NULL, /* 시작시간 */
	closed NUMBER(6) DEFAULT 21 NOT NULL, /* 마감시간 */
	category VARCHAR2(30 byte) NOT NULL, /* 카테고리 */
	note CLOB DEFAULT empty_clob() /* 상세설명 */
);

COMMENT ON TABLE STORE IS '음식점';

COMMENT ON COLUMN STORE.store_id IS 'ID';

COMMENT ON COLUMN STORE.email IS '이메일';

COMMENT ON COLUMN STORE.password IS '비밀번호';

COMMENT ON COLUMN STORE.phone IS '전화번호';

COMMENT ON COLUMN STORE.name IS '이름';

COMMENT ON COLUMN STORE.zonecode IS '우편번호';

COMMENT ON COLUMN STORE.sido IS '시도';

COMMENT ON COLUMN STORE.sigungu IS '시군구';

COMMENT ON COLUMN STORE.address1 IS '주소1';

COMMENT ON COLUMN STORE.address2 IS '주소2';

COMMENT ON COLUMN STORE.maxbooking IS '최대예약';

COMMENT ON COLUMN STORE.imageuri1 IS '이미지1';

COMMENT ON COLUMN STORE.imageuri2 IS '이미지2';

COMMENT ON COLUMN STORE.imageuri3 IS '이미지3';

COMMENT ON COLUMN STORE.imageuri4 IS '이미지4';

COMMENT ON COLUMN STORE.imageuri5 IS '이미지5';

COMMENT ON COLUMN STORE.open IS '시작시간';

COMMENT ON COLUMN STORE.closed IS '마감시간';

COMMENT ON COLUMN STORE.category IS '카테고리';

COMMENT ON COLUMN STORE.note IS '상세설명';

CREATE UNIQUE INDEX PK_STORE
	ON STORE (
		store_id ASC
	);

CREATE UNIQUE INDEX UIX_STORE
	ON STORE (
		email ASC
	);

ALTER TABLE STORE
	ADD
		CONSTRAINT PK_STORE
		PRIMARY KEY (
			store_id
		);

ALTER TABLE STORE
	ADD
		CONSTRAINT UK_STORE
		UNIQUE (
			email
		);

/* 음식점 기본키 */
CREATE SEQUENCE SEQ_STORE START WITH 1000000000 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER TRG_STORE BEFORE
  INSERT
    ON STORE FOR EACH ROW WHEN
    (
      NEW.store_id IS NULL
    )
    BEGIN :NEW.store_id := SEQ_STORE.nextval;
END;
/

/* 예약 */
CREATE TABLE BOOKING (
	no NUMBER(10) NOT NULL, /* 예약번호 */
	sonnim_id NUMBER(10) NOT NULL, /* 손님아이디 */
	store_id NUMBER(10) NOT NULL, /* 음식점아이디 */
	bookdate DATE NOT NULL, /* 예약일 */
	bookstate NUMBER(10) DEFAULT 0 NOT NULL, /* 예약상태 */
	booktime NUMBER(10) NOT NULL, /* 예약시간 */
	bookperson NUMBER(10) NOT NULL, /* 예약인원 */
	writedate DATE DEFAULT sysdate NOT NULL, /* 신청날짜 */
	note VARCHAR2(4000 byte) /* 요청사항 */
);

COMMENT ON TABLE BOOKING IS '예약';

COMMENT ON COLUMN BOOKING.no IS '예약번호';

COMMENT ON COLUMN BOOKING.sonnim_id IS '손님아이디';

COMMENT ON COLUMN BOOKING.store_id IS '음식점아이디';

COMMENT ON COLUMN BOOKING.bookdate IS '예약일';

COMMENT ON COLUMN BOOKING.bookstate IS '예약상태';

COMMENT ON COLUMN BOOKING.booktime IS '예약시간';

COMMENT ON COLUMN BOOKING.bookperson IS '예약인원';

COMMENT ON COLUMN BOOKING.writedate IS '신청날짜';

COMMENT ON COLUMN BOOKING.note IS '요청사항';

CREATE UNIQUE INDEX PK_BOOKING
	ON BOOKING (
		no ASC
	);

CREATE INDEX FK_SONNIM_TO_BOOKING
	ON BOOKING (
		sonnim_id ASC
	);

CREATE INDEX FK_STORE_TO_BOOKING
	ON BOOKING (
		store_id ASC
	);

ALTER TABLE BOOKING
	ADD
		CONSTRAINT PK_BOOKING
		PRIMARY KEY (
			no
		);

/* 예약 기본키 */
CREATE SEQUENCE SEQ_BOOKING START WITH 1 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER TRG_BOOKING BEFORE
  INSERT
    ON BOOKING FOR EACH ROW WHEN
    (
      NEW.no IS NULL
    )
    BEGIN :NEW.no := SEQ_BOOKING.nextval;
END;
/

/* 좋습니다 */
CREATE TABLE HEART (
	sonnim_id NUMBER(10) NOT NULL, /* 손님아이디 */
	store_id NUMBER(10) NOT NULL /* 음식점아이디 */
);

COMMENT ON TABLE HEART IS '좋습니다';

COMMENT ON COLUMN HEART.sonnim_id IS '손님아이디';

COMMENT ON COLUMN HEART.store_id IS '음식점아이디';

CREATE UNIQUE INDEX PK_HEART
	ON HEART (
		sonnim_id ASC,
		store_id ASC
	);

ALTER TABLE HEART
	ADD
		CONSTRAINT PK_HEART
		PRIMARY KEY (
			sonnim_id,
			store_id
		);

/* 손님지원qna */
CREATE TABLE SON_HELP (
	seq_no NUMBER(10) NOT NULL, /* 글번호 */
	sonnim_id NUMBER(10) NOT NULL, /* 손님아이디 */
	title VARCHAR2(4000 byte) NOT NULL, /* 제목 */
	content CLOB DEFAULT empty_clob() NOT NULL, /* 내용 */
	writedate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	readcount NUMBER(10) DEFAULT 0 NOT NULL, /* 조회수 */
	parent NUMBER(10), /* 부모글번호 */
	notice NUMBER(10) DEFAULT 0, /* 공지사항 */
	reply_yn NUMBER(10) DEFAULT 0 NOT NULL /* 답변유무 */
);

COMMENT ON TABLE SON_HELP IS '손님지원qna';

COMMENT ON COLUMN SON_HELP.seq_no IS '글번호';

COMMENT ON COLUMN SON_HELP.sonnim_id IS '손님아이디';

COMMENT ON COLUMN SON_HELP.title IS '제목';

COMMENT ON COLUMN SON_HELP.content IS '내용';

COMMENT ON COLUMN SON_HELP.writedate IS '작성일';

COMMENT ON COLUMN SON_HELP.readcount IS '조회수';

COMMENT ON COLUMN SON_HELP.parent IS '부모글번호';

COMMENT ON COLUMN SON_HELP.notice IS '공지사항';

COMMENT ON COLUMN SON_HELP.reply_yn IS '답변유무';

CREATE UNIQUE INDEX PK_SON_HELP
	ON SON_HELP (
		seq_no ASC
	);

CREATE INDEX FK_SONNIM_TO_SON_HELP
	ON SON_HELP (
		sonnim_id ASC
	);

CREATE INDEX FK_SON_HELP_TO_SON_HELP
	ON SON_HELP (
		parent ASC
	);

ALTER TABLE SON_HELP
	ADD
		CONSTRAINT PK_SON_HELP
		PRIMARY KEY (
			seq_no
		);

/* 손님지원qna */
CREATE SEQUENCE SEQ_SON_HELP START WITH 1 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER TRG_SON_HELP BEFORE
  INSERT
    ON SON_HELP FOR EACH ROW WHEN
    (
      NEW.seq_no IS NULL
    )
    BEGIN :NEW.seq_no := SEQ_SON_HELP.nextval;
END;
/

/* 음식점지원qna */
CREATE TABLE STORE_HELP (
	seq_no NUMBER(10) NOT NULL, /* 글번호 */
	store_id NUMBER(10) NOT NULL, /* 음식점아이디 */
	title VARCHAR2(4000 byte) NOT NULL, /* 제목 */
	content CLOB DEFAULT empty_clob() NOT NULL, /* 내용 */
	writedate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	readcount NUMBER(10) DEFAULT 0 NOT NULL, /* 조회수 */
	parent NUMBER(10), /* 부모글번호 */
	notice NUMBER(10) DEFAULT 0, /* 공지사항 */
	reply_yn NUMBER(10) DEFAULT 0 NOT NULL /* 답변유무 */
);

COMMENT ON TABLE STORE_HELP IS '음식점지원qna';

COMMENT ON COLUMN STORE_HELP.seq_no IS '글번호';

COMMENT ON COLUMN STORE_HELP.store_id IS '음식점아이디';

COMMENT ON COLUMN STORE_HELP.title IS '제목';

COMMENT ON COLUMN STORE_HELP.content IS '내용';

COMMENT ON COLUMN STORE_HELP.writedate IS '작성일';

COMMENT ON COLUMN STORE_HELP.readcount IS '조회수';

COMMENT ON COLUMN STORE_HELP.parent IS '부모글번호';

COMMENT ON COLUMN STORE_HELP.notice IS '공지사항';

COMMENT ON COLUMN STORE_HELP.reply_yn IS '답변유무';

CREATE UNIQUE INDEX PK_STORE_HELP
	ON STORE_HELP (
		seq_no ASC
	);

CREATE INDEX FK_STORE_HELP_TO_STORE_HELP
	ON STORE_HELP (
		parent ASC
	);

CREATE INDEX FK_STORE_TO_STORE_HELP
	ON STORE_HELP (
		store_id ASC
	);

ALTER TABLE STORE_HELP
	ADD
		CONSTRAINT PK_STORE_HELP
		PRIMARY KEY (
			seq_no
		);

/* 음식점지원qna */
CREATE SEQUENCE SEQ_STORE_HELP START WITH 1 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER TRG_STORE_HELP BEFORE
  INSERT
    ON STORE_HELP FOR EACH ROW WHEN
    (
      NEW.seq_no IS NULL
    )
    BEGIN :NEW.seq_no := SEQ_STORE_HELP.nextval;
END;
/

/* 음식점손님qna */
CREATE TABLE STORE_SON (
	seq_no NUMBER(10) NOT NULL, /* 글번호 */
	sonnim_id NUMBER(10) NOT NULL, /* 손님아이디 */
	store_id NUMBER(10) NOT NULL, /* 음식점아이디 */
	title VARCHAR2(4000 byte) NOT NULL, /* 제목 */
	content CLOB DEFAULT empty_clob() NOT NULL, /* 내용 */
	writedate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	readcount NUMBER(10) DEFAULT 0 NOT NULL, /* 조회수 */
	parent NUMBER(10), /* 부모글번호 */
	reply_yn NUMBER(10) DEFAULT 0 NOT NULL /* 답변유무 */
);

COMMENT ON TABLE STORE_SON IS '음식점손님qna';

COMMENT ON COLUMN STORE_SON.seq_no IS '글번호';

COMMENT ON COLUMN STORE_SON.sonnim_id IS '손님아이디';

COMMENT ON COLUMN STORE_SON.store_id IS '음식점아이디';

COMMENT ON COLUMN STORE_SON.title IS '제목';

COMMENT ON COLUMN STORE_SON.content IS '내용';

COMMENT ON COLUMN STORE_SON.writedate IS '작성일';

COMMENT ON COLUMN STORE_SON.readcount IS '조회수';

COMMENT ON COLUMN STORE_SON.parent IS '부모글번호';

COMMENT ON COLUMN STORE_SON.reply_yn IS '답변유무';

CREATE UNIQUE INDEX PK_STORE_SON
	ON STORE_SON (
		seq_no ASC
	);

CREATE INDEX FK_STORE_SON_TO_STORE_SON
	ON STORE_SON (
		parent ASC
	);

CREATE INDEX FK_SONNIM_TO_STORE_SON
	ON STORE_SON (
		sonnim_id ASC
	);

CREATE INDEX FK_STORE_TO_STORE_SON
	ON STORE_SON (
		store_id ASC
	);

ALTER TABLE STORE_SON
	ADD
		CONSTRAINT PK_STORE_SON
		PRIMARY KEY (
			seq_no
		);

/* 음식점손님qna 기본키 */
CREATE SEQUENCE SEQ_STORE_SON START WITH 1 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER TRG_STORE_SON BEFORE
  INSERT
    ON STORE_SON FOR EACH ROW WHEN
    (
      NEW.seq_no IS NULL
    )
    BEGIN :NEW.seq_no := SEQ_STORE_SON.nextval;
END;
/

/* 리뷰 */
CREATE TABLE REVIEW (
	book_no NUMBER(10) NOT NULL, /* 예약번호 */
	sonnim_id NUMBER(10) NOT NULL, /* 손님아이디 */
	store_id NUMBER(10) NOT NULL, /* 음식점아이디 */
	memo VARCHAR2(4000 byte) NOT NULL, /* 한줄평 */
	starpoint NUMBER(10) NOT NULL /* 별점 */
);

COMMENT ON TABLE REVIEW IS '리뷰';

COMMENT ON COLUMN REVIEW.book_no IS '예약번호';

COMMENT ON COLUMN REVIEW.sonnim_id IS '손님아이디';

COMMENT ON COLUMN REVIEW.store_id IS '음식점아이디';

COMMENT ON COLUMN REVIEW.memo IS '한줄평';

COMMENT ON COLUMN REVIEW.starpoint IS '별점';

CREATE UNIQUE INDEX PK_REVIEW
	ON REVIEW (
		book_no ASC
	);

CREATE INDEX FK_BOOKING_TO_REVIEW
	ON REVIEW (
		book_no ASC
	);

CREATE INDEX FK_SONNIM_TO_REVIEW
	ON REVIEW (
		sonnim_id ASC
	);

CREATE INDEX FK_STORE_TO_REVIEW
	ON REVIEW (
		store_id ASC
	);

ALTER TABLE REVIEW
	ADD
		CONSTRAINT PK_REVIEW
		PRIMARY KEY (
			book_no
		);