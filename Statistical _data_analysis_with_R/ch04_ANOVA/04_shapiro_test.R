
install.packages("car")
library(car)

qqplot(InsectSprays$count, pch=20, col="deepskyblue", id=FALSE, main="Q-Q Plot", xlab = "Theoratical Quantiles", ylab = "Sample Quantiles")


#그래프상에 정규성 충족 여부가 명확히 드러나는 경우가 아니라면 시각적으로만 정규성 가정을 평가하는데 어려울 수도 있다.
#샤피로 윌크검정을 통해 정규성 충족 여부를 통계적 검정
shapiro.test(InsectSprays$count)


#검정격ㄹ과에 따르면 유의수준이 0.05에서 관측값이 정규분포한다는 귀무가설을 기각한다. 
#따라서 정규성 가정은 충족 못한다.
#데이터 분포가 극단적으로 비정규성을 보이지 않는 한 그다지 걱정할 필요는 없다.
#집단을 구성하는 표본의 크기가 작을 경우에는 이상점과 같은 비정상적인 관측값이 미칠 수 있는 영향을 주의 깊게 살펴야 한다.

#비정상적 관측값은 평균과 표준편차에 큰 영향을 미칠 수 있기때문에 이들을 제거한 후 분산분석을 진행한다. 

#무조건 car패키지를 실행해야 outlier.test()함수 사용가능

outlier.test(sprays.aov)

#집단 간 분산의 동일성 여부는 레벤검정(Levene test)이나 바틀렛검정(Bartlett test)을 통해 확인 가능
#leveneTest()함수는 (car 패키지)와 bartlett.test()함수(stats 패키지)는 집단 간의 분산이 동일하다는 귀무가설 검증

leveneTest(count ~ spray, data = InsectSprays)

bartlett.test(count ~ spray, data = InsectSprays)

#검정 결과를 보면 p값이 유의수준 0.05에 비해 매우 작으며, 귀무가설은 기각되었다. 
#등분산의 가정을 충족하지 못할 때는 oneway.test()함수를 이용하여 일원분산분석 수행을 한다.

#oneway.test()함수는 기본적으로 집단간의 등분산을 가정하지 않는 반면, aov()는 등분산을 가정하기 때문이다. 
#만일 집단간의 분산이 같다면 var.equal=TRUE를 지정함으로써 보다 덜 보수적인(적극적으로 귀무가설 기각)검정결과를 얻을 수 있다.

oneway.test(count ~ spray, data = InsectSprays)

oneway.test(count ~ spray, data = InsectSprays, var.equal = TRUE)
