
#일원분산분석은 집단을 구분하는 독립변수가 한 개인 경우에 모집단 간 평균의 동일성을 검정한다.
#datasets 패키지에 내장되어 있는 InsectSprays 데이터셋을 이용하여 일원분산분석 파악

#dataset에는 살충제에 대한 실험데이터가 기록되어 있다.
#6 종류의 살충제를 각각 12개의 실험공간에 살포한 후 살아남은 해충의 개수를 기록하였다.
str(InsectSprays)

tapply(InsectSprays$count, InsectSprays$spray, mean)

tapply(InsectSprays$count, InsectSprays$spray, sd)

tapply(InsectSprays$count, InsectSprays$spray, length)

install.packages("gplots")

#살충제 간의 평균 차이는 상당히 크고, 표준편차 차이 또한 매우 크다


#library(gplots)
#plotmean(count ~ spray, data=InsectSprays, barcol="tomato", barwidth=3, col="cornflowerblue", lwd=2, xlab="Type of Sprays", ylab="Insect Count", main="Performance of Insect Sprays\nwith 95% CI of Mean")

#일원분산분석을 통해 살충제 간 살충효과의 평균이 동일한지 통계적으로 검정
#일원분산분석 aov()함수를 이용하여 첫 번째 인수에 포율러 형식으로 인수 지정
#~앞에는 검정하고자 하는 종속변수 count를 지정하고, ~뒤에는 집단을 나타내는 독립변수 spray를 지정
#2번째 인수(data)에는 데이터 셋을 지정

sprays.aov<-aov(count ~ spray, data = InsectSprays)
sprays.aov

#aov()함수를 실행한 결과 생성된 모델 객체는 가설검정을 위한 충분한 정보를 제공하지 않는다.
#분산분석을 수행하여 생성된 모델 객체에 summary()함수를 적용하면 분산분석표(ANOVA Table)이 나오

summary(sprays.aov)
