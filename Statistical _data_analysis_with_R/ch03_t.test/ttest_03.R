##독립표본 평균검정(two-independent sample t test)

#2개의 독립표본 데이터를 이용하여 각각 대응되는 2개의 모집단 평균이 서로 동일한지 검정한다.
#이는 두 집단이 서로 차이가 있는지 검정하는 것과 같은 의미를 갖는다
#이러한 2개의 독립표본의 평균차이검정의 예는 우리 주위에서도 일어난다.
#남년 간의 영어시험 점수에 차이가 있는지, 흡연자와 비흡연자 간의 폐질환 발생률은 서로 차이가 있는지

#독립표본 평균검정은 일표본 평균검정에서 사용한 t.test()함수를 이용하여 수행할 수 있다.
#t.test()함수의 첫번째 인수(formula)에 포뮬러 형식으로 인수를 지정한다.
# ~앞에는 검정하고자 하는 종속변수(dependent variable)를 지정하고, ~에는 집단을 나타내는 독립변수(independent variable)를 지정
#2번째 인수(data)에는 데이터셋을 지정.

t.test(formula=Bwt ~ Sex, data = cats)

bars<- tapply(cats$Bwt, cats$Sex, mean)
lower<- tapply(cats$Bwt, cats$Sex, function(x) t.test(x)$conf.int[1])
upper<-tapply(cats$Bwt, cats$Sex, function(x) t.test(x)$conf.int[2])

install.packages(gplots)
library(gplots)

barplot(bars, space = 0.4, ylim = c(0, 3.0), plot.ci=TRUE, 
        ci.l=lower, ci.u=upper, ci.color="maroon", ci.lwd=4, names.arg = c("Female", "Male"), col = c("coral", "darkkahki"),
        xlab = "Cats", ylab = "Body Weight(kg)",
        main = "Body Weight by Sex\nwith Confidence Interval")

#t.test()함수는 2 표본 데이터를 직접 인수로 제공하는 방식으로도 독립표본 평균검정을 수행할 수 있다.
#다음과 같이 암컷 고양이와 수컷 고양이의 몸무게를 각각 별도로 추출한 후 t.test()함수에 인수로 제공하면 앞에서 포뮬러형식의
#인수지정을 통해 평균검정을 수행한 것과 동일한 결과를 얻는다.

Bwt.f <- cats$Bwt[cats$Sex=="F"]
Bwt.m <- cats$Bwt[cats$Sex=="M"]
t.test(Bwt.f, Bwt.m)


#집단간의 비율이 동일한지 검정. 시행의 결과가 성공 또는 실패로 구성된 2개이상의 집단으로부터 표본 데이터를 추출하여 집단들의 성공 비율
#이 모두 동일한지 검정할 수 있다.
#예를 들어 4개의 병원으로부터 폐질환자수와 그 환자 가운데 흡연자수를 조사했다고 가정
#patient, smokers 벡터는 4병원에 각각에 대응되는 폐질환자수, 흡연자수를 나타낸다.
smokers<-c(83, 90, 129, 70)
patients<-c(86,93,136, 82)

#prop.test()함수를 이용하여 폐질환자 대비 흡연자의 비율이 4개 병원에서 모두 동일한지 검정할 수 있다.
#prop.test()함수의 첫 번째 인수(x)에는 어떤 사건이 발생한 횟수(흡연자 수)를 지정, 두번째 인수(n)에는 대응되는 집단으 크기(폐질환자수) 지정

prop.test(x=smokers, n=patients)

#검정결과를 보면 p값이 유의수준이 0.05에 비해 작으므로 4개 병원의 폐질환자 대비 흡연자의 비율이 같다는 귀무가설을 기각한다.
#따라서 폐질환자 대비 흡연자 비율은 4 병원에서 동일하지 않다.