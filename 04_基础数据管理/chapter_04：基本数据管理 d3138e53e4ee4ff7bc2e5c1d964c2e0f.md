# chapter_04：基本数据管理

## 4.1 一个例子

假设我们现在有这样的一个问卷调查：

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled.png)

得到的结果为：

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled%201.png)

在这里，每位经理人的上司根据与服从权威相关的五项陈述（q1到q5）对经理人进行评分。

例如：经理人1是一位在美国工作的32岁男性，上司对他的评价是惯于顺从。

接着，我们来创建对饮的数据框：

```r
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
```

得到的结果为：

```r
> leadership
  manager     date country gender age q1 q2 q3 q4 q5
1       1 10/24/08      US      M  32  5  4  5  5  5
2       2 10/28/08      US      F  45  3  5  2  5  5
3       3  10/1/08      UK      F  25  3  5  5  5  2
4       4 10/12/08      UK      M  39  3  3  4 NA NA
5       5   5/1/09      UK      F  99  2  2  1  2  1
```

为了解决感兴趣的问题，需要解决一些数据管理方面的问题，比如：

1. 将q1到q5组合起来进行评估
2. 能够处理不完整的数据，如NA
3. 从整体数据集上获得部分数据集，用来使用和研究
4. 可能需要将一些数值进行分类，比如说20~30被分为年轻，30~40被分为中年等等
5. 可能需要获得某一个阶段的数据集

## 4.2 创建新变量

可以通过：

```r
变量名 <- 表达式
```

来完成。

上述语句中的“表达式”的部分可以使用运算符和函数来进行表示：

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled%202.png)

假设我们现在有一个名为mydata的数据框，其中有两个变量：x1和x2。

如果要创建一个新变量sumx，用来存储以上两个变量的加和，并且创建一个名为meanx的新变量来存储这两个变量的均值。

我们可以尝试以下代码：

```r
sumx <- x1 + x2
meanx <- (x1 + x2) / 2
```

运行将会得到错误，这是因为R并不知道x1和x2是来源于mydata数据框。

我们需要使用的代码如下所示：

```r
sumx <- mydata$x1 + mydata$x2
meanx <- (mydata$x1 + mydata$x2) / 2
```

这样能够执行成功，但是只会得到一个数据框（mydata）和两个独立的向量（sumx和meanx）。

如果想要将两个新变量整合到原始的数据框中，有三种方法能够实现这个目标。

我们首先创建数据框：

```r
> # 首先创建对应的数据框
> mydata <- data.frame(x1 = c(2, 2, 6, 4),
+                      x2 = c(3, 4, 2, 8))
> mydata  # 首先打印出来看一下
  x1 x2
1  2  3
2  2  4
3  6  2
4  4  8
```

接着我们采用第一种方法：

```r
> # 方法一
> mydata$sumx <- mydata$x1 + mydata$x2
> mydata$meanx <- (mydata$x1 + mydata$x2) / 2
> mydata
  x1 x2 sumx meanx
1  2  3    5   2.5
2  2  4    6   3.0
3  6  2    8   4.0
4  4  8   12   6.0
```

然后我们采用第二种方法：

```r
# 方法二
attach(mydata)
mydata$sumx <- x1 + x2
mydata$meanx <- (x1 + x2) / 2
detach(mydata)
mydata
```

运行的结果为：

```r
> mydata
  x1 x2 sumx meanx
1  2  3    5   2.5
2  2  4    6   3.0
3  6  2    8   4.0
4  4  8   12   6.0
```

最后是第三种方法：

```r
> # 原先的数据集
> mydata <- data.frame(x1 = c(2, 2, 6, 4),
+                      x2 = c(3, 4, 2, 8))
> # 方法三
> mydata <- transform(mydata,
+                     sumx = x1 + x2,
+                     meanx = (x1 + x2) / 2)
> mydata
  x1 x2 sumx meanx
1  2  3    5   2.5
2  2  4    6   3.0
3  6  2    8   4.0
4  4  8   12   6.0
```

