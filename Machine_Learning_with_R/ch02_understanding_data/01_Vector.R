####################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github statistic package에 issue를 남기면 확인

####################################################################################################################################

#R과 자바로 개발된 Weka 패키지는 RWeka

install.packages("RWeka")

library(RWeka)

##### R data structures --------------------

## Vectors -----


#벡터는 기본적인 R데이터 구조로 element(항목이라고 하는 값의 순서 집합(ordered set)을 저장
#벡터 항목은 개수 제한이 없지만, 모두 같은 형식(type)이어야 한다.
#예를 들자면 벡터는 숫자와 텍스트를 동시에 가질 수 없다.

#벡터 v의 형식을 판단하려면 typeof(v) 명령을 사용하면 된다.

#벡터 타입에는 integer(소수 자리가 없는 숫자),
#double(소수 자리가 있는 숫자),
#character(텍스트 데이터), 
#logical(TRUE 또는 FALSE)가 있다

#또한 2개의 특별한 값이 있는데, NULL(값이 존재하지 않음), NA(결측치, missing value)를 나타낸다.

#NA는 어떤 값을 가질 수 있는 저장소 이므로 길이가 1이다.
#NULL은 진짜 비어있고, 따라서 길이는 0이다.

#일부 R의 함수들은 integer, double을 모두 numeric으로 보고한다.
#결과적으로 모든 double 벡터는 numeric이지만, 모든 numeric 벡터는 double 타입이 아니다.

#또한 작은 벡터는 c() 결합 combine 함수로 만들 수 있다. 벡터의 이름은 <-화살표 연산자를
#이용해 부여할 수 있다.

#<-연산자는 R에서 값을 대입하는 방식으로, 다른 프로그래밍언어에서 =연산자와 동일하다.

#아래 예제는 3명의 의료 환자 진단 데이터를 저장하는 벡터이다.
#subject_name이라는 이름의 character벡터를 만들고 환자의 체온을 저장하고자 temperature라는 이름의
#수치벡터를 만들고, 환자의 진단을 저장하고자 flu_status라는 이름의 logical 벡터(TRUE, FALSE) 생성
#인플루엔자를 가지면 TRUE, 아니면 FALSE

# create vectors of data for three medical patients
subject_name<-c("John Doe", "Jane Doe", "Steve Graves")

temperature<- c(98.1, 98.6, 101,4)

flu_status<-c(FALSE, FALSE, TRUE)

#2번째 환자 체온

# access the second element in body temperature vector
temperature[2]

#2번째와 3번째 환자 체온을 얻는다. 연산자(:)로 값의 구간을 지정

## examples of accessing items in vector
# include items in the range 2 to 3
temperature[2:3]

#2번째 환자의 데이터를 제외하려면 -로 제외.

# exclude item 2 using the minus sign
temperature[-2]

#처음 2개 temperature 판독값은 포함하고, 3번째는 제

# use a vector to indicate whether to include item
temperature[c(TRUE, TRUE, FALSE)]
