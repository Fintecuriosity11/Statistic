#분산분석을 통해 6 종류 살충제 간 살충효과의 차이는 없다는 귀무가설을 기각할 수 있었다.
#하지만 이것만으로는 모집단평균이 모두 동일하다는 주장을 기각할 수 있을 뿐이며,
#어느 집단과 어느 집단이 서로 달라서 이러한 결과가 나왔는지 알지 못한다.

#model.tables()함수를 이용하면 개별 집단 간 평균의 차이를 확인할 수 있다.
#model.tables()함수는 집단 간 평균의 차이를 두 가지 다른 형식으로 보여준다.
#type="mean"을 지정하면 각 집단의 평균을 확인할 수 있으며, type="effect"를 지정하면 집단별로 각 집단평균과 전체평균
#의 차이를 볼 수 있다.

model.tables(sprays.aov, type = "mean")

model.tables(sprays.aov, type = "effect")


#예를 들어, 살충제를 구매하는 의사결정을 해야 할 때는 가장 살충 효과가 좋은 살충제C를 사는 것이 반드시 좋은 결정은 아닐 수도 있다.
#살충효과는 가장 좋겠지만 아무래도 가격은 가장 비쌀 것이기 때문이다.
#만일 좀 더 저렴한 살충제 D의 효과가 살충제C와 실제로는 차이가 없다고 하면 비싼 살충제C를 구매할 필요가 없다.

#2개의 살충제 간의 살충효과가 유의한 차이를 보이는지 검정하기 위해서는 터키HSD검정 사용
#(Tukey honest significant difference test)

#이러한 검정을 사후분석(post-hoc analysis)이라고 하며 다중비교(multiple comparison)를 통해 집단 간의 차이를 검정한다.

sprays.compare<-TukeyHSD(sprays.aov)
sprays.compare

#TukeyHSD()함수는 리스트 형식의 모델 객체를 생성합니다.
#이 객체에는 6 종류의 살충제가 만들어 내는 모든 가능한 비교쌍 간의 평균차이
#95% 신뢰구간의 상합값 및 하한값, 평균 차이에 대한 p값 포함


#유의한 차이를 보이는 살충제쌍도 있고, 그렇지 않은 쌍도 있다.
#이처럼 어느 하나의 쌍이라도 유의한 차이가 나타나면 분산분석에서는 모든 살충제간의 살충 효과가 동일하다는 귀무가설을 기각

#살충제 D,C비교
sprays.compare$spray['D-C',]

plot(TukeyHSD(sprays.aov), col="blue", las=1)


#multcomp 패키지 glht()함수는 다중비교를 위한 다양한 방법 제공
#터키 HSD 검정을 수행 후 상자도표 형태로 그래프를 그릴 수 있다.
install.packages("multcomp")

#glht()함수의 첫 번째 인수(model)에는 분석을 위한 모델 객체를 지정한다.
#linfct 인수에는 검정할 가설을 지정하고
#분산분석 모델의 다중비교의 경우에는 mcp()함수로부터 반환된 객체 지정
#mcp(spray="Tukey")는 spray변수에 의한 구분되는 집단을 바탕으로 터키HSD 다중비교 수행
#cld()함수는 glht()함수의 결과 객체로부터 모든 범주쌍의 비교결과를 알파벳 문자 형식으로 추출.

library(multcomp)
tuk.hsd<-glht(model=sprays.aov, linfct=mcp(spray="Tukey"))
plot(cld(tuk.hsd, level=0.05), col="orange")

#위의 그래프는 범주의 개수가 많을 수록 유용하고, 각 범주별로 종속변수값의 분포 확인 가능