推荐采用第三种方法，因为transform()函数可以简化按需创建新变量并且将其保存到数据框中的过程。

## 4.3 变量的重编码

重编码涉及根据同一个变量和其他变量的现有值创建新值的过程。

比如说有这样的需求：

1. 将一个连续变量修改为一组类别值
2. 将误编码的值替换为正确值
3. 基于一组分数线创建一个表示及格/不及格的变量

等等。

如果要重编码数据，可以使用R中的一个或者多个逻辑运算符：

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled%203.png)

我们首先回顾一下leadership的数据：

```r
> leadership
  manager     date country gender age q1 q2 q3 q4 q5
1       1 10/24/08      US      M  32  5  4  5  5  5
2       2 10/28/08      US      F  45  3  5  2  5  5
3       3  10/1/08      UK      F  25  3  5  5  5  2
4       4 10/12/08      UK      M  39  3  3  4 NA NA
5       5   5/1/09      UK      F  99  2  2  1  2  1
```

接下来我们需要的是将99岁的年龄值重编码为缺失值：

```r
> leadership$age[leadership$age == 99] <- NA
> leadership
  manager     date country gender age q1 q2 q3 q4 q5
1       1 10/24/08      US      M  32  5  4  5  5  5
2       2 10/28/08      US      F  45  3  5  2  5  5
3       3  10/1/08      UK      F  25  3  5  5  5  2
4       4 10/12/08      UK      M  39  3  3  4 NA NA
5       5   5/1/09      UK      F  NA  2  2  1  2  1
```

可以发现age为99已经被修改为了NA。

上述语句的语法结构为：

```r
variable[condition] <- expression
```

这意味着：在condition为TRUE的时候才会对variable中对应的变量执行赋值。

接着我们可以创建变量agecat并且进行修改：

```r
leadership$agecat[leadership$age > 75] <- "Elder"
leadership$agecat[leadership$age >= 55 & leadership$age <= 75] <- "Middle Aged"
leadership$agecat[leadership$age < 55] <- "Young"
leadership
```

运行的结果为：

```r
> leadership
  manager     date country gender age q1 q2 q3 q4 q5 agecat
1       1 10/24/08      US      M  32  5  4  5  5  5  Young
2       2 10/28/08      US      F  45  3  5  2  5  5  Young
3       3  10/1/08      UK      F  25  3  5  5  5  2  Young
4       4 10/12/08      UK      M  39  3  3  4 NA NA  Young
5       5   5/1/09      UK      F  NA  2  2  1  2  1   <NA>
```

在leadership$agecat中写上了数据框的名称，以确保新变量能够保存到数据框中。

如果你一开始没把99重编码为age的缺失值，那么经理人5就将在变量agecat中被错误地赋值为“老年人”（Elder）。

我们可以将这段代码写的更加的紧凑：

```r
> leadership <- within(leadership, {
+   agecat <- NA
+   agecat[age > 75] <- "Elder"
+   agecat[age >= 55 & age <= 75] <- "Middle Aged"
+   agecat[age < 55] <- "Young"
+ })
> leadership
  manager     date country gender age q1 q2 q3 q4 q5 agecat
1       1 10/24/08      US      M  32  5  4  5  5  5  Young
2       2 10/28/08      US      F  45  3  5  2  5  5  Young
3       3  10/1/08      UK      F  25  3  5  5  5  2  Young
4       4 10/12/08      UK      M  39  3  3  4 NA NA  Young
5       5   5/1/09      UK      F  NA  2  2  1  2  1   <NA>
```

函数within()与函数with()类似，不同的是within()允许修改数据框。

在上述代码中：

```r
agecat <- NA
```

创建了agecat变量，并且将每一行都设置为缺失值（NA）。

## 4.4 变量的重命名

