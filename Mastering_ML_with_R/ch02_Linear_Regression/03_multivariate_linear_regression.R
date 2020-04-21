### 다변량 선형회귀(multivariate linear regression)


##데이터 이해와 준비 과정

#(피처는 ML에서 예측변수, 설명변수를 의미한다.)
#예측변수(피처)는 1부터 n까지다.
#str()함수를 이용해 데이터 구조 탐색
#데이터에는 7개의 피처와 하나의 반응 변수, BSAAM이 있다


library(alr3)
data("water")
str(water)

#예제에서 어떤 연도에 특정한 관찰값이 일어났는지는 고려하지 않을 것이므로 연도 벡터를 제외한 후 나머지로 새 데이터 프레임 생성

socal.water<-water[,-1] #첫 번째 칼럼을 삭제한 새 데이터 프레임. 
head(socal.water)

#모든 피처가 정량적인 값을 띠므로 상관관계 통계량을 살펴본 후에 산포도 행렬(scatterplot matrix)출력

#Pearson's r이라고 하는 상관계수는 두 변수간의 선형적 관계의 강도와 방향을 모두 측정하는 척도
#이 통계량은 -1와 +1 사이의 값을 갖는데, -1인 경우에는 완전한 음의 상관관계
# +1인 경우 완전한 양의 상관관계를 가진다.

#상관계수는 두 변수의 공분산을 두 표준편차의 곱으로 나눈 값이다. 상관관계를 제곱하면 R제곱값이 나온다.

#상관관계를 시각화하는데 corrplot를 사용한다.
install.packages("corrplot")
library(corrplot)
water.cor<-cor(socal.water)
water.cor

#반응변수(BSAM)가 OP 피처들(OPBPC, OPRC, OPSLAKE)과 강한 양적 상관관계를 보인다.
#이들은 상관관계가 각각 0.8857478, 0.9196270, 0.9384360으로 +1에 가까운 값을 보인다.
#AP피처들은 서로 강한 상관관계를 보이고, OP피처들도 서로 강한 상관성을 보인다.

#위와 같은 관찰을 통해 모형이 다중 공선성(multi-collinearity)문제에 맞닥뜨릴 것이다.

#상관관계 도표 행렬은 변수 사이의 상관성을 시각적으로 잘 보여준다.
corrplot(water.cor, method = "ellipse")

#pairs 함수로 상관관계를 산포도 행렬로 시각
pairs(~ .,data = socal.water)