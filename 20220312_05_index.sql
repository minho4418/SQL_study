--index
--�ӵ��� ����� ���ؼ�
--pk�� �ڵ� index����
--�ʹ� ���� index�� �ӵ� ����(insert, update, delete)
--���� ��ȸ�� �ӵ������ ���ؼ� index����
CREATE INDEX cust_cust_name_ix
ON customer(cust_name);
--book���̺� index�� �����Ѵٸ�


SELECT *
FROM customer
WHERE cust_name = '�̼���';
