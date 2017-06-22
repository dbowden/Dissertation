####### I Prep Data for Survival Analysis ####
library(dplyr)
library(readxl)
library(readr)
library(tidyr)
library(sjmisc)
library(gdata)
library(lubridate)
library(countrycode)
library(stringr)

# Start with NSA/origins data ------
load("~/Dropbox/Civil War Data/master_rebel_yearly.Rdata")

ucdp.dyad$GWNoA <- as.numeric(as.character(ucdp.dyad$GWNoA))

#set length of peace years between distinct episodes
window <- 3

#remove cases with ambiguous actor data
ucdp.dyad <- filter(ucdp.dyad, is.na(delete))

# Create Episodes ----------
ep <- ucdp.dyad %>% 
  group_by(GWNoA, Year) %>% 
  summarize()

ep <- ep %>% 
  group_by(GWNoA) %>% 
  mutate(lag_Year=lag(Year), min_Year=min(Year))

ep$new_ep <- ifelse((ep$Year - ep$lag_Year) > window | ep$Year==ep$min_Year, 1, 0)

ep <- ep %>% 
  group_by(GWNoA) %>% 
  mutate(epnum=cumsum(new_ep))

ep$conflict_ep <- paste(ep$GWNoA, ep$epnum, sep="-")

ucdp.dyad <- left_join(ucdp.dyad, ep)

ucdp.dyad <- select(ucdp.dyad, -lag_Year, -min_Year, -delete)

rm(ep, window)

# Code entries -----------
entries <- ucdp.dyad %>% 
  group_by(GWNoA, Year) %>% 
  summarize(n_rebels=n_distinct(SideBID), n_splinters=sum(origin=="splinter", na.rm=T), new_ep=max(new_ep), conflicts=n_distinct(ConflictId))

entries$non_splinters <- entries$n_rebels - entries$n_splinters

entries <- entries %>% 
  group_by(GWNoA) %>% 
  mutate(lag_rebels=lag(n_rebels), lag_nonsplint=lag(non_splinters))

entries$death <- ifelse((entries$lag_rebels==1 & entries$n_rebels>1) | entries$n_rebels>1 & entries$new_ep==1, 1, 0)

entries$death_nonsplint <- ifelse((entries$lag_nonsplint==1 & entries$non_splinters>1) | entries$non_splinters>1 & entries$new_ep==1, 1, 0)

entries$death_year <- ifelse(entries$death==1, entries$Year, NA)
entries$death_year_nonsplint <- ifelse(entries$death_nonsplint==1, entries$Year, NA)

entries <- select(entries, -new_ep, -lag_rebels, -lag_nonsplint)

ucdp.dyad <- left_join(ucdp.dyad, entries)

rm(entries)


# code episode dates ---------
ucdp.dyad <- ucdp.dyad %>% 
  group_by(conflict_ep) %>% 
  mutate(maxdeath=max(death), maxdeath_nonsplint=max(death_nonsplint), epstart=min(Year), epend=max(Year), mindeathyear=min(death_year, na.rm=T), mindeathyear_nonsplint=min(death_year_nonsplint, na.rm=T))

#recode end year for failure cases
ucdp.dyad$epend <- ifelse(ucdp.dyad$maxdeath==1, ucdp.dyad$mindeathyear, ucdp.dyad$epend)

ucdp.dyad$epend_nonsplint <- ifelse(ucdp.dyad$maxdeath_nonsplint==1, ucdp.dyad$mindeathyear_nonsplint, ucdp.dyad$epend)



##### II. Country-Level Data ##########

# Polity -------
polity <- read_excel("p4v2015.xls")

polity <- select(polity, GWNoA = ccode, Year = year, polity2)

ucdp.dyad <- left_join(ucdp.dyad, polity)

rm(polity)


# Economic data (real GDP, millions USD) ------
gdp <- read_delim("expgdpv6.0/gdpv6.txt", delim="\t")

gdp <- select(gdp, GWNoA = statenum, Year = year, pop, realgdp, rgdppc)

ucdp.dyad <- left_join(ucdp.dyad, gdp)

rm(gdp)


# fariss -----
hrp <- read.csv("HumanRightsProtectionScores_v2.04.csv")

hrp <- rename(hrp, Year = YEAR, GWNoA = COW)

hrp <- select(hrp, -CIRI)

ucdp.dyad <- left_join(ucdp.dyad, hrp)

rm(hrp)

# bercovitch mediation data -----
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


# Country-level ethnic data -----
epr <- read.csv("EPR-2014.csv")

epr <- epr %>% 
  rowwise() %>% 
  do(data.frame(GWNoA=.$gwid, Year=seq(.$from, .$to), gwgroupid=.$gwgroupid, size=.$size, status=.$status, reg_aut=.$reg_aut))

epr$status_recode <- recode(epr$status, "MONOPOLY" = "absolute", "DOMINANT" = "absolute", "SENIOR PARTNER" = "power-sharing", "JUNIOR PARTNER" = "power-sharing", "DISCRIMINATED" = "excluded", "POWERLESS" = "excluded", "IRRELEVANT" = "excluded", "SELF-EXCLUSION" = "excluded")

#epr$status_recode <- recode(epr$status, "MONOPOLY" = "absolute", "DOMINANT" = "absolute", "SENIOR PARTNER" = "power-sharing", "JUNIOR PARTNER" = "power-sharing", "DISCRIMINATED" = "excluded", "POWERLESS" = "excluded", "IRRELEVANT" = "SELF-EXCLUSION")

epr$status_recode <- factor(epr$status_recode, levels=c("excluded", "SELF-EXCLUSION", "power-sharing", "absolute"), ordered = T)

epr$pcexcluded <- ifelse(epr$status_recode=="excluded", epr$size, 0)
epr$pcdiscrim <- ifelse(epr$status=="DISCRIMINATED", epr$size, 0)

#aggregate to country years
epr <- epr %>% 
  group_by(GWNoA, Year) %>%
  summarize(country_ethnic=n_distinct(gwgroupid), country_excluded=sum(status=="excluded", na.rm=T), country_powersharing=sum(status=="power_sharing", na.rm=T), country_absolute=sum(status=="absolute", na.rm=T), country_regaut=sum(reg_aut=="true", na.rm=T), country_eth1=max(size, na.rm=T), country_tenpc=sum(size>=0.1, na.rm=T), pcexcluded=sum(pcexcluded), pcdiscrim=sum(pcdiscrim))

ucdp.dyad <- left_join(ucdp.dyad, epr)

rm(epr)


# MAR discrim data -----
mar <- read.csv("mar.csv")

mar <- rename(mar, GWNoA=ccode, Year=year)

mar$pcpoldis <- ifelse(mar$poldis==4, mar$gpro, 0)
mar$pcecdis <- ifelse(mar$ecdis==4, mar$gpro, 0)

#aggregate to country-years
mar <- mar %>% 
  group_by(GWNoA, Year) %>% 
  summarize(pcmarpoldis=sum(pcpoldis, na.rm=T), pcmarecdis=sum(pcecdis, na.rm=T), sumnapol=sum(!is.na(pcpoldis)), sumnaec=sum(!is.na(pcecdis)))

#make % 0 if no basis for judging any
mar$pcmarpoldis[mar$sumnapol==0] <- NA
mar$pcmarecdis[mar$sumnaec==0] <- NA

mar <- select(mar, -sumnapol, -sumnaec)

ucdp.dyad <- left_join(ucdp.dyad, mar)

#Neighboring conflicts ---------

#load and clean contiguity data
cont <- read.csv("contdird.csv")

#limit to land contiguity
cont <- filter(cont, conttype==1)

cont <- select(cont, GWNoA = state1no, state2 = state2no, Year = year)

