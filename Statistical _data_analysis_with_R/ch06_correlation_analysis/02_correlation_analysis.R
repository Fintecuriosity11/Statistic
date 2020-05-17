##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github statistics package에 issue를 남기면 확인

##########################################################################################################################################



##########################################################################################################################################

str(iris)

cor(iris[-5])

# 데이터셋에 2개를 초과하는 숫자 벡터가 포함되어 있으면 cor()함수는 상관계수 행렬을 생성.
# iris 데이터셋에 다음과 같이 cor()함수를 적용.
# 숫자 형식이 아닌 5 번째 열을 제외한 4개 변수 간의 상관계수 행렬을 얻을 수 있음.

# cor()함수의 수행결과는 변수 이름을 행 이름과 열 이름으로 갖는 행렬 형식으로 출력.

############################################################결과값(print)#################################################################

# > str(iris)
# 'data.frame':	150 obs. of  5 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...


# > cor(iris[-5])
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
# Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
# Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654
# Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000

##########################################################################################################################################

iris.cor <- cor(iris[-5])
class(iris.cor)

str(iris.cor)

# 임의의 두 변수 간 상관계수는 다음과 같이 행 이름과 열 이름을 인덱스로 사용하여 추출 가능.

############################################################결과값(print)#################################################################

# > iris.cor <- cor(iris[-5])
# > class(iris.cor)
# [1] "matrix" "array" 

# > str(iris.cor)
# num [1:4, 1:4] 1 -0.118 0.872 0.818 -0.118 ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
# ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"

##########################################################################################################################################

iris.cor["Petal.Width", "Petal.Length"]

# cor()함수는 변수 간의 상관계수를 구해주지만 이들이 통계적으로 유의한지는 알려주지 않음.
# 또한 상관계수의 통계적 유의성 검정을 위해 앞에서 사용했던 cor.test()함수는 두 변수 간 상관계수 유의성 검정에만 사용 가능.

# 두 개를 초과하는 변수 간의 상관계수 유의성 검정을 위해서는 psych 패키지에 포함된 corr.test()함수를 이용해야 함.

############################################################결과값(print)#################################################################

# > iris.cor["Petal.Width", "Petal.Length"]
# [1] 0.9628654


##########################################################################################################################################

library(psych)
corr.test(iris[-5])

# corr.test()함수는 행렬이나 데이터프레임을 인수로 받아서 상관계수 행렬과 그에 대응되는 유의확률(p값) 행렬을 반환함.
# 예를 들어, iris 데이터셋의 네 개 변수 간 상관계수와 대응하는 유의확률은 다음과 같음.

# Sepal.Length와 Sepal.Width 간 상관계수는 -0.12의 유의확률은 0.15로서 유의수준 0.05에서 통계적으로 유의하지 않음. 

############################################################결과값(print)#################################################################

# > library(psych)
# > corr.test(iris[-5])
# Call:corr.test(x = iris[-5])
# Correlation matrix 
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length         1.00       -0.12         0.87        0.82
# Sepal.Width         -0.12        1.00        -0.43       -0.37
# Petal.Length         0.87       -0.43         1.00        0.96
# Petal.Width          0.82       -0.37         0.96        1.00
# Sample Size 
# [1] 150
# Probability values (Entries above the diagonal are adjusted for multiple tests.) 
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length         0.00        0.15            0           0
# Sepal.Width          0.15        0.00            0           0
# Petal.Length         0.00        0.00            0           0
# Petal.Width          0.00        0.00            0           0

# To see confidence intervals of the correlations, print with the short=FALSE option

##########################################################################################################################################

print(corr.test(iris[-5]), short = FALSE)

# 상관계수의 95% 신뢰구간 다음과 같이 print()함수에 Short=FALSE 인수 지정을 하여 출력 가능.

############################################################결과값(print)#################################################################

# > print(corr.test(iris[-5]), short = FALSE)
# Call:corr.test(x = iris[-5])
# Correlation matrix 
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length         1.00       -0.12         0.87        0.82
# Sepal.Width         -0.12        1.00        -0.43       -0.37
# Petal.Length         0.87       -0.43         1.00        0.96
# Petal.Width          0.82       -0.37         0.96        1.00
# Sample Size 
# [1] 150

# Probability values (Entries above the diagonal are adjusted for multiple tests.) 
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length         0.00        0.15            0           0
# Sepal.Width          0.15        0.00            0           0
# Petal.Length         0.00        0.00            0           0
# Petal.Width          0.00        0.00            0           0

# Confidence intervals based upon normal theory.  To get bootstrapped values, try cor.ci
# raw.lower raw.r raw.upper raw.p lower.adj upper.adj
# Spl.L-Spl.W     -0.27 -0.12      0.04  0.15     -0.27      0.04
# Spl.L-Ptl.L      0.83  0.87      0.91  0.00      0.81      0.91
# Spl.L-Ptl.W      0.76  0.82      0.86  0.00      0.74      0.88
# Spl.W-Ptl.L     -0.55 -0.43     -0.29  0.00     -0.58     -0.25
# Spl.W-Ptl.W     -0.50 -0.37     -0.22  0.00     -0.51     -0.20
# Ptl.L-Ptl.W      0.95  0.96      0.97  0.00      0.94      0.98

##########################################################################################################################################
