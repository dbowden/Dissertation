library(survival)

group.years$time1 <- group.years$time + 1

group.years$stronger <- ifelse(group.years$rebstrength=="stronger" | group.years$rebstrength=="much stronger", 1, 0)
group.years$multieth <- ifelse(group.years$tot_eth>1, 1, 0)

S1 <- Surv(group.years$time, group.years$time1, group.years$death)

m1 <- coxph(S1 ~ latentmean_diff + multieth + IntensityLevel + cluster(GWNoLoc), data=data.frame(group.years))
summary(m1)

texreg::screenreg(m1)


m2 <- coxph(S1 ~ latentmean_diff + multieth + IntensityLevel + ethfrac + cluster(GWNoLoc), data=group.years)
summary(m2)

m3 <- coxph(S1 ~ latentmean_diff + multieth  + polity2 + rebpresosts_bin + rebpolwing_bin + stronger + IntensityLevel + cluster(GWNoLoc), data=group.years)
summary(m3)

fit <- survfit(Surv(time, time1, death) ~ (latentmean_diff < 0), data=group.years)
plot(fit, lty=1:2, xlab="Years from Formation", ylab="Probability of Survival")
legend(0.5, .5, c("Repressive", "Non-Repressive"), lty=1:2)
