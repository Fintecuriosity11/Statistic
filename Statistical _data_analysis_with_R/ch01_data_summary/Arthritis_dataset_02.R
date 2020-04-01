# gmodels package installation
install.packages("gmodels")

library(vcd)
library(gmodels)

crosstable(Arthritis$Improved, Arthritis$Treatment, prop.chisq=FALSE,
           + dnn=c("Improved", "Treatment"))

#범주형 변수가 3개이상 있을때는 다차원테이블(multidimensional table)생성
#2차원 테이블을 사용했던 table()함수나 xtabs()함수 모두 다차원 테이블을 생성

multtab <- with(Arthritis, table(Improved, Sex, Treatment))
multtab <- xtabs(~ Improved + Sex + Treatment, data=Arthritis)
multtab

#fttable() 함수는 다차원 테이블을 보다 단순하고 보기좋은 형태로 출력
ftable(multtab)

#row.vars인수나 col.vars인수를 이용하여 생과 열에 배치되는 변수 변경
ftable(multtab, row.vars = c(2,3))

#ftable()는 table()객체를 인수로 받을 수도 있고 데이터프레임(리스트)로 직접 테이블 생성
ftable(Arthritis[c("Improved", "Sex", "Treatment")], row.vars = c(2,3))

#margin.table(), prop.table(), addmargins()등도 3차원 이상으로 확장 가능
#예를 들어, xtabs()의 포뮬러 ~Improved+Sex+Treatment를 이용하여 테이블을 생성한 경우
#Improved는 차원1에 대응되고, Sex는 차원2에 대응, Treatment는 차원3에 대응
margin.table(multtab,1)

margin.table(multtab,2)

margin.table(multtab,3)

#Improved X Treatement 교차셀에 대한 빈도합 계산. 인덱스로 주어지지 않은 SEX에 대한 합산
margin.table(multtab, c(1,3))

#각각 Sex X Treatment 조합에 대한 Improved의 3레벨의 비율 표현
ftable(prop.table(multtab, c(2,3)))

#출력된 테이블을 보면 신약 처방을 받은 여성의 59.3%는 현저한 증상 개선(marked)
#있으며 반면 남성의 경우에는 그러한 비율이 35.7%에 그친다.
#prop.table()에서 호출되지 않은 차원에 대해 합산하면 비율의 합은 1이된다.
ftable(addmargins(prop.table(multtab, c(2,3)),1))