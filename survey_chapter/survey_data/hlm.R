
library(texreg)
library(MASS)
library(lme4)
library(lmtest)
library(multiwayvcov)

load("merged_afrobarometer.Rds")

# OLS models -----
s1 <- glm(eth_id_bin ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + age, data=afro, family=binomial("logit"))
screenreg(s1)
summary(s1)

s2 <- glm(eth_id_bin ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + age + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(s2)

s3 <- glm(eth_id_bin ~ attack_recode + employment_recode + educ_recode + urban_recode + ruling_supporter + age + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(s3)

s4 <- glm(eth_id_bin ~ attack_recode, data=afro, family=binomial("logit"))
screenreg(s4)

s5 <- polr(as.factor(eth_id) ~ attack_recode + employment_recode + educ_recode + urban_recode + ruling_supporter + as.factor(COUNTRY) + wave, data=afro, method="probit", Hess = T)
screenreg(s5)

s6 <- polr(as.factor(eth_id) ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + as.factor(COUNTRY) + wave, data=afro, method="probit", Hess = T)
screenreg(s6)

## participation DVs
p1 <- glm(vote_recode ~ attack_recode + employment_recode + educ_recode + urban_recode + ruling_supporter + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p1)

p2 <- glm(vote_recode ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + age + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p2)

p3 <- glm(protest_recode ~ attack_recode + employment_recode + educ_recode + urban_recode + ruling_supporter + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p3)

p4 <- glm(protest_recode ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + age + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p4)

p5 <- glm(meeting_recode ~ attack_recode + employment_recode + educ_recode + urban_recode + ruling_supporter + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p5)

p6 <- glm(meeting_recode ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + age + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p6)

p7 <- glm(violence_recode ~ attack_recode + employment_recode + educ_recode + urban_recode + ruling_supporter + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p7)

p8 <- glm(violence_recode ~ attack_recode + intim_recode + employment_recode + educ_recode + urban_recode + ag + ruling_supporter + age + as.factor(COUNTRY) + wave, data=afro, family=binomial("logit"))
screenreg(p8)

# HLM ------
h1 <- glmer(eth_id_bin ~ attack_recode + employment_recode + educ_recode + latentmean + polity2 + ethfrac + mtnest + urban_recode + ruling_supporter + age + (1 | COUNTRY), data=afro, family=binomial)
summary(h1)
screenreg(h1)

h2 <- glmer(eth_id_bin ~ attack_recode + latentmean + (1 | COUNTRY), data=afro, family=binomial)
summary(h2)
screenreg(h2)

h3 <- glmer(eth_id_bin ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + mtnest + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + log(age) + (1 | COUNTRY), data=afro, family=binomial)
summary(h3)
screenreg(h3)

## best so far
h3b <- glmer(eth_id_bin ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + (separatist>0) + (civil>0) + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + (1 | COUNTRY), data=afro, family=binomial)
summary(h3b)
screenreg(h3)

sjp.glmer(h3, type="pred.fe", vars=c("attack_recode_bin", "intim_recode_bin"), show.scatter = F, show.ci=T, show.values=T, axis.lim=c(0,.25))

h3c <- glmer(eth_id_bin ~ latentmean + I(ethfrac^2) + (diff.pr.attack>=0.1) + ethfrac + polity2 + (separatist>0) + (civil>0) + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + (1|ethnic) + (1 | COUNTRY) + (1|wave), data=afro, family=binomial)
summary(h3c)

# Behavior -----

h4 <- glmer(vote_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + (1 | COUNTRY), data=afro, family=binomial)
screenreg(h4)

h5 <- glmer(meeting_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + (1 | COUNTRY), data=afro, family=binomial)
screenreg(h5)

h6 <- glmer(protest_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + (1 | COUNTRY), data=afro, family=binomial)
screenreg(h6)

h7 <- glmer(violence_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + (separatist>0) + (civil>0) + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + (1 | COUNTRY), data=afro, family=binomial, weights = withinwt)
screenreg(h7)

library(survey)
afro.wt <- svydesign(ids=~1, probs = ~withinwt, data=afro)
h7b <- svyglm(violence_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + attack_recode_bin + intim_recode_bin  + employment_recode + educ_recode + urban_recode + ruling_supporter + age + (sex==1) + as.factor(COUNTRY), design=afro.wt, family=binomial("logit"))
screenreg(h7b)
screenreg(coeftest(h7b, vcov. = cluster.vcov(h7b, afro$COUNTRY)))
