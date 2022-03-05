--�Խù����̺�(board)
--�÷�: seq(pk,����), writer(not null, �ۼ���),subject(not null, ����),content(����), 
--        regidate(default:sysdate,�ۼ��Ͻ�)

--���̺����
DROP TABLE board;
--���̺����
CREATE TABLE board(
seq NUMBER(5),
writer VARCHAR2(20) NOT NULL,
subject VARCHAR2(100) NOT NULL,
content VARCHAR2(1000),
regidate DATE DEFAULT sysdate,
PRIMARY KEY(seq)
);

--��ü��ȸ
SELECT * FROM board;
--�Ѱ���ȸ
SELECT * FROM board WHERE seq=1;

--����ū seq���ϱ�
SELECT MAX(seq)+1 seq FROM board;
--�߰�
INSERT INTO board (seq, writer, subject, content)
VALUES (1, 'java', '�����λ�', '������ �ݰ����ϴ�.');

INSERT INTO board (seq, writer, subject, content)
VALUES ((SELECT MAX(seq)+1 FROM board), '�̼���', '�λ�', '�氡�氡');
--�������̿� ��õ
INSERT INTO board (seq, writer, subject, content)
VALUES (s_seq.nextval, '�̹���', '��ħ�λ�', '�氡�氡');
--������ ����
DROP SEQUENCE s_seq;
CREATE SEQUENCE s_seq; --�Խù��� seq�� �����ϱ�����
SELECT s_seq.nextval FROM dual; --������ȣ
SELECT s_seq.currval FROM dual; --�����ȣ

--�ѰǼ���
UPDATE board
SET  writer = '����',
       subject = '�λ�',
       content = '�氡'
WHERE seq = 1;

--�Ѱǻ���
DELETE FROM board
WHERE seq = 1;

ROLLBACK; --���
COMMIT; --Ȯ��