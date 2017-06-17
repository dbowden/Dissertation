library(sjmisc)
library(countrycode)
library(lubridate)
library(readxl)
library(sjPlot)
library(countrycode)
library(dplyr)
library(tidyr)

setwd("/Users/david/Dropbox/Dissertation/Document/survey_chapter/survey_data")
afro6 <- read_spss("afrobarometer/afrobarometer_r6.sav")
afro5 <- read_spss("afrobarometer/afrobarometer_r5.sav")
afro4 <- read_spss("afrobarometer/afrobarometer_r4.sav")
afro3 <- read_spss("afrobarometer/afrobarometer_r3.sav")

# Subset to relevant variables -----
afro6 <- dplyr::select(afro6, COUNTRY, DATEINTR, eth_id = Q88B, attack = Q11B, intim = Q49, employment = Q95, educ = Q97, urban = Q115, sex = Q101, occupation = Q96A, ethnic = Q87, ruling = Q52F, age = Q1, vote=Q21, protest=Q27E, meeting=Q20A, withinwt)
afro6$wave <- 6
afro6$ag <- ifelse(afro6$occupation==3, 1, 0)
afro6$COUNTRY <- to_label(afro6$COUNTRY)
afro6$violence <- NA
afro6$ethnic[afro6$ethnic < 0 | afro6$ethnic >= 9990] <- NA
afro6$ethnic <- to_label(afro6$ethnic)
afro6$ethnic <- gsub(pattern = "Related.*", replacement = NA, x = afro6$ethnic)
afro6$ethnic[afro6$ethnic=="Not asked in country"] <- NA

afro5 <- dplyr::select(afro5, eth_id = Q85B, attack = Q10B, intim = Q54, employment = Q96, educ = Q97, urban = Q115, sex = Q101, occupation = Q96_ARB, ethnic = Q84, ruling = Q59F, COUNTRY, DATEINTR, meeting=Q26A, protest=Q26D, violence=Q26E, vote=Q27, age=Q1, withinwt)
afro5$wave <- 5
afro5$ag <- ifelse(afro5$occupation>=1 & afro5$occupation<=5, 1, 0)
afro5$COUNTRY <- to_label(afro5$COUNTRY)
afro5$ethnic[afro5$ethnic < 0 | afro5$ethnic >= 9990] <- NA
afro5$ethnic <- to_label(afro5$ethnic)
afro5$ethnic <- gsub(pattern = "Related.*", replacement = NA, x = afro5$ethnic)
afro5$ethnic[afro5$ethnic=="Not asked in country"] <- NA

afro4 <- dplyr::select(afro4, eth_id = Q83, attack = Q9C, intim = Q47, employment = Q94, educ = Q89, urban = Q113, sex = Q101,  ethnic = Q79, ruling = Q49E, COUNTRY, DATEINTR, age=Q1, meeting=Q23A, protest=Q23C, vote=Q23D, withinwt = Withinwt)
afro4$occupation <- NA
afro4$wave <- 4
afro4$attack[afro4$attack==4] <- 3
afro4$employment[afro4$employment==3] <- 2
afro4$employment[afro4$employment==4 | afro4$employment==5] <- 3
afro4$ag <- NA
afro4$COUNTRY <- to_label(afro4$COUNTRY)
afro4$violence <- NA
afro4$ethnic[afro4$ethnic < 0 | afro4$ethnic >= 990] <- NA
afro4$ethnic <- to_label(afro4$ethnic)
afro4$ethnic <- gsub(pattern = "Related.*", replacement = NA, x = afro4$ethnic)
afro4$ethnic[afro4$ethnic=="Not asked in country"] <- NA


