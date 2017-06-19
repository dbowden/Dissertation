library(MatchIt)
library(dplyr)

load("/Users/david/Dropbox/Dissertation/Document/survey_chapter/survey_data/merged_afrobarometer.Rds")

# make complete cases
match.data <- select(afro, attack_recode_bin, educ, lage, sex, urban, ruling, ag, employment_recode)

match.data <- subset(match.data, complete.cases(match.data)==T)

# Matches ----

m1 <- matchit((attack_recode_bin==1) ~ educ + lage + sex + urban + ruling + ag + employment_recode, data=match.data, method="genetic", pop.size=1000, replace=F, ratio=1)
