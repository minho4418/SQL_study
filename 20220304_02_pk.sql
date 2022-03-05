--��ǰ���̺�(item)
--�÷�:itemcode(��ǰ�ڵ�),itemname(��ǰ��), price(�ܰ�), regidate(�����),modidate(������)
--���̺����
DROP TABLE item;
--���̺����
--PRIMARY KEY(�⺻Ű): ���Ἲ�� ���ؼ�
--            �������� �ߺ��� ������� �ʴ´�
--            null�� ������� �ʴ´�
CREATE TABLE item(
itemcode CHAR(4), --��������4
itemname VARCHAR2(50) NOT NULL , --��������50
price NUMBER(7) NOT NULL,
regidate DATE DEFAULT sysdate,
modidate DATE DEFAULT sysdate,
PRIMARY KEY(itemcode) --�⺻Ű(����Ű)
);
--��ü��ȸ
SELECT * FROM item;
--�Ѱ���ȸ(���ǿ� pk�� �̿�)
SELECT * FROM item WHERE itemcode = '8801';
--�߰�
INSERT INTO item (itemcode, itemname, price) VALUES('8801', '�����', 1000);
INSERT INTO item (itemcode, itemname, price) VALUES('8802', '���ڱ�', 1300);
INSERT INTO item (itemcode, itemname, price) VALUES('8803', '���', 800);
--�ѰǼ���
UPDATE item
SET itemname = '�����',
      price = 900,
      modidate = sysdate
WHERE itemcode = '8803'; --pk�� ��������

--�Ѱǻ���
DELETE FROM item
WHERE itemcode = '8803'; --pk�� ��������
