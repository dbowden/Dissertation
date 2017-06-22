library(dplyr)
library(foreign)
library(gdata)
library(readr)
library(readxl)


load("~/Dropbox/Civil War Data/master_rebel_yearly.Rdata")

ucdp.dyad$GWNoA <- as.numeric(as.character(ucdp.dyad$GWNoA))

#remove cases with ambiguous actor data (these are generic 'Palestinian Insurgents', etc)
ucdp.dyad <- filter(ucdp.dyad, is.na(delete))


# 1. Code DVs ---------------

## Code ethnic status DV

ucdp.dyad$monoeth <- ifelse(ucdp.dyad$tot_eth==1, 1, 0)
ucdp.dyad$multieth <- ifelse(ucdp.dyad$tot_eth>1, 1, 0)
ucdp.dyad$noneth <- ifelse(ucdp.dyad$tot_eth==0, 1, 0)

## Code joiner / splinter / alliance DV

# First code whether the war is new or ongoing
ucdp.dyad <- ucdp.dyad %>% group_by(ConflictId) %>% mutate(lag_year=lag(Year))

ucdp.dyad$new.ep1 <- ifelse((ucdp.dyad$Year - ucdp.dyad$lag_year)>1, 1, 0)

# Then code new groups
ucdp.dyad$new.joiner <- ifelse(ucdp.dyad$rebel_age==0 & ucdp.dyad$new.ep1==0 & ucdp.dyad$origin!="splinter" & ucdp.dyad$origin!="alliance", 1, 0)
ucdp.dyad$new.splinter <- ifelse(ucdp.dyad$rebel_age==0 & ucdp.dyad$origin=="splinter", 1, 0)
ucdp.dyad$new.alliance <- ifelse(ucdp.dyad$rebel_age==0 & ucdp.dyad$origin=="alliance", 1, 0)

# Code general entry status
ucdp.dyad$splinter <- ifelse(ucdp.dyad$origin=="splinter", 1, 0)
ucdp.dyad$alliance <- ifelse(ucdp.dyad$origin=="alliance", 1, 0)
ucdp.dyad <- ucdp.dyad %>% group_by(DyadId) %>% mutate(joiner=ifelse(max(new.joiner, na.rm=T)==1, 1, 0))
ucdp.dyad$originator <- ifelse(ucdp.dyad$splinter==0 & ucdp.dyad$alliance==0 & ucdp.dyad$joiner==0, 1, 0)


# 2. IV 1: Merge in Human Protection Scores ------
hrp <- read.csv("HumanRightsProtectionScores_v2.04.csv")

hrp <- rename(hrp, Year = YEAR, GWNoA = COW)

hrp <- select(hrp, -CIRI)

ucdp.dyad <- left_join(ucdp.dyad, hrp)

rm(hrp)


# 3. IV 2: Ethnolinguistic fractionalization -------
fearon <- read.dta("repdata.dta")

fearon <- select(fearon, GWNoA = ccode, Year = year, mtnest, Oil, ethfrac, relfrac)

ucdp.dyad <- left_join(ucdp.dyad, fearon)

rm(fearon)


# 4. IV 2a: EPR groups --------
epr <- read.csv("EPR-2014.csv")

epr <- epr %>% 
  rowwise() %>% 
  do(data.frame(GWNoA=.$gwid, Year=seq(.$from, .$to), gwgroupid=.$gwgroupid, size=.$size, status=.$status, reg_aut=.$reg_aut))

epr$status_recode <- recode(epr$status, "MONOPOLY" = "absolute", "DOMINANT" = "absolute", "SENIOR PARTNER" = "power-sharing", "JUNIOR PARTNER" = "power-sharing", "DISCRIMINATED" = "excluded", "POWERLESS" = "excluded", "IRRELEVANT" = "excluded", "SELF-EXCLUSION" = "excluded")

#aggregate to country years
epr <- epr %>% 
  group_by(GWNoA, Year) %>%
  summarize(country_ethnic=n_distinct(gwgroupid), country_excluded=sum(status=="excluded", na.rm=T))

ucdp.dyad <- left_join(ucdp.dyad, epr)

rm(epr)


# 5. Instrument: Oil Revenue -------



# 6. Controls: Pop & GDP  -----
gdp <- read_delim("expgdpv6.0/gdpv6.txt", delim="\t")

gdp <- select(gdp, GWNoA = statenum, Year = year, pop, realgdp, rgdppc)

ucdp.dyad <- left_join(ucdp.dyad, gdp)

rm(gdp)


# 7. Controls: Area ------


# 8. Controls: Polity -----
polity <- read_excel("p4v2015.xls")

polity <- select(polity, GWNoA = ccode, Year = year, polity2)

ucdp.dyad <- left_join(ucdp.dyad, polity)

rm(polity)


# 9. Control: Mediation -----
mediation <- read.xls("CWM Data, August 2014.xlsx")

mediation <- filter(mediation, Med_yes.no==1)

mediation <- select(mediation, country, med.begins, med.ends, episode.end.date)

mediation$byear <- str_extract(mediation$med.begins, "\\d\\d\\d\\d")
mediation$eyear <- str_extract(mediation$med.ends, "\\d\\d\\d\\d")
mediation$eyear <- ifelse(is.na(mediation$eyear), str_extract(mediation$episode.end.date, "\\d\\d\\d\\d"), mediation$eyear) 

mediation <- filter(mediation, !is.na(eyear) & !is.na(byear))

mediation$GWNoA <- countrycode(mediation$country, "country.name", "cown")

mediation <- mediation %>% 
  rowwise() %>% 
  do(data.frame(GWNoA=.$GWNoA, Year=seq(as.numeric(.$byear), as.numeric(.$eyear)), mediation=1)) %>% 
  arrange(GWNoA, Year)

mediation$dup <- ifelse(duplicated(mediation)==T, 1, 0)

mediation <- subset(mediation, dup==0)

mediation <- select(mediation, -dup)

ucdp.dyad <- left_join(ucdp.dyad, mediation)

ucdp.dyad$mediation[is.na(ucdp.dyad$mediation)] <- 0

rm(mediation)


# 10. Control: Contiguous Civil Wars ------
