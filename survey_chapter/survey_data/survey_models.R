blibrary(lme4)

load("/Users/david/Dropbox/Dissertation/Document/survey_chapter/survey_data/merged_afrobarometer.Rds")

# Participation models ----

h4 <- glmer(vote_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country / Ethnic), data=afro, family=binomial("logit"), weights=withinwt)

h5 <- glmer(meeting_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + primary + employment_recode + urban_recode + ruling_supporter + lage + sex +  (1 | Country / Ethnic), data=afro, family=binomial("logit"), weights=withinwt)

h6 <- glmer(protest_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country / Ethnic), data=afro, family=binomial("logit"), weights=withinwt)

h7 <- glmer(violence_recode ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country / Ethnic), data=afro, family=binomial("logit"), weights=withinwt)

h8 <- glmer(violence_willing ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country / Ethnic), data=afro, family=binomial("logit"), weights=withinwt)

# Ethnic identity models ----

h1 <- glmer(eth_id_bin ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country), data=afro, family=binomial("logit"), weights=withinwt)

h2 <- glmer(eth_id_bin ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country / Ethnic), data=afro, family=binomial("logit"), weights=withinwt)

h3 <- glmer(eth_id_bin ~ latentmean + I(ethfrac^2) + ethfrac + polity2 + separatist + civil + attack_recode_bin + intim_recode_bin  + employment_recode + primary + urban_recode + ruling_supporter + lage + sex +  (1 | Country/Ethnic) + (1|Year), data=afro, family=binomial("logit"), weights=withinwt)

# Save ----
rm(afro)
save.image(file="/Users/david/Dropbox/Dissertation/Document/survey_chapter/survey_data/survey_models.Rdata")
