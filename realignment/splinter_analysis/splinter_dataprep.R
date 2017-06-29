#### Create Survival Data ####
library(dplyr)
library(foreign)
library(tidyr)

load("master_rebel_yearly.Rdata")

ucdp.dyad$SideB <- as.character(ucdp.dyad$SideB)
ucdp.dyad$origin.name <- as.character(ucdp.dyad$origin.name)

# 1. Get splinter group attributes ----
splinter <- subset(ucdp.dyad, origin=="splinter")

splinter <- splinter %>% 
  group_by(SideBID) %>% 
  summarize(Year=min(Year), location=first(Location), splinter.name=first(SideB), origin.name=first(origin.name))

splinter <- rename(splinter, SideB=origin.name)

splinter$death <- 1

splinter$death.year <- splinter$Year

splinter <- select(ungroup(splinter), -SideBID)

#remove cases with multiple per years
splinter <- subset(splinter, duplicated(splinter[,c(1,3)])==F)

# 2. Collapse dyadic data into group-years ----

ucdp.dyad <- ucdp.dyad %>% 
  group_by(SideBID, Year) %>% 
  mutate(conflicts=n_distinct(ConflictId))

group.years <- ucdp.dyad %>% 
  group_by(SideBID, Year) %>% 
  summarize_all(first)

rm(ucdp.dyad)

# 3. Merge in splinter data ----

group.years <- left_join(group.years, splinter)

rm(splinter)

group.years$death[is.na(group.years$death)] <- 0

group.years <- group.years %>% 
  group_by(SideBID) %>% 
  mutate(start=min(Year))

group.years$time <- group.years$Year - group.years$start


# 4. Merge in some country-level covariates -----

#HPS
hrp <- read.csv("~/Dropbox/Dissertation/Document/entry_chapter/entry_analysis/HumanRightsProtectionScores_v2.04.csv")

hrp <- rename(hrp, Year = YEAR, GWNoA = COW)

hrp <- select(hrp, -CIRI)

hrp$GWNoA <- as.numeric(as.character(hrp$GWNoA))

group.years$GWNoA <- as.numeric(as.character(group.years$GWNoA))

group.years <- left_join(group.years, hrp)

rm(hrp)

group.years <- group.years %>% 
  group_by(SideBID) %>% 
  mutate(latentmean_lag=lag(latentmean), latentmean_lag2=lag(latentmean,2))

group.years$latentmean_diff <- group.years$latentmean - group.years$latentmean_lag

group.years$latentmean_diff2 <- group.years$latentmean_lag - group.years$latentmean_lag2

#Ethfrac
fearon <- read.dta("~/Dropbox/Dissertation/Document/entry_chapter/entry_analysis/repdata.dta")

fearon <- select(fearon, GWNoA = ccode, Year = year, mtnest, Oil, ethfrac, relfrac)

group.years <- left_join(group.years, fearon)

rm(fearon)

group.years <- group.years %>%
  group_by(SideBID) %>%
  fill(ethfrac, mtnest)

group.years <- group.years %>%
  group_by(SideBID) %>%
  fill(ethfrac, mtnest, .direction = "up")


