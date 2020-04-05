install.packages("MASS")

library(vcd)
library(gmodels)
library(MASS)

str(Arthritis)
str(survey)


#연속형 변수에는 전체 데이터를 요약하는 중심경향 지표(measure of central tendency가 있다.)
#또한 변동성 지표(measures of variability)를 이용하여 데이터의 특성을 파악할 수 있다.

#중심경향=데이터가 특정값으로 집중되어 있는 정
#변동성= 데이터의 산포정도

#중심경향 지표: 중위수, 백분위수,사분위수,평균
#변동성 지표:범위, 사분위 범위, 분산, 표준편차

#중위수는 크기순으로 정렬된 데이터셋을 절반으로 분할하는 값

#중위수median()은 작은 값에서 큰 값의 순서로 크기순으로 데이터값을 정렬했을때 중앙에 위치하는 값
#중위수는 전체 관측값의 절반보다는 크고 동시에 나머지 절반보다는 작은 값으로 정의

#median()함수를 비롯한 많은 요약통계량 계산 함수는 데이터에 결측값(NA)가 포함되어
#있으면 NA를 반환하므로 na.rm=True를 지정하여 NA를 계산에서 제외

median(survey$Pulse, na.rm=TRUE)

#백분위수는 데이터셋을 백분위 비율로 분할하는 값을 구할 수 있다.
#예를 들어 전체 관측값의 5%보다는 크고 나머지 95%보다는 작은 값은 5번째 백분위수(5th quantile)


quantile(survey$Pulse, probs = 0.05, na.rm=TRUE)
#5% 59,55%

#전체 관측값의 50%는 중위수보다 작고 50%는 중위수보다 크기때문에 중위수는 50번째 백분위수다.

quantile(survey$Pulse, 0.5, na.rm = TRUE)
#50%, 72.5

#quantile()함수의 2번째 인수에는 벡터를 지정할 수 잇다.
#probs인수에 2 개 이상의 비율을 벡터로 지정하면 해당비율에 해당하는 백분위수 출력

quantile(survey$Pulse, c(0.05, 0.95), na.rm = TRUE)
# 5%, 59.44 & 95%, 92.00

#사분위수(quartile)로도 출력 사능

quantile(survey$Pulse, na.rm = TRUE)

#예를 들어 전체의 몇%가 80이하의 맥박수를 갖는지 알고자하면 논리연산+mean()함수 사용
#논리연산을 통해 80보다 작거나 같은 값에 대응되는 원소는 TRUE로, 그렇지 않은 원소는 FALSE로 변환한 후에 
#mean()함수를 사용하여 이들의 평균을 계산, True=1, FALSE=0으로 변환
mean(survey$Pulse <= 80, na.rm = TRUE)

#일반적으로 평균이 중위수보다 크면 분포의 꼬리가 우측으로 길게 분포
#(skew to the right, right-skewed-distribution)

#반대로 평균이 중위수보다 작으면 꼬리가 왼쪽으로 길게 분포
#(skew to the left, left-skewed-distribution)
#예제에서는 맥박수의 평균은 중위수보다 크므로 오른쪽에 긴 꼬리 분포

mean(survey$Pulse, na.rm = TRUE)

median(survey$Pulse, na.rm = TRUE)

#iris의 데이터셋의 구조, summary()함수로 형식 살펴보기
str(iris)

#summary()함수에 숫자벡터가 주어지면 최솟값,1st Quar,중위수, 평균, 3rd Quar, 최댓값 출력
summary(iris$Sepal.Width)

#summary()함수에 팩터가 주어지면 팩터의 레벨별 빈도를 출력,빈도표
summary(iris$Species)

#문자벡터에 summary()함수를 적용하면 크기(관측값 개수),클래스,모드만 정보 출력
summary(as.character(iris$Species))

#행렬이나 df에 summary()함수를 적용하면 열단위로 요약통계량 계산
#숫자로 구성된 열이면 앞에서 살펴본 6개의 기초적인 통계량 출력
#팩터로 구성된 열이면 빈도가 계산
summary(iris)

#리스트에 summary()함수를 적용하면 단지 각 리스트 원소의 크기와 데이터 형식만이 출력
#따라서 일반적으로 summary()함수를 통해 얻고자 하는 요약통계량의 정보는 구할 수 없다.

iris.lst<-as.list(iris)
summary(iris.lst)

#리스트의 각 원소별 요약통계량 계싼은 lapply()함수의 인수로서 summary()함수 지정
#lapply(list, function)

lapply(iris.lst, summary)

#범위(range)는 가장 단순한 형태의 변동성 지표로서 가장 큰값, 작은 값 차이를 나타낸다.
range(survey$Pulse, na.rm=True)

#분산과 표준편차(변동성 지표중 하나)
var(survey$Pulse, na.rm=True)
sd(survey$Pulse, na.rm=True)