假如我们对现有的变量名并不满意，可以使用交互式的方法来进行修改：

```r
fix(leadership)
```

这样可以调用一个交互式的编辑器。

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled%204.png)

或者我们可以使用names()函数来重命名变量：

```r
> leadership
  manager     date country gender age q1 q2 q3 q4 q5 agecat
1       1 10/24/08      US      M  32  5  4  5  5  5  Young
2       2 10/28/08      US      F  45  3  5  2  5  5  Young
3       3  10/1/08      UK      F  25  3  5  5  5  2  Young
4       4 10/12/08      UK      M  39  3  3  4 NA NA  Young
5       5   5/1/09      UK      F  NA  2  2  1  2  1   <NA>
> names(leadership)[2] <- "testDate"
> leadership
  manager testDate country gender age q1 q2 q3 q4 q5 agecat
1       1 10/24/08      US      M  32  5  4  5  5  5  Young
2       2 10/28/08      US      F  45  3  5  2  5  5  Young
3       3  10/1/08      UK      F  25  3  5  5  5  2  Young
4       4 10/12/08      UK      M  39  3  3  4 NA NA  Young
5       5   5/1/09      UK      F  NA  2  2  1  2  1   <NA>
```

我们使用了names()函数，具体的语法如下所示：

```r
names(variable_name)[index] <- express
```

names(variable_name)表示对其进行重命名，重命名的的位置为index，赋值的内容为express。

或者，我们可以采用批量的方法来实现：

```r
> names(leadership)[6:10] <- c("item1", "item2", "item3", "item4", "item5")
> leadership
  manager testDate country gender age item1 item2 item3 item4 item5 agecat
1       1 10/24/08      US      M  32     5     4     5     5     5  Young
2       2 10/28/08      US      F  45     3     5     2     5     5  Young
3       3  10/1/08      UK      F  25     3     5     5     5     2  Young
4       4 10/12/08      UK      M  39     3     3     4    NA    NA  Young
5       5   5/1/09      UK      F  NA     2     2     1     2     1   <NA>
```

这将会从6开始，到10结束，包括10，修改为item1~item6。

最后一个方法，plyr包中有一个rename()函数，可以用来修改变量名。

```r
install.packages("plyr")  # 用来安装plyr包
```

接着使用rename()函数：

```r
rename(detaframe, c(oldname="newname", oldname="newname",...))
```

例子如下所示：

```r
> library(plyr)
> manager <- c(1, 2, 3, 4, 5)
> date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
> country <- c("US", "US", "UK", "UK", "UK")
> gender <- c("M", "F", "F", "M", "F")
> age <- c(32, 45, 25, 39, 99)
> q1 <- c(5, 3, 3, 3, 2)
> q2 <- c(4, 5, 5, 3, 2)
> q3 <- c(5, 2, 5, 4, 1)
> q4 <- c(5, 5, 5, NA, 2)
> q5 <- c(5, 5, 2, NA, 1)
> 
> leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)
> leadership <- rename(leadership, c(manager="managerID", date = "testDate"))
> leadership
  managerID testDate country gender age q1 q2 q3 q4 q5
1         1 10/24/08      US      M  32  5  4  5  5  5
2         2 10/28/08      US      F  45  3  5  2  5  5
3         3  10/1/08      UK      F  25  3  5  5  5  2
4         4 10/12/08      UK      M  39  3  3  4 NA NA
5         5   5/1/09      UK      F  99  2  2  1  2  1
```

## 4.5 缺失值

数据可能因为没有作答之类的原因而没有完整的记录，这就意味着数据集中会存在着缺失值（NA，Not Available）。

R语言提供了一些函数用来检测是否存在着缺失值：

```r
is.na()
```

例子如下所示：

```r
> y <- c(1, 2, 3, NA)
> is.na(y)
[1] FALSE FALSE FALSE  TRUE
```

可以发现is.na()函数会返回被检测的对象的每一个值是否是NA并且返回。

