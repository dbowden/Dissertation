####### This scipt compiles all available rebel group / conflict-level covariates into a single, clean dataset ############

library(dplyr)
library(lubridate)

# 1. Load UCDP dyadic data to use as frame ------

load("ucdp-dyadic-1-2016.Rdata")

#remove interstate conflict
ucdp.dyad <- filter(ucdp.dyad, TypeOfConflict != 2)

#remove unneeded columns
ucdp.dyad <- select(ucdp.dyad, DyadId, ConflictId, Year, Location, GWNoLoc, SideA, GWNoA, SideA2nd, GWNoA2nd, SideB, SideBID, SideB2nd, Incompatibility, TerritoryName, IntensityLevel, TypeOfConflict)

#recode a few things
ucdp.dyad$Incompatibility <- recode(ucdp.dyad$Incompatibility, `1` = "territory", `2` = "government")

ucdp.dyad$TypeOfConflict <- recode(ucdp.dyad$TypeOfConflict, `1` = "extrasystemic", `3` = "internal", `4` = "internationalized")

#ucdp.dyad$IntensityLevel <- recode_factor(ucdp.dyad$IntensityLevel, `1` = "minor", `2` = "war", .ordered = T)

#create rebel group age meausure
ucdp.dyad <- ucdp.dyad %>% 
  group_by(SideBID) %>% 
  mutate(rebel_age=(Year - min(Year)))

#convert SideBID to numeric
ucdp.dyad$SideBID <- as.numeric(as.character(ucdp.dyad$SideBID))
  

# 2. Add my origins & ideology measures -------
origin <- read.csv("~/Dropbox/Civil War Data/Rebel Data/rebel_origin.csv")

origin$origin <- recode(origin$origin, "protests"="unorganized", "grassroots"="unorganized", "political party"="political organization", "student organization"="political organization", "alliance - political parties"="political organization", "underground resistance"="political organization", "secessionist organization"="political organization", "occupying military"="military faction", "deposed government"="civilian gov", "exiles/diaspora"="civilian gov", "government faction"="civilian gov", "regional government"="civilian gov", "criminal organization"="unorganized", "economic organization"="unorganized", "mercenaries"="militia", "transnational militant organization"="transnational", "transnational political organization"="transnational", "foreign intervention"="sponsorship", "remnant"="splinter", "anti-colonial"="political organization", "alliance; religious"="alliance", "political party; anti-colonial"="political organization", "civilian.gov"="civilian gov", "transnational political organization; alliance"="transnational", "religious organization; foreign intervention"="religious organization", "anti-colonial; regional government"="political organization", "student organization; tribal groups"="political organization", "militia; military faction"="militia", "military faction; splinter"="military faction", "exiles/diaspora; foreign intervention"="sponsorship", "military faction; foreign intervention"="military faction", "political party; military faction"="political organization", "military faction; transnational militant group; exiles/diaspora"="military faction")

#code splinter sources
splinters <- filter(origin, origin=="splinter")

origin$splinter.source <- ifelse(origin$name.data %in% splinters$origin.name, 1, 0)

#subset
origin <- select(origin, SideBID = actorid, origin, origin.name, parent.org.subset, splinter.source, ideology, delete)

ucdp.dyad <- left_join(ucdp.dyad, origin)

rm(origin, splinters)

# 3. Add NSA data -----
load("~/Dropbox/Civil War Data/nsa_recoded.Rdata")

#convert to yearly
nsa.frame <- nsa %>%
  mutate(styr = year(startdate), eyr=year(enddate)) %>% 
  rowwise() %>% 
  do(data.frame(obsid=.$obsid, year=seq(.$styr, .$eyr)))

nsa <- left_join(nsa.frame, nsa)

#when there are duplciated values, use last
nsa <- subset(nsa, duplicated(nsa[,c("year","dyadid")], fromLast = T)==F)

nsa <- select(nsa, Year = year, DyadId = dyadid, extraterritorial:duration, -prevact.ref, -victory.side)

ucdp.dyad <- left_join(ucdp.dyad, nsa)

rm(nsa.frame, nsa)

# 4. Add epr ties data -----
ties <- read.csv("ACD2EPR-2014.csv")

ties <- ties %>%
  rowwise() %>% 
  do(data.frame(gwgroupid=.$gwgroupid, Year=seq(.$from, .$to), DyadId=.$dyadid, claim=.$claim, recruitment=.$recruitment, support=.$support))

#clean EPR
epr <- read.csv("EPR-2014.csv")

epr <- epr %>% 
  rowwise() %>% 
  do(data.frame(gwgroupid=.$gwgroupid, Year=seq(.$from, .$to), size=.$size, status=.$status, reg_aut=.$reg_aut, groupid=.$groupid, gwid=.$gwid))

epr$status <- recode(epr$status, "MONOPOLY" = "absolute", "DOMINANT" = "absolute", "SENIOR PARTNER" = "power-sharing", "JUNIOR PARTNER" = "power-sharing", "DISCRIMINATED" = "excluded", "POWERLESS" = "excluded", "IRRELEVANT" = "excluded", "SELF-EXCLUSION" = "excluded")

epr$status <- factor(epr$status, levels=c("excluded", "power-sharing", "absolute"), ordered = T)

#get lagged status
epr <- epr %>% 
  arrange(gwgroupid, Year) %>% 
  group_by(gwgroupid) %>% 
  mutate(lag_status=lag(status))

epr$upgrade <- ifelse(epr$status > epr$lag_status, 1, 0)
epr$downgrade <- ifelse(epr$status < epr$lag_status, 1, 0)

epr <- select(epr, -lag_status)

ties <- left_join(ties, epr)

rm(epr)

#aggregate to group year
ties<- ties %>% 
  group_by(DyadId, Year) %>% 
  summarize(tot_eth=n_distinct(groupid, na.rm=TRUE), tot_eth_countries=n_distinct(gwid), eth_claim=sum(claim>0, na.rm=T), eth_recruitment=sum(recruitment>0, na.rm=T), eth_support=sum(support>0, na.rm=T), excluded=sum(status=="excluded", na.rm=T), power_sharing=sum(status=="power-sharing", na.rm=T), absolute=sum(status=="absolute", na.rm=T), reg_aut=sum(reg_aut=="true", na.rm=T), upgrade=max(upgrade, na.rm=T), downgrade=max(downgrade, na.rm=T), maxsize=max(size, na.rm=T), minsize=min(size, na.rm=T))

ucdp.dyad <- left_join(ucdp.dyad, ties)

rm(ties)

# 5. Write data -----
save(ucdp.dyad, file="~/Dropbox/Civil War Data/master_rebel_yearly.Rdata")