#load ucdp data and aggregate to country years
#keep all conflict types
load("ucdp-prio-acd-4-2016.RData")

ucdp.prio.acd <- separate_rows(ucdp.prio.acd, GWNoA, sep=", ")

ucdp.prio.acd <- ucdp.prio.acd %>% 
  group_by(GWNoA, Year) %>% 
  summarize(cont_interstate=sum(TypeOfConflict==2), cont_civil=sum(TypeOfConflict!=2), cont_maxint=max(IntensityLevel))

ucdp.prio.acd <- rename(ucdp.prio.acd, state2 = GWNoA)

ucdp.prio.acd$state2 <- as.numeric(as.character(ucdp.prio.acd$state2))

cont <- left_join(cont, ucdp.prio.acd)

rm(ucdp.prio.acd)

#aggregate
cont <- cont %>%
  group_by(GWNoA, Year) %>% 
  summarize(cont_interstate=sum(cont_interstate, na.rm=T), cont_civil=sum(cont_civil, na.rm=T), cont_maxint=max(cont_maxint, na.rm=T))

ucdp.dyad <- left_join(ucdp.dyad, cont)

rm(cont)

# Fearon and Laitin data ----

fearon <- read_stata("repdata.dta")

fearon <- select(fearon, GWNoA = ccode, Year = year, mtnest, Oil, ethfrac, relfrac)

ucdp.dyad <- left_join(ucdp.dyad, fearon)

rm(fearon)


# Foreign interventions --------
# support <- read_excel("extsup_large.xls")
# 
# support <- select(support, ywp_year, actorID, external_type_code)

ucdp.dyad$existing.support <- ifelse(ucdp.dyad$rebel_age>0 & ucdp.dyad$rebel.support_bin==1, 1, 0)
ucdp.dyad$entry.support <- ifelse(ucdp.dyad$rebel_age==0 & ucdp.dyad$rebel.support_bin==1, 1, 0)


# Fill a few rebel attributes ------
ucdp.dyad <- ucdp.dyad %>% 
  group_by(SideBID) %>% 
  arrange(Year) %>% 
  fill(rebpolwing_bin, rebestimate, centcontrol, terrcont, conflicttype, rebel.support, rebpresosts_bin, rebstrength, rebel.support)

###### Aggregate to Episode ########

country_year <- ucdp.dyad %>% 
  group_by(GWNoA, Year) %>% 
  arrange(desc(rebel_age)) %>% 
  summarize(conflict_ep=first(conflict_ep), n_rebels=n_distinct(SideBID), n_splinters=sum(origin=="splinter", na.rm=T), n_conflicts=n_distinct(ConflictId), govt=sum(Incompatibility=="government"), terr=sum(Incompatibility=="territory"), IntensityLevel=max(IntensityLevel), TypeOfConflict=first(TypeOfConflict), internationalized=ifelse(sum(TypeOfConflict=="internationalized")>0, 1, 0), rebel_age=first(rebel_age), rebpolwing=first(rebpolwing_bin), rebestimate=first(rebestimate), rebstrength=first(rebstrength), totrebestimate=sum(rebestimate, na.rm=T), centcontrol=first(centcontrol), terrcont=first(terrcont), rebpresosts=first(rebpresosts_bin), reb_toteth=first(tot_eth), conflicttype=first(conflicttype), n_conflicttype=n_distinct(conflicttype), rebel.support=first(rebel.support_bin), epnum=max(epnum), polity2=first(polity2), pop=max(pop), rgdppc=max(rgdppc), latentmean=first(latentmean), ethnic_groups=max(country_ethnic), country_excluded=max(country_excluded), country_powersharing=max(country_powersharing), country_absolute=max(country_absolute), country_regaut=max(country_regaut), country_tenpc=max(country_tenpc), cont_civil=max(cont_civil), cont_maxint=max(cont_maxint), mtnest=max(mtnest), ethfrac=max(ethfrac), relfrac=max(relfrac), oil=max(Oil), pcexcluded=max(pcexcluded), maxdeath=max(maxdeath), maxdeath_nonsplint=max(maxdeath_nonsplint), downgrade=sum(downgrade), mediation_max=max(mediation), mediation_mean=mean(mediation), pcdiscrim=max(pcdiscrim), pcmarpoldis=max(pcmarpoldis), pcmarecdis=max(pcmarecdis), existing.support=max(existing.support, na.rm=T), entry.support=max(entry.support, na.rm=T))