afro3 <- dplyr::select(afro3, eth_id = q82, attack = q9c, employment = q94, educ = q90, urban = q113, sex = q101, occupation = q95, ethnic = q79, ruling = q55e, COUNTRY = country, DATEINTR = dateintr, age=q1, meeting=q31a, protest=q31c, vote=q30, withinwt)
afro3$intim <- NA
afro3$wave <- 3
afro3$attack[afro3$attack==4] <- 3
afro3$employment[afro3$employment==3] <- 2
afro3$employment[afro3$employment==4 | afro3$employment==5] <- 3
afro3$ag <- ifelse(afro3$occupation>=1 & afro3$occupation<=5, 1, 0)
afro3$COUNTRY <- to_label(afro3$COUNTRY)
afro3$violence <- NA
afro3$ethnic[afro3$ethnic < 0 | afro3$ethnic >= 990] <- NA
afro3$ethnic <- to_label(afro3$ethnic)
afro3$ethnic <- gsub(pattern = "Related.*", replacement = NA, x = afro3$ethnic)
afro3$ethnic[afro3$ethnic=="Not asked in country"] <- NA


afro <- rbind(afro6, afro5, afro4, afro3)

afro <- set_labels(afro$eth_id, labels=get_labels(afro6$eth_id))

rm(afro6, afro5, afro4, afro3)

# Recode and standardize ------
afro[afro < 0] <- NA

afro$eth_id_bin <- ifelse(afro$eth_id==1 | afro$eth_id==2, 1, 0)
#afro$eth_id[afro$eth_id < 0 | afro$eth_id > 5] <- NA
afro$attack_recode <- ifelse(afro$attack > 3, NA, afro$attack)
afro$intim_recode <- ifelse(afro$intim > 3, NA, afro$intim)
afro$employment_recode <- ifelse(afro$employment==2 | afro$employment==3, 1, 0)
afro$educ_recode <- ifelse(afro$educ > 9, NA, afro$educ)
afro$primary <- ifelse(afro$educ >= 0 & afro$educ <= 3, 1, 0)
afro$urban_recode <- ifelse(afro$urban==2, 1, 0)
afro$ruling_supporter <- ifelse(afro$ruling==2 | afro$ruling==3, 1, 0)
afro$COUNTRY[afro$COUNTRY=="Cote d’Ivoire"] <- "Cote d'Ivoire"
afro$vote_recode <- ifelse(afro$vote==1, 1, 0)
afro$meeting_recode <- ifelse(afro$meeting>=2 & afro$meeting<=4, 1, 0)
afro$protest_recode <- ifelse(afro$protest>=2 & afro$protest<=4, 1, 0)
afro$violence_recode <- ifelse(afro$violence>=2 & afro$violence<=4, 1, 0)
afro$violence_willing <- ifelse(afro$violence==1, 1, 0)
afro$attack_recode_bin <- ifelse(afro$attack_recode>0, 1, 0)
afro$intim_recode_bin <- ifelse(afro$intim_recode<2, 1, 0)

# Make attack discrepancy var -----
afro <- afro %>%
  group_by(COUNTRY, wave) %>%
  mutate(cntry.pr.attack=mean(attack_recode_bin, na.rm=T))

afro <- afro %>%
  group_by(COUNTRY, wave, ethnic) %>%
  mutate(eth.pr.attack=mean(attack_recode_bin, na.rm=T))

afro$diff.pr.attack <- afro$eth.pr.attack - afro$cntry.pr.attack

# Country-level variables -------

# Fariss Scores
afro$COW <- countrycode(afro$COUNTRY, "country.name", "cown")

afro$YEAR <- year(afro$DATEINTR)

hrs <- read.csv("HumanRightsProtectionScores_v2.04.csv")

afro <- left_join(afro, hrs)

rm(hrs)

# Polity
polity <- read_excel("p4v2015.xls")

polity <- dplyr::select(polity, COW = ccode, YEAR = year, polity2)

afro <- left_join(afro, polity)

rm(polity)

# Fearon and Laitin data
fearon <- read_stata("repdata.dta")

fearon <- filter(fearon, year == max(year))

fearon <- dplyr::select(fearon, COW = ccode, mtnest, Oil, ethfrac, relfrac)

afro <- left_join(afro, fearon)

rm(fearon)

# previous and ongoing wars
load("ucdp-prio-acd-4-2016.RData")

