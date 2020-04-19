##단변량 선형회귀

#양적반응 변수y를 예측변수 x하나로 예측
#y와 x를 선형관계라고 가정한다.


#데이터 적재 및 분석
#4쌍의 x와 y변수로 이루어져 있다.
data("anscombe")
attach(anscombe)
anscombe

#x1와 y1의 상관계수는 0.816
cor(x1, y1)

#x2와 y2의 상관계수 0.816
cor(x2, y2)

#그림을 2*2 격자 배치로 그린다.
par(mfrow = c(2,2))

#Anscombe 데이터셋의 4 변수쌍을 모두 plot으로 그린다.
plot(x1, y1, main = "Plot 1")
plot(x2, y2, main = "Plot 2")
plot(x3, y3, main = "Plot 3")
plot(x4, y4, main = "Plot 4")