我们可以尝试一下检测leadership：

```r
> is.na(leadership)
     manager  date country gender   age    q1    q2    q3    q4    q5
[1,]   FALSE FALSE   FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[2,]   FALSE FALSE   FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[3,]   FALSE FALSE   FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[4,]   FALSE FALSE   FALSE  FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE
[5,]   FALSE FALSE   FALSE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

或者我们只检测一部分：

```r
> is.na(leadership[, 6:10])
        q1    q2    q3    q4    q5
[1,] FALSE FALSE FALSE FALSE FALSE
[2,] FALSE FALSE FALSE FALSE FALSE
[3,] FALSE FALSE FALSE FALSE FALSE
[4,] FALSE FALSE FALSE  TRUE  TRUE
[5,] FALSE FALSE FALSE FALSE FALSE
```

这单代码实际上是：

```r
is.na(leadership[:, 6:10])  # 所有的行，6~10列
```

关于缺失值存在着两件重要的事情：

1. 缺失值被认为是不可比较的，哪怕是和缺失值自己进行比较（比如不能够使用 variable_1 == NA 来判断variable_1是否等于NA）
2. R并不把无限的或者不可能出现的数值标记为缺失值（不可能的值表示为：NaN，Not a Number）

在R语言中，包含有缺失值的算术得到的结果也是缺失值：

```r
> x <- c(1, 2, 3, NA)
> sum_x <- x[1] + x[4]
> sum_x
[1] NA
> sum_x_2 <- sum(x)
> sum_x_2
[1] NA
```

这是否需要使用的是na.rm=TRUE函数，表示当值为NA的时候，remove=TRUE：

```r
> sum_x_rm <- sum(x, na.rm = TRUE)
> sum_x_rm
[1] 6
```

na.omit()则可以移除所有含有缺失值的观测，这将会删除所有含有缺失数据的行：

```r
> leadership
  manager     date country gender age q1 q2 q3 q4 q5
1       1 10/24/08      US      M  32  5  4  5  5  5
2       2 10/28/08      US      F  45  3  5  2  5  5
3       3  10/1/08      UK      F  25  3  5  5  5  2
4       4 10/12/08      UK      M  39  3  3  4 NA NA
5       5   5/1/09      UK      F  99  2  2  1  2  1
> leadership_new <- na.omit(leadership)
> leadership_new
  manager     date country gender age q1 q2 q3 q4 q5
