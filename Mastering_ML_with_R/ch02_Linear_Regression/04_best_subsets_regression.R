##############################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

##############################################################################################################


###최량 부분 집합 회귀 분석(best subset regression)
##피처선택(최량 부분 집합 회귀 분석을 이용한 최적합 모형)


install.packages("leaps")

library(car)
library(leaps)

#lm()함수를 이용해서 모든 피처변수를 포함한 선형 모형을 만든다.
#모든 피처를 손쉽게 포함하고 싶다면, 물결표(~) 다음에 변수명을 모두 써넣는 개신, 마침표(.)하나를 찍으면 됨

fit<- lm(BSAAM ~., data = socal.water)
summary(fit)


#단변량 선형회귀에서와 같이 p값과 F-통계량을 검사해서 피처의 계수들 중 적어도 하나 이상은 0이 아닌 것을 확인


##############################################################################################################

#사실 p값은 유의수준이 높게 나옴. OPRC, OPSLAKe의 계수도 유의한 P값을 보인다.
#OPBPC는 반응 변수와 높은 상관관계를 보임에도 불구하고 p값은 유의하지 않게 나왔다. 
#다른 OP피처의 값을 고정했을때 OPBPC는 반응 변수의 변동량을 더 이상 유의미한 수준으로 설명못함

#즉 OPRC와 OPSLAKE가 모형에 이미 들어 있는 경우에는 OPBPC가 모형에 통계적으로 아무런 기여를 못함

##############################################################################################################


#처음 생성된 모형으로 최량 부분 집합 기법 사용
#leaps 패키지에 있는 regsubset()함수를 이용해 sub.fit 오브젝트를 다음과 같이 생성

sub.fit<-regsubsets(BSAAM ~., data = socal.water)

#모형을 더 깊게 조사하기 위해서 best.summary 오브젝트를 생성.
#names()함수를 이용해 출력 가능한 아웃풋의 목록 확인

best.summary<-summary(sub.fit)
names(best.summary)

#모형 선택에서 유용한 다른 함수는 which.mean()과 which.max()
#최솟값과 최대값을 모형에 제고

which.min(best.summary$rss)

which.max(best.summary$rss)

##############################################################################################################
#선형 모형에서 AIC와 Cp는 서로 비례하므로 Cp만 신경
#BIC는 Cp보다 적은 수의 변수를 갖는 모형을 선택하는 경향이 있다.


#아래에 Cp를 만들고 BIC를 출력

#왼쪽 그림에는 피처 3개로 구성된 모형이 가장 작은 cp값을 가진다.
#오른쪽 그림에서는 가장 작은 Cp값을 제공하는 피처를 나타낸다.
#그림에서 가장 작은 Cp값을 y축에서 선택하고, 그 점에서 오른쪽으로 가로지르면, 색칠된 블록에 해당하는 피처 x축
##############################################################################################################


par(mfrow = c(1,2))
plot(best.summary$cp, xlab = "number of features", ylab = "cp")
plot(sub.fit, scale = "Cp")


#which.min()과 which.max()함수를 사용해 Cp가 BIC, 수정 R제곱값과 어떻게 다른지 확인

which.min(best.summary$bic)

which.max(best.summary$adjr2)

#BIC와 수정 R제곱값은 최적 모형에서 Cp와 일치
#단변량 회귀에서와 마찬가지로, 모형을 점검하고 가정을 테스트
#선형모형의 오브젝트를 만든다.

best.fit<-lm(BSAAM ~ APSLAKE + OPRC + OPSLAKE, data = socal.water)
summary(best.fit)

#피처 수가 3개인 모형에서, F-통계량과 t-test는 모두 유의한 p값을 보인다.

#진단용 도표를 그린 후, 패널에 4개 그림 생성
#잔차의 분산은 일정하고 분포는 정규분포를 따름.

par(mfrow = c(2,2))
plot(best.fit)

##############################################################################################################


#공선형성(collinearity)의 문제가 있는지 조사하려면, 분산 팽창인자(variance inflation factor,VIF)통계량 사용
#VIF는 모든 피처가 들어 있는 전체 모형(full model)을 적합화할 때 계산된 특정한 피처 계수의 분산과
#그 피처에 들어있는 부분 모형으로 적합화 했을 때의 분산의 비율

#VIF가 가질 수 있는 최솟값은 1인데, 이는 공선형성이 전혀 없는 경우.
#대개 VIF값이 5를 넘으면 공선형성이 존재한다고 볼 수 있음.
#VIF값을 정확하게 선택하기 어려운 이유는 언제나 다중 공선성 때문에 모형을 쓸 수 없는 엄밀한 통계적 구분점 X

#참고 vif함수는 car패키지에 들어 있어서 car패키지를 실행시키지 않으면 안나온다. ********

##############################################################################################################

vif(best.fit)

#도표 실행
#상관관계 분석(OPRC와 OPSLAKE변수 그림)

par(mfrow = c(1,1))
plot(socal.water$OPRC, socal.water$OPSLAKE, xlab = "OPRC", ylab = "OPSLAKE")

#수정 R제곱값

best.summary$adjr2  

#변수 2개로만 이루어진 모형의 가정 점검

fit.2<- lm(BSAAM ~ APSLAKE+OPSLAKE, data = socal.water)
summary(fit.2)

par(mfrow=c(2,2))
plot(fit.2)

#공선형성 없으니, vif()함수로 분산 팽창인자 확인

vif(fit.2)

##############################################################################################################

#Residual vs Fitted 그림은 문제 없음
#R로 오차항의 등분산성이라는 가정을 공식적으로 테스트도 가능
#브루시-페이건(Breusch-pagan, BP) 테스트로 lm패키지를 띄운 후 다음 한 줄의 명령어를 실행
#BP테스트는 귀무가설이 "오차항은 등분산성을 띈다", 대립가설이 "오차항은 이분산성을 띈다."

##############################################################################################################


library(lmtest)
bptest(fit.2)

#p값이 0.9977로 크므로 귀무가설을 기각할 근거가 부족하다.
#고로 오차항은 등분산성을 띈다

#가장 좋은 예측모형은 두 피처 APSLAKE와 OPSLAKE로 만든 모형이다.

par(mfrow=c(1,1))
plot(fit.2$fitted.values, socal.water$BSAAM, xlab = "predicted", ylab = "actual", main = "Predicted vs. Actual")

#반응 변수인 BSAAM의 이름을 Actual로 바꿔 새로운 벡터로서 데이터 프레임에 넣는다.

socal.water["Actual"] = water$BSAAM # 벡터 Actual 생성
socal.water$Forecast = predict(fit.2) # 예측값을 Forecast에 대입

library(ggplot2)
ggplot(socal.water, aes(x = Forecast, y = Actual)) + geom_point() + geom_smooth(method = lm) + labs(title = "Forecast versus Actuals")