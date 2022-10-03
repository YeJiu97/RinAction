a <- c(1, 2, 5, 3, 6, -2, 4)
b <- c("Hello", "World", "R", "Programming")
c <- c(TRUE, TRUE, FALSE, FALSE, TRUE)

d <- c(1)

matrix_1 <- matrix(c(1:20), nrow = 5, ncol = 4)
matrix_1

cells <- c(1, 3, 5, 7)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
matrix_2 <- matrix(cells, nrow = 2, ncol = 2, byrow = TRUE, dimnames = list(rnames, cnames))
matrix_2

matrix_1[, 1]
matrix_1[1, ]
matrix_1[1, 2]

dim_1 <- c("A1", "A2")
dim_2 <- c("B1", "B2", "B3")
dim_3 <- c("C1", "C2", "C3", "C4")
z <- array(1:24, c(2, 3, 4), dimnames=list(dim_1, dim_2, dim_3))
z

patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Typel", "Type2", "Typel", "Typel")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdate <- data.frame(patientID, age, diabetes, status)

patientdate

patientdate[1:2]
patientdate[c("diabetes", "status")]
patientdate$age

table(patientdate$diabetes, patientdate$status)

diabetes <- c("Typel", "Type2", "Type1", "Type1")
diabetes <- factor(diabetes)
diabetes
diabetes[1]
diabetes[c(1)]

status <- c("Poor", "Improved", "Excellent", "Poor")
status <- factor(status, ordered=TRUE)
status[1]
status[(2)]
status[(1)]
status[c(1)]
status[3]


patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
diabetes <- factor(diabetes)
status <- factor(status, order=TRUE)
patientdata <- data.frame(patientID, age, diabetes, status)

str(patientdata)
summary(patientdata)

mydata <- data.frame(age = numeric(0),
                     gender = character(0),
                     weight = numeric(0))
mydata <- edit(mydata)
mydata

mydata_txt <- "
age gender weight
12 m 81
21 f 58
18 m 120
"
mydata_1 <- read.table(header = TRUE, text = mydata_txt)
mydata_1

grades <- read.table("studentgrades.csv", header=TRUE,
                     row.names = "StudentID", sep = ",")

grades
str(grades)

grades <- read.table("studentgrades.csv", header=TRUE,
                     row.names="StudentID", sep=",",
                     colClasses=c("character", "character", "character",
                                  "numeric", "numeric", "numeric"))