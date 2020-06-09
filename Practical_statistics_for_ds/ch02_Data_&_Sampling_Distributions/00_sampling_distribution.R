
##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github statistics package에 issue를 남기면 확인

# 아직 업데이트를 더 해야함.

##########################################################################################################################################



##########################################################################################################################################

.libPaths("C://Users//yjang//R")

library(MASS)
library(boot)

install.packages("ggplot2")
library(ggplot2)

loans_income <- read.csv(file.path('loans_income.csv'))[,1]

x <- seq(from=-3, to=3, length=300)
gauss <- dnorm(x)

par(mar=c(3, 3, 0, 0)+.1)

plot(x, gauss, type="l", col='blue', xlab='', ylab='', axes=FALSE)

polygon(x, gauss, col='blue')

dev.off()

norm_samp <- rnorm(100)

par(mar=c(3, 3, 0, 0)+.1)

hist(norm_samp, axes=FALSE, col='red', main='')

dev.off()

##########################################################################################################################################

###표본 분포 (Sampling distribution)

# 하나의 동일한 모집단에서 얻은 여러 샘플에 대한 표본통계량의 분포
# 작은 표본을 가지고 매우 큰 모집단을 추론하는 것.

# 우리가 많은 양의 데이터를 가지고 있다면 추가로 표본을 얻어서 통계의 분포를 직접 관찰 가능.
# 이미 최대한 많은 데이터를 사용하여 추정치 또는 모델을 계산했을 것이므로, 모집단에서 추가 표본을 얻는 옵션은 쉽게 이용할 수 없음.

# 통계의 기반이 되는 표본이 클수록, 그럴 가능성이 높은 것은 사실.
# 또한 표본이 클수록 표본통계량의 분포는 좁아짐.

stat_fun <- function(x, idx) median(x[idx])
boot_obj <- boot(loans_income, R = 1000, statistic=stat_fun)


# 단순랜덤 표본을 하나 취함.
# take a simple random sample
samp_data <- data.frame(income=sample(loans_income, 1000), 
                        type='data_dist')

# 5개의 값의 평균으로 이루어진 표본을 하나 취함.
# take a sample of means of 5 values
samp_mean_05 <- data.frame(
  income = tapply(sample(loans_income, 1000*5), 
                  rep(1:1000, rep(5, 1000)), FUN=mean),
  type = 'mean_of_5')

# 20 개의 값의 평균으로 이루어진 표본을 하나 취함.
# take a sample of means of 20 values
samp_mean_20 <- data.frame(
  income = tapply(sample(loans_income, 1000*20), 
                  rep(1:1000, rep(20, 1000)), FUN=mean),
  type = 'mean_of_20')

# data.frame 바인딩 후 factor로 형 변환.
# bind the data.frames and convert type to a factor
income <- rbind(samp_data, samp_mean_05, samp_mean_20)
income$type = factor(income$type, 
                     levels=c('data_dist', 'mean_of_5', 'mean_of_20'),
                     labels=c('Data', 'Mean of 5', 'Mean of 20'))

# 히스토그램 그리기
# plot the histograms
ggplot(income, aes(x=income)) +
  geom_histogram(bins=40) +
  facet_grid(type ~ .)


############################################################결과값(print)#################################################################