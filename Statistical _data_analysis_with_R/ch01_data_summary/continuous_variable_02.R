library(vcd)
library(gmodels)
library(MASS)

#mtcars데이터 셋 구조확인
#32개의 자동차 모델의 연비(mpg),마력(hp),무게(wt)등의 정보가 있다.
str(mtcars)

#pastecs패키지에 포함된 stat.desc()함수를 이용하여 mtcars데이터셋에 포함된 
#자동차의 연비, 마력, 무게의 기술통계량 확인 가능
install.packages("pastecs")
library(pastecs)
stat.desc(mtcars[c("mpg","hp","wt")])

install.packages("psych")

#describe()함수는 관측값 개수(n), 평균(mean), 표준편차(sd), 중위수(median),
#절삭평균(기본값 trim=0.1,상하위 10%를 제외한 평균,trimmed), 중위수 절대편차(median absolute deviation)
#최소값(min),최대값(max),범위(range), 왜도(skew),첨도(kurtosis), 표존오차(se) 를 계산

library(psych)
describe(mtcars[c("mpg","hp","wt")])

#tapply()집단별 기술통계량을 구하는데 쓴다.
#tapply()함수의 첫번째 인수에는 벡터형식 데이터셋 지정
#tapply()함수의 2번째 인수(INDEX)에는 집단을 나타내는 범주형 변수(팩터) 지정
#tapply()함수의 3번째 인수(FUN)에는 사용하고자 하는 통계량의 계산 함수 지정

tapply(survey$Pulse, INDEX = survey$Exer, Fun=mean, na.rm=TRUE)

tapply(survey$Pulse, INDEX = survey$Sex, mean, na.rm=TRUE)

#tapply()함수에 집단 구분 변수를 리스트 형식으로 지정
tapply(survey$Pulse, list(survey$Exer, survey$Sex), mean, na.rm=TRUE)

#aggregate()함수를 이용해도 출력형태는 다르지만 동일한 결과나옴
aggregate(survey$Pulse, by=list(Exercise$survey$Exer), FUN=mean, na.rm=TRUE)

#aggregate()함수의 FUN인수에는 사용자 정의 함수도 지정가능
#집단별로 관측값 개수, 평균, 표준편차, 왜도, 첨도등을 계산

myStats<-function(x,na.rm=FALSE){
if(na.rm) x <- x[!is.na(x)]
n <-length(x)
mean <-mean(x)
sd<- sd(x)
skew<-sum((x-mean)^3/sd^3)/n
kurt<-sum((x-mean)^4/sd^4)/n-3
return(c(n=n, mean=mean, sd=sd, skewness=skew, kurtosis=kurt))
}

aggregate(survey[c("Pulse","Age")],
list(Exercise=survey$Exer), myStats, na.rm=TRUE)