1       1 10/24/08      US      M  32  5  4  5  5  5
2       2 10/28/08      US      F  45  3  5  2  5  5
3       3  10/1/08      UK      F  25  3  5  5  5  2
5       5   5/1/09      UK      F  99  2  2  1  2  1
```

可以发现当存在着缺失值的时候，缺失值所在的行被整个移除了。

## 4.6 日期值

日期值通常是以字符串的形式输入到R中的，然后转化为以数值形式存储的日期变量。函数as.Date()则用于执行这种转化：

```r
as.Date(x, "input_format")
```

其中x是字符型数据，input_format则给出了用于读入日期的适当格式：

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled%205.png)

例子如下所示：

```r
> # ==================
> mydates <- as.Date(c("2007-06-22", "2004-03-13"))
> mydates
[1] "2007-06-22" "2004-03-13"
> strDates <- c("01/05/1965", "08/12/1968")
> dates <- as.Date(strDates, "%m/%d/%Y")
> strDates
[1] "01/05/1965" "08/12/1968"
```

R语言提供了两个函数用来获得系统当前的日期和时间：

```r
> Sys.Date()
[1] "2022-10-05"
> date()
[1] "Wed Oct  5 10:53:57 2022"
```

为了方便阅读，可以使用format(x, format = “output_format”)来输出指定格式的日期值，并且可以提取日期值中的某些部分：

```r
> today <- Sys.Date()
> format(today, format="%B %d %Y")
[1] "十月 05 2022"
> format(today, format="%A")
[1] "星期三"
```

## 4.7 类型转换

R语言提供了一些列的判断对象的数据类型和将其转换为某一种数据类型的方法：

![Untitled](chapter_04%EF%BC%9A%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%AE%A1%E7%90%86%20d3138e53e4ee4ff7bc2e5c1d964c2e0f/Untitled%206.png)

函数的名称的类型为：

```r
is.datatype()
```

返回的结果为：TRUE或者FALSE。

而如果要进行类型转换，则可以使用函数：

```r
as.datetype()
```

来讲对象从原有的类型转换为指定的类型。

例子如下所示：

```r
> a <- c(1, 2, 3)
> a
[1] 1 2 3
> is.numeric(a)
[1] TRUE
> is.vector(a)
[1] TRUE
> a <- as.character(a)
> a
[1] "1" "2" "3"
> is.numeric(a)
[1] FALSE
> is.character(a)
[1] TRUE
```

## 4.8 数据排序

在一些情况之下，我们可以查看排序之后的数据集来收集一些信息：

```r
> manager <- c(1, 2, 3, 4, 5)
> date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
> country <- c("US", "US", "UK", "UK", "UK")
> gender <- c("M", "F", "F", "M", "F")
> age <- c(32, 45, 25, 39, 99)
> q1 <- c(5, 3, 3, 3, 2)
> q2 <- c(4, 5, 5, 3, 2)
> q3 <- c(5, 2, 5, 4, 1)
> q4 <- c(5, 5, 5, NA, 2)
> q5 <- c(5, 5, 2, NA, 1)
> 
> leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors = FALSE)
> leadership
  manager     date country gender age q1 q2 q3 q4 q5
1       1 10/24/08      US      M  32  5  4  5  5  5
2       2 10/28/08      US      F  45  3  5  2  5  5
3       3  10/1/08      UK      F  25  3  5  5  5  2
4       4 10/12/08      UK      M  39  3  3  4 NA NA
5       5   5/1/09      UK      F  99  2  2  1  2  1
> newdata <- leadership[order(leadership$age),]
> newdata
  manager     date country gender age q1 q2 q3 q4 q5
3       3  10/1/08      UK      F  25  3  5  5  5  2
1       1 10/24/08      US      M  32  5  4  5  5  5
4       4 10/12/08      UK      M  39  3  3  4 NA NA
2       2 10/28/08      US      F  45  3  5  2  5  5
5       5   5/1/09      UK      F  99  2  2  1  2  1
```

创建了一个新的数据集，其中各行依经理人的年龄升序排序。

我们再来尝试另一个例子：

```r
attach(leadership)
newdata <- leadership[order(gender, age),]
detach(leadership)
```

在这个例子中：将各行依女性到男性、同样性别中按年龄升序排序。

## 4.9 数据集的合并

如果数据分散在多个地方，你就需要在继续下一步之前将其合并。

要横向合并两个数据框（数据集），请使用merge()函数。

在多数情况下，两个数据框是通过一个或多个共有变量进行联结的（即一种内联结，inner join）。

比如：

```r
total <- merge(dataframeA, dataframeB, by="ID")
```

将dataframeA和dataframeB按照ID进行了合并。

类似的：

```r
total <- merge(dataframeA, dataframeB, by=c("ID","Country"))
```

则是将两个数据框按照ID和Country进行了合并。

如果要直接横向合并两个矩阵或数据框，并且不需要指定一个公共索引，那么可以直接使用cbind()函数：

```r
total <- cbind(A, B)
```

这个函数将横向合并对象A和对象B。为了让它正常工作，每个对象必须拥有相同的行数，以同顺序排序。

要纵向合并两个数据框（数据集），请使用rbind()函数：

```r
total <- rbind(dataframeA, dataframeB)
```

两个数据框必须拥有相同的变量，不过它们的顺序不必一定相同。