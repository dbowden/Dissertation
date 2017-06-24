#### Create Country-Level Resource Site Measures - Lootable ####
library(dplyr)
library(lubridate)
library(rgdal)
library(countrycode)

#### diamonds ####
diamond <- readOGR("/Users/david/Documents/Data/Resources/Diamonds/","DIADATA")

#convert to dataframe
diamond <- data.frame(diamond)

#aggregate to sites per country
diamond <- diamond %>% 
  group_by(COWCODE) %>% 
  summarize(diamond.sites=n_distinct(PRIMKEY))

##### gems ####
gem <- readOGR("/Users/david/Documents/Data/Resources/gemdata/","GEMDATA") #no lootable distinction for this

#convert to dataframe
gem <- data.frame(gem)

#aggregate to sites per country
gem <- gem %>% 
  group_by(COWCODE) %>% 
  summarize(gem.sites=n_distinct(PRIMKEY))

#### gold ####
gold <- readOGR("/Users/david/Documents/Data/Resources/GOLDATA 1.2 v/dGOLD_L/","dGOLD_L") #the pre-packaged lootable data works for this one

#convert to dataframe
gold <- data.frame(gold)

#add surface gold
gold2 <- readOGR("/Users/david/Documents/Data/Resources/GOLDATA 1.2 v/dGOLD_s/","dGOLD_S")

gold2 <- data.frame(gold2)

gold <- rbind(gold,gold2)
rm(gold2)

#aggregate to sites per country
gold <- gold %>% 
  group_by(COWcode) %>% 
  summarize(gold.sites=n_distinct(PRIMKEY))

colnames(gold)[1] <- "COWCODE"

#### oil ####
oil <- readOGR("/Users/david/Documents/Data/Resources/PETRODATA V1.2/","Petrodata_Onshore_V1.2")

#limit to sites w/ known production
oil <- subset(oil, FIELDINFO==1)

#convert to dataframe
oil <- data.frame(oil)

#aggregate to country totals
oil <- oil %>% 
  group_by(COWCODE) %>% 
  summarize(oil.sites=n_distinct(PRIMKEY))

#### drugs ####
can <- readOGR("/Users/david/Documents/Data/Resources/DRUGDATA/DRUGDATA ArcGIS files/","CANNABIS")

coc <- readOGR("/Users/david/Documents/Data/Resources/DRUGDATA/DRUGDATA ArcGIS files/","COCA BUSH")

op <- readOGR("/Users/david/Documents/Data/Resources/DRUGDATA/DRUGDATA ArcGIS files/","OPIUM POPPY")

#convert to dataframes
can <- data.frame(can)
coc <- data.frame(coc)
op <- data.frame(op)

#aggregate
can <- can %>% 
  group_by(Country_) %>% 
  summarize(can.sites=n_distinct(ID))

colnames(can)[1] <- "Country"

coc <- coc %>% 
  group_by(Country) %>% 
  summarize(coc.sites=n_distinct(ID))

op <- op %>% 
  group_by(Country) %>% 
  summarize(op.sites=n_distinct(ID))

drugs <- merge(can,coc,all=T)
drugs <- merge(drugs,op,all=T)
rm(can,coc,op)

drugs$drug.sites <- rowSums(drugs[,2:4],na.rm=T)

drugs$COWCODE <- countrycode(drugs$Country, "country.name", "cown")

drugs <- subset(drugs, select=c(COWCODE,drug.sites))

#### Merge ####
resources <- merge(diamond,gem,all=T)
resources <- merge(resources,gold,all=T)
resources <- merge(resources,oil,all=T)
resources <- merge(resources,drugs,all=T)
rm(diamond,drugs,gem,gold,oil)


#weighted resources - count diamonds, gems, gold double
resources$diamond.weighted <- resources$diamond.sites*2
resources$gold.weighted <- resources$gold.sites*2
resources$gem.weighted <- resources$gem.sites*2

resources$weighted.resources <- rowSums(resources[5:9],na.rm=T)

#total resource sites
resources$tot.resource.sites <- rowSums(resources[,2:6],na.rm=T)

resources <- subset(resources,select=-c(diamond.weighted,gold.weighted,gem.weighted))

#write data
write.csv(resources,"all_resources_country.csv")
