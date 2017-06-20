load("/Users/david/Dropbox/Dissertation/Document/survey_chapter/survey_data/merged_afrobarometer.Rds")

# make complete cases
match.subset <- dplyr::select(afro, Country, Ethnic, attack_recode_bin, educ, lage, sex, urban_recode, ruling_supporter, employment_recode, eth_id_bin, ethfrac, polity2, civil, separatist, intim_recode_bin, primary, latentmean, violence_recode, violence_willing)

match.subset[,4:20] <- lapply(match.subset[,4:20], as.numeric)

match.subset <- subset(match.subset, complete.cases(match.subset)==T)

#lapply(match.subset[,c(5:18)], function(x) t.test(x ~ match.subset$attack_recode_bin, var.equal=F))

match.subset$attack_recode_bin[match.subset$attack_recode_bin==1] <- 0
match.subset$attack_recode_bin[match.subset$attack_recode_bin==2] <- 1

#randomly sample
#match.subset <- match.subset[sample(nrow(match.subset), 10000),]

# Matches ----


m1 <- MatchIt::matchit(attack_recode_bin ~ educ + lage + sex + urban_recode + ruling_supporter + employment_recode + civil + separatist + polity2 + ethfrac , data=match.subset, method="cem")

summary(m1)
plot(m1)

m1.out <- match.data(m1)


write.csv(m1.out, "cem_data.csv", row.names=F)