# MASS ��Ű���� ���Ե� �����ͼ��� �̿��Ͽ� ��ǥ ����
# MASS ��Ű���� ���Ե� survey�����ͼ��� smoke������ 
# �������� �������� ������ ����

library(MASS)     
str(survey)

levels(survey$Smoke)

#table() �Լ� �̿��ؼ� smoke������ ���� 4���� ������ 
# �� ����

frqtab<-table(survey$Smoke)
frqtab

class(frqtab)

frqtab[2]

frqtab==max(frqtab)
frqtab[frqtab==max(frqtab)]

names(frqtab[frqtab==max(frqtab)])

which.max(frqtab)

frqtab[which.max(frqtab)]

names(frqtab[which.max(frqtab)])