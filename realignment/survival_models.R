library(survival)

group.years$time1 <- group.years$time + 1

group.years$stronger <- ifelse(group.years$rebstrength=="stronger" | group.years$rebstrength=="much stronger", 1, 0)

m1 <- coxph(Surv(time, time1, death) ~ latentmean + (tot_eth>1) , data=group.years)
summary(m1)

texreg::screenreg(m1)


m2 <- coxph(Surv(time, time1, death) ~ latentmean + (tot_eth>1) + ethfrac , data=group.years)
summary(m2)

m3 <- coxph(Surv(time, time1, death) ~ latentmean_diff + (tot_eth>1) + rebpresosts_bin + rebpolwing_bin + stronger, data=group.years)
summary(m3)

fit <- survfit(Surv(time, time1, death) ~ (latentmean_diff < 0), data=group.years)
plot(fit, lty=1:2, xlab="Years from Formation", ylab="Probability of Survival")
legend(0.5, .5, c("Repressive", "Non-Repressive"), lty=1:2)
