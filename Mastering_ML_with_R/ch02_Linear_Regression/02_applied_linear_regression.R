#applied linear regression

install.packages("alr3")

library(alr3)

data("snake")
dim(snake)

head(snake)

#����ġ�� 17�� �ִ�.x�� y�� �ǹ� �ִ� ���������� �ٲ۴�.

names(snake)<- c("content", "yield")

#�����Ϳ� �� �̸��� ����
attach(snake) 
head(snake)

par(mfrow =  c(1,1))

#������ �׸���.
plot(content, yield, xlab = "water content of snow", ylab = "water yield")

yield.fit<-lm(yield ~ content)
summary(yield.fit)


plot(content, yield)
abline(yield.fit, lwd=3, col="red")

par(mfrow= c(2,2))
plot(yield.fit)