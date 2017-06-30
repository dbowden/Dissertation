#### Create Survival Data ####
library(dplyr)
library(foreign)
library(tidyr)
library(readxl)
library(readr)
library(WDI)
library(countrycode)

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


#### Merge in some country-level covariates ####

# 4. HPS ------
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

# 5. Ethfrac ------
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


# 6. Controls: Polity -----
polity <- read_excel("~/Dropbox/Dissertation/Document/entry_chapter/entry_analysis/p4v2015.xls")

polity <- select(polity, GWNoA = ccode, Year = year, polity2)

group.years <- left_join(group.years, polity)

rm(polity)

# 7. GDP and pop ------
gdp <- read_delim("~/Dropbox/Dissertation/Document/entry_chapter/entry_analysis/expgdpv6.0/gdpv6.txt", delim="\t")

gdp <- select(gdp, GWNoA = statenum, Year = year, pop, realgdp, rgdppc)

group.years <- left_join(group.years, gdp)

rm(gdp)


# 8. Controls: Area ------
area <- WDI(country="all", indicator="AG.LND.TOTL.K2", start=1960, end=2015)

area$GWNoA <- countrycode(area$iso2c, "iso2c", "cown")

area <- select(area, GWNoA, Year=year, area=AG.LND.TOTL.K2)

group.years <- left_join(group.years, area)

#fill pre-1960
group.years <- group.years %>%
  group_by(DyadId) %>%
  fill(area, .direction=c("up"))

rm(area)

# 9. Resource sites --------
loot <- read.csv("~/Dropbox/Dissertation/Document/entry_chapter/entry_analysis/all_resources_country.csv")

loot <- rename(loot, GWNoA = COWCODE)

loot$loot.dia <- ifelse(!is.na(loot$diamond.sites), 1, 0)
loot$loot.gem <- ifelse(!is.na(loot$gem.sites), 1, 0)
loot$loot.gold <- ifelse(!is.na(loot$gold.sites), 1, 0)
loot$loot.oil <- ifelse(!is.na(loot$oil.sites), 1, 0)
loot$loot.drugs <- ifelse(!is.na(loot$drug.sites), 1, 0)
loot$lootable <- ifelse(loot$loot.dia==1 | loot$loot.gem==1 | loot$loot.gold==1 | loot$loot.oil==1 | loot$loot.drugs==1, 1, 0)

loot <- select(loot, GWNoA, loot.dia, loot.gem, loot.gold, loot.oil, loot.drugs, lootable, tot.resource.sites)

group.years <- left_join(group.years, loot)

rm(loot)

# 10. Prep some vars for survival analysis -----
group.years$time1 <- group.years$time + 1

group.years$stronger <- ifelse(group.years$rebstrength=="stronger" | group.years$rebstrength=="much stronger", 1, 0)
group.years$multieth <- ifelse(group.years$tot_eth>1, 1, 0)

# 11. Write data -------
saveRDS(group.years, "survival_data.Rdata")
write.csv(group.years, "survival_data.csv", row.names = F)
