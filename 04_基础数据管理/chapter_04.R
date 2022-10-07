manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)

# ===================
# 首先创建对应的数据框
mydata <- data.frame(x1 = c(2, 2, 6, 4),
                     x2 = c(3, 4, 2, 8))

mydata  # 首先打印出来看一下

# 方法一
mydata$sumx <- mydata$x1 + mydata$x2
mydata$meanx <- (mydata$x1 + mydata$x2) / 2
mydata

# 原先的数据集
mydata <- data.frame(x1 = c(2, 2, 6, 4),
                     x2 = c(3, 4, 2, 8))
mydata

# 方法二
attach(mydata)
mydata$sumx <- x1 + x2
mydata$meanx <- (x1 + x2) / 2
detach(mydata)
mydata

# 原先的数据集
mydata <- data.frame(x1 = c(2, 2, 6, 4),
                     x2 = c(3, 4, 2, 8))
# 方法三
mydata <- transform(mydata,
                    sumx = x1 + x2,
                    meanx = (x1 + x2) / 2)
mydata


# =================
leadership
leadership$age[leadership$age == 99] <- NA
leadership

leadership$agecat[leadership$age > 75] <- "Elder"
leadership$agecat[leadership$age >= 55 & leadership$age <= 75] <- "Middle Aged"
leadership$agecat[leadership$age < 55] <- "Young"
leadership

# =================
manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)

leadership
leadership$age[leadership$age == 99] <- NA


leadership <- within(leadership, {
  agecat <- NA
  agecat[age > 75] <- "Elder"
  agecat[age >= 55 & age <= 75] <- "Middle Aged"
  agecat[age < 55] <- "Young"
})

leadership


# ===================
fix(leadership)

leadership
names(leadership)[2] <- "testDate"
leadership

names(leadership)[6:10] <- c("item1", "item2", "item3", "item4", "item5")
leadership

install.packages("plyr")


library(plyr)
manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)

leadership <- rename(leadership, c(manager="managerID", date = "testDate"))
leadership

# ==================
y <- c(1, 2, 3, NA)
is.na(y)

is.na(leadership)

is.na(leadership[, 6:10])

x <- c(1, 2, 3, NA)
sum_x <- x[1] + x[4]
sum_x

sum_x_2 <- sum(x)
sum_x_2

sum_x_rm <- sum(x, na.rm = TRUE)
sum_x_rm

leadership
leadership_new <- na.omit(leadership)
leadership_new


# ==================
mydates <- as.Date(c("2007-06-22", "2004-03-13"))
mydates

strDates <- c("01/05/1965", "08/12/1968")
dates <- as.Date(strDates, "%m/%d/%Y")
strDates

Sys.Date()
date()

today <- Sys.Date()
format(today, format="%B %d %Y")
format(today, format="%A")


a <- c(1, 2, 3)
a
is.numeric(a)
is.vector(a)
a <- as.character(a)
a
is.numeric(a)
is.character(a)


# =====================

manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)

leadership

newdata <- leadership[order(leadership$age),]
newdata

attach(leadership)
newdate <- leadership[order[gender, age],]
datach(leadership)
