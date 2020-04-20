#applied linear regression

install.packages("alr3")

library(alr3)

data("snake")
dim(snake)

head(snake)

#관측치가 17개 있다.x와 y를 의미 있는 변수명으로 바꾼다.

names(snake)<- c("content", "yield")

#데이터와 새 이름을 연결
attach(snake) 
head(snake)

par(mfrow =  c(1,1))

#산포도 그리기.
plot(content, yield, xlab = "water content of snow", ylab = "water yield")

yield.fit<-lm(yield ~ content)
summary(yield.fit)


plot(content, yield)
abline(yield.fit, lwd=3, col="red")

par(mfrow= c(2,2))
plot(yield.fit)