#fill a few missing values
country_year <- country_year %>% 
  group_by(GWNoA) %>% 
  fill(mtnest, ethfrac, relfrac, oil)

#code a few variables
country_year$all_terr <- ifelse(country_year$terr==country_year$n_conflicts & country_year$terr > 0, 1, 0)
country_year$nonsplint <- country_year$n_rebels - country_year$n_splinters
country_year$pcterr <- country_year$terr / country_year$n_rebels
country_year$coldwar <- ifelse(country_year$Year < 1989, 1, 0)
country_year$repression <- country_year$latentmean
country_year$discrimination <- country_year$pcexcluded
country_year$discrimination[country_year$discrimination==0] <- 1
country_year$GWNoA <- as.factor(country_year$GWNoA)
country_year$lgdppc <- log(country_year$rgdppc)
country_year$lpop <- log(country_year$pop)
country_year$cont_civil_bin <- ifelse(country_year$cont_civil>0, 1, 0)

#lead dvs
country_year <- country_year %>% 
  group_by(GWNoA) %>% 
  mutate(n_rebels_lead=lead(n_rebels), nonsplint_lead=lead(nonsplint), n_conflicts_lead=lead(n_conflicts), repression_lag=lag(repression), discrimination_lag=lag(discrimination), n_rebels_lag=lag(n_rebels), nonsplint_lag=lag(nonsplint), pcdiscrim_lag=lag(pcdiscrim))

country_year$n_rebels <- set_label(country_year$n_rebels, "Number of Rebel Groups")
country_year$discrimination_lag <- set_label(country_year$discrimination_lag, "Discrimination")
country_year$pcterr <- set_label(country_year$pcterr, "% Territorial Conflicts")
country_year$repression_lag <- set_label(country_year$repression_lag, "Human Rights")
country_year$rgdppc <- set_label(country_year$rgdppc, "Logged GDP per capita")
country_year$repression_diff <- country_year$repression - country_year$repression_lag


save(country_year, file="country_year.Rdata")

country_year2 <- country_year

names(country_year2) <- gsub(x=names(country_year2), pattern="\\.", replacement = "_")

write_stata(country_year2, "country_year.dta", version=12)

rm(country_year2)


#### Episodes ####
country_episodes <- country_year %>%
  group_by(conflict_ep) %>%
  summarize(n_rebels=max(n_rebels), nonsplint=max(nonsplint), min_latentmean=min(latentmean), mean_latentmean=mean(latentmean, na.rm=T), max_discrimination=max(discrimination), mean_discrimination=mean(discrimination, na.rm=T), mean_intensity=mean(IntensityLevel), mean_polity=mean(polity2, na.rm=T), max_conflicts=max(n_conflicts), ethfrac=mean(ethfrac, na.rm=T), pop=max(pop, na.rm=T), rgdppc=max(rgdppc, na.rm=T), duration=(max(Year)-min(Year)), rebstrength=first(rebstrength), centcontrol=first(centcontrol), ethnic_groups=max(ethnic_groups), excluded=max(country_excluded), pcexcluded=max(pcexcluded), cont_civil=max(cont_civil), mediation_max=max(mediation_max), mediation_mean=mean(mediation_mean), pcexcluded=mean(pcexcluded, na.rm=T), pcdiscrim=mean(pcdiscrim, na.rm=T), pcmarpoldis=mean(pcmarpoldis, na.rm=T), pcmarecdis=max(pcmarecdis, na.rm=T))
