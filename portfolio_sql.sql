CREATE TABLE po_board(
bno NUMBER NOT NULL PRIMARY key,
title varchar2(100) NOT null,
content varchar2(100) NOT null,
writer varchar2(100) NOT NULL,
regdate DATE DEFAULT sysdate
);

CREATE SEQUENCE po_board_seq START WITH 1 INCREMENT BY 1 NOcache;

ALTER TABLE po_board MODIFY(content VARCHAR2(4000)); 


DROP TABLE PO_BOARD ;
DROP TABLE po_reply ;
DROP SEQUENCE po_board_seq;

INSERT INTO po_board(bno, title, content, writer)
VALUES (po_board_seq.nextval, '첫 글 인서트', '첫글 인서트입니다', 'TEST'); 

SELECT * FROM po_board;

COMMIT;

DELETE FROM PO_BOARD  WHERE bno = 2;

INSERT INTO po_board(bno, title, content, writer)
SELECT po_board_seq.nextval, title, content, writer FROM po_board;

COMMIT;

	SELECT BNO
		, TITLE
		, WRITER
		, REGDATE
		FROM po_BOARD
		ORDER BY BNO DESC;

SELECT * FROM po_BOARD ;

CREATE TABLE po_reply(
bno number not NULL,
rno NUMBER not NULL, 
content varchar2(1000) NOT NULL,
writer varchar2(50) NOT NULL,
regdate DATE DEFAULT sysdate,
PRIMARY KEY(bno, rno)
);

SELECT * FROM PO_REPLY;
ALTER TABLE PO_REPLY MODIFY content varchar2(1000) null;
alter table PO_REPLY modify column content varchar2(1000);
COMMIT;


ALTER TABLE po_reply ADD editdate DATE DEFAULT sysdate;

	update po_reply set content = 'sss', editdate = sysdate
  	where rno = 388;

SELECT * FROM PO_REPLY;

ALTER TABLE po_reply ADD CONSTRAINT po_reply_bno FOREIGN key(bno)
REFERENCES po_board(bno);

CREATE SEQUENCE po_reply_seq START WITH 1 MINVALUE 0;

DROP SEQUENCE po_reply_seq;

COMMIT;

INSERT INTO po_reply(bno, rno, content, writer)
values(361, po_reply_seq.nextval, '테스트 댓글', '작성자');

SELECT rno, content, writer, regdate
FROM PO_REPLY
WHERE bno = 361;

DELETE FROM PO_REPLY WHERE bno = 361;

DROP TABLE po_member;

CREATE TABLE po_member(
userId varchar2(40) NOT NULL,
userPass varchar2(100)	 NOT NULL,
userName varchar2(40) NOT NULL,
email varchar2(100)	NOT NULL,
regdate DATE DEFAULT sysdate,
PRIMARY KEY(userid)
);

COMMIT;

DELETE FROM PO_MEMBER;

ALTER TABLE po_board add(hit NUMBER DEFAULT 0);

COMMIT;

select count(bno) from po_board WHERE bno > 0 ;