ucdp.prio.acd <- separate_rows(ucdp.prio.acd, GWNoLoc, sep = ", ")

ucdp.prio.acd <- ucdp.prio.acd %>%
  group_by(GWNoLoc, Year) %>%
  summarize(interstate=sum(TypeOfConflict==2), interstate_war=sum(TypeOfConflict==2 & IntensityLevel==2), civil=sum(TypeOfConflict!=2 & Incompatibility==2), civil_war=sum(TypeOfConflict!=2 & Incompatibility==2 & IntensityLevel==2), separatist=sum(TypeOfConflict!=2 & Incompatibility!=2), separatist_war=sum(TypeOfConflict!=2 & Incompatibility!=2 & IntensityLevel==2))

ucdp.prio.acd$anyconflict <- 1

ucdp.prio.acd$anywar <- ifelse(rowSums(ucdp.prio.acd[,c("interstate_war","civil_war","separatist_war")])>0, 1, 0)

ucdp.prio.acd <- rename(ucdp.prio.acd, COW = GWNoLoc, YEAR = Year)

ucdp.prio.acd$COW <- as.numeric(as.character(ucdp.prio.acd$COW))

afro <- left_join(afro, ucdp.prio.acd)

rm(ucdp.prio.acd)

afro$anywar[is.na(afro$anywar)] <- 0
afro$anyconflict[is.na(afro$anyconflict)] <- 0
afro$separatist[is.na(afro$separatist)] <- 0
afro$civil[is.na(afro$civil)] <- 0

## elections
## territorial disputes
## EPR data - national level and group level

afro$civil <- as.factor(afro$civil)
afro$separatist <- as.factor(afro$separatist)
afro$attack_recode_bin <- as.factor(afro$attack_recode_bin)
afro$intim_recode_bin <- as.factor(afro$intim_recode_bin)
afro$employment_recode <- as.factor(afro$employment_recode)
#afro$educ_recode <- as.factor(afro$educ_recode)
afro$urban_recode <- as.factor(afro$urban_recode)
afro$ruling_supporter <- as.factor(afro$ruling_supporter)
afro$sex <- as.factor(afro$sex)
afro$lage <- log(afro$age)
afro$ag <- as.factor(afro$ag)
afro$primary <- as.factor(afro$primary)

# labels
afro$violence_recode <- set_label(afro$violence_recode, "Used Violence")
afro$attack_recode_bin <- set_label(afro$attack_recode_bin, "Attacked")
afro$latentmean <- set_label(afro$latentmean, "Human Rights")
afro$ethfrac <- set_label(afro$ethfrac, "Ethnolinguistic Fractionalization")
afro$polity2 <- set_label(afro$polity2, "Polity")
afro$separatist <_ set_label(afro$separatist, "Separatist War")
afro$civil <- set_label(afro$civil, "Civil War")
afro$intim_recode_bin <- set_label(afro$intim_recode_bin, "Intimidation")
afro$primary <- set_label(afro$primary, "Primary Education")
afro$employment_recode <- set_label(afro$employment_recode, "Employed")
afro$urban_recode <- set_label(afro$urban_recode, "Urban")
afro$ruling_supporter <- set_label(afro$ruling_supporter, "Ruling Supporter")
afro$lage <- set_label(afro$lage, "logged Age")
afro$sex <- set_label(afro$sex, "Sex")
afro$vote_recode <- set_label(afro$vote_recode, "Voted")
afro$meeting_recode <- set_label(afro$meeting_recode, "Meeting")
afro$protest_recode <- set_label(afro$protest_recode, "Protest")
afro$violence_willing <- set_label(afro$violence_willing, "Willing to Use Violence")
afro$eth_id_bin <- set_label(afro$eth_id_bin, "Ethnic Identification")

# Write data -------
afro <- dplyr::rename(afro, Country=COUNTRY, Ethnic=ethnic, Year=YEAR, Wave=wave)
save(afro, file="merged_afrobarometer.Rds")
