--ddl
--���̺����
DROP TABLE sample;
--���̺� ����
CREATE TABLE sample(
name VARCHAR2(20), --�ִ� 20�ڸ��� ���ڿ�
age NUMBER(3), --����3�ڸ�
regidate DATE DEFAULT sysdate--����ý����� ��¥�� �ڵ� �߰�
);
DESC sample; --���̺��� ���� Ȯ��

--dml
--��ȸ(select)
SELECT name, age, TO_CHAR(regidate, 'YYYY-MM-DD HH24:MI:SS') regidate
FROM sample;
--�߰�(insert��)
INSERT INTO sample(name, age, regidate) VALUES('ȫ�浿',20,'2022-03-04');
INSERT INTO sample VALUES('����',39,'2022-03-03'); --���̺�� �����Ͱ� ��ġ�Ұ�� �ʵ� ����
INSERT INTO sample(name, age) VALUES('BTS',25);
INSERT INTO sample(name, age, regidate) VALUES('�̼���',53, sysdate);

--����(update��)
UPDATE sample
SET age = 40,
      regidate = sysdate
WHERE NAME ='ȫ�浿';

--����(delete��)
DELETE FROM sample
WHERE NAME='BTS';

--�ǽ�)������̺�(member)
--�÷�: userid(���̵�), passwd(��й�ȣ), email(�̸���), birthyear(����⵵), 
--regidate(�����:sysdate), modidate(������:sysdate)

--���̺����
DROP TABLE member;
--���̺����
CREATE TABLE member(
userid VARCHAR2(20),
passwd VARCHAR2(30),
email VARCHAR2(50),
birthyear NUMBER(4),
regidate DATE DEFAULT sysdate,
modidate DATE DEFAULT sysdate
);
--��ü��ȸ
SELECT * FROM member;
--�Ѱ���ȸ
SELECT * FROM member
WHERE userid = 'java';
--�߰�
INSERT INTO member(userid, passwd, email, birthyear)
VALUES('java', '1111', 'java@gmail.com', 2000);
--����
UPDATE member 
SET passwd = '1234',
      email = 'java@naver.com',
      birthyear = 2001,
      modidate = sysdate
WHERE userid = 'java';
--����
DELETE FROM member
WHERE userid = 'java';

--Ʈ������� �����ϱ� ���� DCL
ROLLBACK;--undo���
COMMIT; --redoȮ��