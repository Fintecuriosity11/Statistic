# MASS 패키지에 포함된 데이터셋을 이용하여 빈도표 생성
# MASS 패키지에 포함된 survey데이터셋의 smoke열에는 
# 응답자의 흡연습관 데이터 저장

library(MASS)     
str(survey)

levels(survey$Smoke)

#table() 함수 이용해서 smoke변수에 대한 4가지 레벨별 
# 빈도 구함

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