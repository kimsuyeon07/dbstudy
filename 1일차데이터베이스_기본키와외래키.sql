-- �� �����̼� (�θ����̺�)
    -- NVARCHAR2(30) : 30����
    -- VARCHAR2(30) : 30����Ʈ�� �뷮
    -- VARCHAR2 (���� ���ϴ� ��)
    -- CHAR(1) : 1������ �ܾ� (������ �ʴ� ��)
create table ��
(
    �����̵� VARCHAR2(30) PRIMARY KEY,
    ���̸� VARCHAR2(30),
    ���� NUMBER(3),
    ��� CHAR(1),
    ���� VARCHAR2(5),
    ������ NUMBER(7)
);
    
    
-- �ֹ� �����̼� (�ڽ����̺�)
CREATE TABLE �ֹ�
(
    �ֹ���ȣ NUMBER PRIMARY KEY,
    �ֹ��� VARCHAR2(30) REFERENCES ��(�����̵�), --�ܷ�Ű(�����̺��� �����̵� Į���� ����), FOREIGN KEY(FK)
    �ֹ���ǰ VARCHAR2(20),
    ���� NUMBER,
    �ܰ� NUMBER,
    �ֹ����� DATE
);

drop table ��;