attach(mtcars)
plot(wt, mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
detach(mtcars)

pdf("mygraph.pdf")
  attach(mtcars)
  plot(wt, mpg)
  abline(lm(mpg~wt))
  title("Regression of MPG on Weight")
  detach(mtcars)
dev.off()


dose <- c(20, 30, 40, 45, 60)
dose_a <- c(16, 20, 27, 40, 60)
dose_b <- c(15, 18, 25, 31, 40)

plot(dose, dose_a, type='b')

opar <- par(no.readonly = TRUE)
par(lty=2, pch=17)
plot(dose, dose_a, type = "b")
par(opar)

plot(dose, dose_a, type = "b", lty = 2, pch = 17)

plot(dose, dose_a, type = "b", lty = 3, lwd = 3, pch = 15, cex = 2)

install.packages("RColorBrewer")

library(RColorBrewer)
n <- 7
mycolors <- brewer.pal(n, "Set1")
barplot(rep(1, n), col = mycolors)

par(font.lab = 3, cex.lab = 1.5, font.main = 4, cex.main = 2)


dose <- c(20, 30, 40, 45, 60)
drug_a <- c(16, 20, 27, 40, 60)
drug_b <- c(15, 18, 25, 31, 40)

opar <- par(no.readonly = TRUE)  # 把环境参数中的那些不是readonly 的部分，赋值给opar
par(pin=c(2, 3))
par(lwd=2, cex=1.5)
par(cex.axis=0.75, font.axis=3)

plot(dose, drug_a, type = "b", pch = 19, lty = 2, col = "red")

plot(dose, drug_b, type = "b", pch = 23, lty = 6, col = "blue", bg = "green")


plot(dose, drug_a, type="b",
     col="red", lty=2, pch=2, lwd=2,
     main="Clinical Trials for Drug A",
     sub="This is hypothetical data",
     xlab="Dosage", ylab="Drug Response",
     xlim=c(0, 60), ylim=c(0, 70))


opar <- par(no.readonly = TRUE)
par(lwd = 2, cex = 1.5, font.lab = 2)

plot(dose, drug_a, type = "b",
     pch = 15, lty = 1, col = "red", ylim = c(0, 60),
     main = "Drug A vs. Drug B",
     xlab = "Drug Dosage", ylab = "Drug Response")

lines(dose, drug_b, type="b",
      pch=17, lty=2, col="blue")

abline(h=c(30), lwd=1.5, lty=2, col="gray")
library(Hmisc)
minor.tick(nx=3, ny=3, tick.ratio=0.5)

legend("topleft", inset=.05, title="Drug Type", c("A","B"), lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))


# ========================
attach(mtcars)
opar <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
plot(wt, mpg, main="Scatterplot of wt vs. mpg")
plot(wt, disp, main = "Scatterplot of wt vs. disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")
par(opar)
detach(mtcars)


# ========================
attach(mtcars)
opar <- par(no.readonly=TRUE)
par(mfrow=c(3,1))
hist(wt)
hist(mpg)
hist(disp)
par(opar)
detach(mtcars)
