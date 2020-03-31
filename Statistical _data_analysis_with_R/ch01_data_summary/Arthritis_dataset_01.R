# vcd package installation
# 범주형 변수의 시각화와 분석을 위한 툴

install.packages("vcd")
library(vcd)

# vcd 패키지에 포함된 Arthritis 데이터셋으로 교차표(cross-tabulation) 생성

# 교차표는 두 변수의 범주별 조합 빈도수를 조사하여 작성한 2차원 테이블
# 두 범주형 변수 간의 관계를 파악하고자 할 때 유용함

str(Arthritis)

crosstab <-table(Arthritis$Improved, Arthritis$Treatment)
crosstab

# Treatment 변수는 범주형 변수로서 위약투약을 나타내는 placebo와
# 신약 투약을 의미하는 Treated 2개의 레벨을 갖는다.

crosstab["Market", "Treated"]

#xtabs()함수는 포뮬러 형식으로 행과 열의 변수를 지정.
#포뮬러의 오른(~의 오른쪽)에행의 변수와 열의 변수를 +로 연결하여 지정
#행과 열에 대응되는 변수 이름이 함께 출력된다.
#포뮬러 형식을 사용할 때는 data인수에 데이터셋을 지정

crosstab<-xtabs(~Improved + Treatment, data=Arthritis)
crosstab

#margin.table()과 prop.table()를 이용하여 
#교차표의 행과 열에 대한 빈도합과 비율을 계산
#행의 합과 행의 비율을 계산하기 위해서는 다음과 같이 인수로 margin=1을 지정
#인수 margin=1은 table()함수에 지정되는 1번째 변수(교차표의 행)에 대응

margin.table(crosstab, margin=1)
prop.table(crosstab, 1)

margin.table(crosstab, margin=2)
prop.table(crosstab,2)

prop.table(crosstab)

#교차표에 행과열의 빈도합을 포함시키려면 addmargins() 사용
#addmargins()에 margin=1을 지정하면 합의 행(행의 값들을 모두 합한 합계행) 생성
#교차표 이외에 아무런 추가인수를 제공하지 않으면 2 변수 모두에 대한 합의 행과 열 생성

addmargins(crosstab, margin = 1)

addmargins(crosstab, margin = 2)

addmargins(crosstab)

#addmargins() 적용하면 100%를 나타내는  열과 행을 쉽게 식별할 수 
#있어서 교차표의 해석에 도움이 된다.

addmargins(prop.table(crosstab,2),1)

addmargins(prop.table(crosstab,1),2)

