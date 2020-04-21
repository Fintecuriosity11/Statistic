### 교차 검증 기법 (cross validation)
## 모형 선택과 테스트에 효과적인 기법 (오차와 분산 균형 때문에 쓰인다.)

## Leave-One-Out-Cross-Validation (LOOCV)

#선형 모형에서는 쉽게 LOOCV 수행 가능
#예측 오차 제곱합(Prediction Error Sum of Squares, PRESS)이라는 통계량을 검사하고 가장 작은 Press를 갖는 모형을 고른다.
#R의 MPV 패키지로 PRESS 통계량을 쉽게 계산 가능

install.packages("MPV")
library(MPV)

PRESS(best.fit)

PRESS(fit.2)


#예측 오차 제곱합 통계량만 보면 best.fit 모형을 선택할 수 있다.
#모형이 간결하면 간결할 수록 좋은 모형이다.

PRESS.best = sum((resid(best.fit)/(1- hatvalues(best.fit)))^2)

PRESS.fit.2 = sum((resid(fit.2)/(1- hatvalues(fit.2)))^2)


#Y=XB+E

#Y는 변하지 않고, X는 입력값의 행렬, B는 계수, E는 에러 항을 나타낸다.
#이 선형모형은 B의 해를 구한다. 결론적으로 회귀 과정은 해트 행렬(hat matrix)를 구한다.

#이 행렬은 계산된 모형값을 실제 값에 사상(mapping)한다. 
#이러한 경우 사상 대신 투영(projection)이라는 말을 사용하기도 한다.

#결과, 해트 행렬은 모형 내에서 특정한 관찰값의 영향력을 반영한다.
#따라서 잔차 제곱합을(1-해트값)으로 나눈면 교차 검증(LOOCV)값과 같게 된다.

PRESS.best

PRESS.fit.2