#Import
#author: Eli Groves


#This file reads in all of the Microsoft Excel files (.xlsx), cleans them, and merges them
#For the sch.race file, it also prepares the data for Tableau

library(readxl)
library(dplyr)
library(tidyr)
library(writexl)
setwd("G:/Team Drives/NYSED/Analysis/Enrollment")

rm(list = ls())


#########################################
#Create file paths for each subdirectory#
#########################################

dis.econ.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/district_econ"
dis.dis.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/district_disability"
dis.ell.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/district_ell"
dis.gender.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/district_gender"
dis.race.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/district_race"
dis.total.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/district_total"

sch.econ.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/school_econ"
sch.dis.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/school_disability"
sch.ell.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/school_ell"
sch.gender.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/school_gender"
sch.race.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/school_race"
sch.total.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw/school_total"

raw.data.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw"

#########################################
#Create file lists for each subdirectory#
#########################################

FL.d.econ <- list.files(path = dis.econ.loc, pattern = "xlsx")
FL.d.dis <- list.files(path = dis.dis.loc, pattern = "xlsx")
FL.d.ell <- list.files(path = dis.ell.loc, pattern = "xlsx")
FL.d.gender <- list.files(path = dis.gender.loc, pattern = "xlsx")
FL.d.race <- list.files(path = dis.race.loc, pattern = "xlsx")
FL.d.total <- list.files(path = dis.total.loc, pattern = "xlsx")

FL.s.econ <- list.files(path = sch.econ.loc, pattern = "xlsx")
FL.s.dis <- list.files(path = sch.dis.loc, pattern = "xlsx")
FL.s.ell <- list.files(path = sch.ell.loc, pattern = "xlsx")
FL.s.gender <- list.files(path = sch.gender.loc, pattern = "xlsx")
FL.s.race <- list.files(path = sch.race.loc, pattern = "xlsx")
FL.s.total <- list.files(path = sch.total.loc, pattern = "xlsx")

################################################
################################################
###Read in set of files from each folder########
################################################
################################################

###########
#Districts#
###########
#set the working directory to each folder, then read in the files and bind them
setwd(dis.econ.loc)
dis.econ.1 <- do.call("rbind", lapply(FL.d.econ, read_excel))
dis.econ.1[,8:26] <-sapply(dis.econ.1[,8:26], as.numeric)
dis.econ <- dis.econ.1 %>%
  mutate(PK = `PK (HALF DAY)` + `PK (FULL DAY)`) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = `KG (FULL DAY)` + `KG (HALF DAY)`) %>%
  select(-c("PK (HALF DAY)", "PK (FULL DAY)", "KG (HALF DAY)", "KG (FULL DAY)", "DATE OF REPORT"))
dis.econ <- dis.econ %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `SUBGROUP CODE`, `SUBGROUP NAME`, `PK12 TOTAL`, `K12 TOTAL`,
         PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` , `GRADE 11`,
         `GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

setwd(dis.dis.loc)
dis.dis.1 <- do.call("rbind", lapply(FL.d.dis, read_excel))
dis.dis.1[,8:26] <-sapply(dis.dis.1[,8:26], as.numeric)
dis.dis <- dis.dis.1 %>%
  mutate(PK = `PK (HALF DAY)` + `PK (FULL DAY)`) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = `KG (FULL DAY)` + `KG (HALF DAY)`) %>%
  select(-c("PK (HALF DAY)", "PK (FULL DAY)", "KG (HALF DAY)", "KG (FULL DAY)", "DATE OF REPORT"))
dis.dis <- dis.dis %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `SUBGROUP CODE`, `SUBGROUP NAME`, `PK12 TOTAL`, `K12 TOTAL`,
         PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` , `GRADE 11`,
         `GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

setwd(dis.ell.loc)
dis.ell.1 <- do.call("rbind", lapply(FL.d.ell, read_excel))
dis.ell.1[,8:26] <-sapply(dis.ell.1[,8:26], as.numeric)
dis.ell <- dis.ell.1 %>%
  mutate(PK = `PK (HALF DAY)` + `PK (FULL DAY)`) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = `KG (FULL DAY)` + `KG (HALF DAY)`) %>%
  select(-c("PK (HALF DAY)", "PK (FULL DAY)", "KG (HALF DAY)", "KG (FULL DAY)", "DATE OF REPORT"))
dis.ell <- dis.ell %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `SUBGROUP CODE`, `SUBGROUP NAME`, `PK12 TOTAL`, `K12 TOTAL`,
         PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` , `GRADE 11`,
         `GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)


#Gender, race, and total need to be read in as separate batches, cleaned, and then merged because they underwent formatting changes throughout the collection period

#Gender#
########

setwd(dis.gender.loc)
#years 2012-2019
#note: indexing based on order of files could cause error int the future, consider fixing by changing file paths to use a different pattern
dis.gen1 <- do.call("rbind", lapply(FL.d.gender[1:8], read_excel))
#years 1995-2011
dis.gen2 <- do.call("rbind", lapply(FL.d.gender[-(1:8)], read_excel))

#match these two by 1.combining "PK halfday" and "PK fullday" into just PK and 2.dropping "date of report"
#rename these because R doesn't like column names with parentheses
names(dis.gen1)[names(dis.gen1) == "PK (HALF DAY)"] <- "PKHD"
names(dis.gen1)[names(dis.gen1) == "PK (FULL DAY)"] <- "PKFD"
names(dis.gen1)[names(dis.gen1) == "KG (HALF DAY)"] <- "KGHD"
names(dis.gen1)[names(dis.gen1) == "KG (FULL DAY)"] <- "KGFD"
names(dis.gen2)[names(dis.gen2) == "KG (HALF DAY)"] <- "KGHD"
names(dis.gen2)[names(dis.gen2) == "KG (FULL DAY)"] <- "KGFD"
names(dis.gen2)[names(dis.gen2) == "county"] <- "COUNTY" 

dis.gen1$PKHD <- as.numeric(dis.gen1$PKHD)
dis.gen1$PKFD <- as.numeric(dis.gen1$PKFD)

dis.gen4 <- dis.gen1 %>% 
  mutate(PK = PKHD + PKFD) %>%
  select(-c("DATE OF REPORT", "PKHD", "PKFD"))

dis.gender.1 <- rbind(dis.gen4,dis.gen2)
dis.gender.1[,7:24] <- sapply(dis.gender.1[,7:24], as.numeric)

dis.gender <- dis.gender.1 %>%
  mutate(KG = KGHD + KGFD) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  select(-c(KGHD, KGFD))

dis.gender <- dis.gender %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `SUBGROUP CODE`, `SUBGROUP NAME`, `PK12 TOTAL`, `K12 TOTAL`,
         PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` , `GRADE 11`,
         `GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

#Race#
######

setwd(dis.race.loc)
#years 2012-2019
dis.race.b1 <- do.call("rbind", lapply(FL.d.race[1:8], read_excel))
#years 1995-2011
dis.race.b2 <- do.call("rbind", lapply(FL.d.race[9:25], read_excel))
#years 1977-1994
dis.race.b3 <- do.call("rbind", lapply(FL.d.race[26:43], read_excel))

names(dis.race.b1)[names(dis.race.b1) == "PK (HALF DAY)"] <- "PKHD"
names(dis.race.b1)[names(dis.race.b1) == "PK (FULL DAY)"] <- "PKFD"
names(dis.race.b1)[names(dis.race.b1) == "KG (HALF DAY)"] <- "KGHD"
names(dis.race.b1)[names(dis.race.b1) == "KG (FULL DAY)"] <- "KGFD"

names(dis.race.b2)[names(dis.race.b2) == "KG (HALF DAY)"] <- "KGHD"
names(dis.race.b2)[names(dis.race.b2) == "KG (FULL DAY)"] <- "KGFD"
names(dis.race.b2)[names(dis.race.b2) == "county"] <- "COUNTY" 


names(dis.race.b3)[names(dis.race.b3) == "KG (HALF DAY)"] <- "KGHD"
names(dis.race.b3)[names(dis.race.b3) == "KG (FULL DAY)"] <- "KGFD"
names(dis.race.b3)[names(dis.race.b3) == "county"] <- "COUNTY" 

#convert appropriate columncs to numeric
dis.race.b1[,8:26] <- sapply(dis.race.b1[,8:26], as.numeric)
dis.race.b2[,7:24] <- sapply(dis.race.b2[,7:24], as.numeric)
dis.race.b3[,7:23] <- sapply(dis.race.b3[,7:23], as.numeric)


dis.race.b11 <- dis.race.b1 %>%
  mutate(PK = PKHD + PKFD) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c("DATE OF REPORT", PKHD, PKFD, KGHD, KGFD))

dis.race.b21 <- dis.race.b2 %>%  
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c(KGHD, KGFD))

dis.race <- rbind(dis.race.b11, dis.race.b21)

dis.race.b31 <- dis.race.b3 %>%
  mutate(KG = KGFD + KGHD) %>%
  select(-c(KGFD, KGHD))

dis.race <- bind_rows(dis.race,dis.race.b31)

dis.race <- dis.race %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `SUBGROUP CODE`, `SUBGROUP NAME`, `PK12 TOTAL`, `K12 TOTAL`,
         PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` , `GRADE 11`,
         `GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

#Total#
#######

setwd(dis.total.loc)

#years 2012-2019
dis.total.b1 <- do.call("rbind", lapply(FL.d.total[1:8], read_excel))
#years 1995-2011
dis.total.b2 <- do.call("rbind", lapply(FL.d.total[27:43], read_excel))
#years 1977-1994
dis.total.b3 <- do.call("rbind", lapply(FL.d.total[9:26], read_excel))

names(dis.total.b1)[names(dis.total.b1) == "PK (HALF DAY)"] <- "PKHD"
names(dis.total.b1)[names(dis.total.b1) == "PK (FULL DAY)"] <- "PKFD"
names(dis.total.b1)[names(dis.total.b1) == "KG (HALF DAY)"] <- "KGHD"
names(dis.total.b1)[names(dis.total.b1) == "KG (FULL DAY)"] <- "KGFD"

names(dis.total.b2)[names(dis.total.b2) == "KG (HALF DAY)"] <- "KGHD"
names(dis.total.b2)[names(dis.total.b2) == "KG (FULL DAY)"] <- "KGFD"
names(dis.total.b2)[names(dis.total.b2) == "county"] <- "COUNTY" 


names(dis.total.b3)[names(dis.total.b3) == "KG (HALF DAY)"] <- "KGHD"
names(dis.total.b3)[names(dis.total.b3) == "KG (FULL DAY)"] <- "KGFD"
names(dis.total.b3)[names(dis.total.b3) == "county"] <- "COUNTY" 

#convert appropriate columncs to numeric
dis.total.b1[,8:26] <- sapply(dis.total.b1[,8:26], as.numeric)
dis.total.b2[,7:24] <- sapply(dis.total.b2[,7:24], as.numeric)
dis.total.b3[,7:23] <- sapply(dis.total.b3[,7:23], as.numeric)


dis.total.b11 <- dis.total.b1 %>%
  mutate(PK = PKHD + PKFD) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c("DATE OF REPORT", PKHD, PKFD, KGHD, KGFD))

dis.total.b21 <- dis.total.b2 %>%  
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c(KGHD, KGFD))

dis.total <- rbind(dis.total.b11, dis.total.b21)

dis.total.b31 <- dis.total.b3 %>%
  mutate(KG = KGFD + KGHD) %>%
  select(-c(KGFD, KGHD))

dis.total <- bind_rows(dis.total,dis.total.b31)

dis.total <- dis.total %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `SUBGROUP CODE`, `SUBGROUP NAME`, `PK12 TOTAL`, `K12 TOTAL`,
         PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` , `GRADE 11`,
         `GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

###########
#Schools###
###########

setwd(sch.econ.loc)
sch.econ.1 <- do.call("rbind", lapply(FL.s.econ, read_excel))
sch.econ.1[,11:29] <-sapply(sch.econ.1[,11:29], as.numeric)
sch.econ <- sch.econ.1 %>%
  mutate(PK = `PK (HALF DAY)` + `PK (FULL DAY)`) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = `KG (FULL DAY)` + `KG (HALF DAY)`) %>%
  select(-c("PK (HALF DAY)", "PK (FULL DAY)", "KG (HALF DAY)", "KG (FULL DAY)", "DATE OF REPORT"))
sch.econ <- sch.econ %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `STATE LOCATION ID`, `LOCATION NAME`, `SCHOOL TYPE`, `SUBGROUP CODE`, `SUBGROUP NAME`, 
         `PK12 TOTAL`, `K12 TOTAL`, PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` ,
         `GRADE 11`,`GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

#note that this excludes 2013 because the data was inconsistent (suppressed) for that year
setwd(sch.dis.loc)
sch.dis.1 <- do.call("rbind", lapply(FL.s.dis, read_excel))
sch.dis.1[,11:29] <-sapply(sch.dis.1[,11:29], as.numeric)
sch.dis <- sch.dis.1 %>%
  mutate(PK = `PK (HALF DAY)` + `PK (FULL DAY)`) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = `KG (FULL DAY)` + `KG (HALF DAY)`) %>%
  select(-c("PK (HALF DAY)", "PK (FULL DAY)", "KG (HALF DAY)", "KG (FULL DAY)", "DATE OF REPORT"))
sch.dis <- sch.dis %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `STATE LOCATION ID`, `LOCATION NAME`, `SCHOOL TYPE`, `SUBGROUP CODE`, `SUBGROUP NAME`, 
         `PK12 TOTAL`, `K12 TOTAL`, PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` ,
         `GRADE 11`,`GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

#note that this excludes 2013 because the data was inconsistent (suppressed) for that year
setwd(sch.ell.loc)
sch.ell.1 <- do.call("rbind", lapply(FL.s.ell, read_excel))
sch.ell.1[,11:29] <-sapply(sch.ell.1[,11:29], as.numeric)
sch.ell <- sch.ell.1 %>%
  mutate(PK = `PK (HALF DAY)` + `PK (FULL DAY)`) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = `KG (FULL DAY)` + `KG (HALF DAY)`) %>%
  select(-c("PK (HALF DAY)", "PK (FULL DAY)", "KG (HALF DAY)", "KG (FULL DAY)", "DATE OF REPORT"))
sch.ell <- sch.ell %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `STATE LOCATION ID`, `LOCATION NAME`, `SCHOOL TYPE`, `SUBGROUP CODE`, `SUBGROUP NAME`, 
         `PK12 TOTAL`, `K12 TOTAL`, PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` ,
         `GRADE 11`,`GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)


#Gender#
########

setwd(sch.gender.loc)
#years 2012-2019
#note: indexing based on order of files could cause error int the future, consider fixing by changing file paths to use a different pattern
sch.gen1 <- do.call("rbind", lapply(FL.s.gender[18:25], read_excel))
#years 1995-2011
sch.gen2 <- do.call("rbind", lapply(FL.s.gender[1:17], read_excel))

#match these two by 1.combining "PK halfday" and "PK fullday" into just PK and 2.dropping "date of report"
#rename these because R doesn't like column names with parentheses
names(sch.gen1)[names(sch.gen1) == "PK (HALF DAY)"] <- "PKHD"
names(sch.gen1)[names(sch.gen1) == "PK (FULL DAY)"] <- "PKFD"
names(sch.gen1)[names(sch.gen1) == "KG (HALF DAY)"] <- "KGHD"
names(sch.gen1)[names(sch.gen1) == "KG (FULL DAY)"] <- "KGFD"
names(sch.gen2)[names(sch.gen2) == "KG (HALF DAY)"] <- "KGHD"
names(sch.gen2)[names(sch.gen2) == "KG (FULL DAY)"] <- "KGFD"
names(sch.gen2)[names(sch.gen2) == "county"] <- "COUNTY" 

sch.gen1$PKHD <- as.numeric(sch.gen1$PKHD)
sch.gen1$PKFD <- as.numeric(sch.gen1$PKFD)

sch.gen4 <- sch.gen1 %>% 
  mutate(PK = PKHD + PKFD) %>%
  select(-c("DATE OF REPORT", "PKHD", "PKFD"))

sch.gender.1 <- rbind(sch.gen4,sch.gen2)
sch.gender.1[,10:27] <- sapply(sch.gender.1[,10:27], as.numeric)

sch.gender <- sch.gender.1 %>%
  mutate(KG = KGHD + KGFD) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  select(-c(KGHD, KGFD))

sch.gender <- sch.gender %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `STATE LOCATION ID`, `LOCATION NAME`, `SCHOOL TYPE`, `SUBGROUP CODE`, `SUBGROUP NAME`, 
         `PK12 TOTAL`, `K12 TOTAL`, PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` ,
         `GRADE 11`,`GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)


#Race#
######

setwd(sch.race.loc)
#years 2012-2019
sch.race.b1 <- do.call("rbind", lapply(FL.s.race[36:43], read_excel))
#years 1995-2011
sch.race.b2 <- do.call("rbind", lapply(FL.s.race[1:17], read_excel))
#years 1977-1994
sch.race.b3 <- do.call("rbind", lapply(FL.s.race[18:35], read_excel))

names(sch.race.b1)[names(sch.race.b1) == "PK (HALF DAY)"] <- "PKHD"
names(sch.race.b1)[names(sch.race.b1) == "PK (FULL DAY)"] <- "PKFD"
names(sch.race.b1)[names(sch.race.b1) == "KG (HALF DAY)"] <- "KGHD"
names(sch.race.b1)[names(sch.race.b1) == "KG (FULL DAY)"] <- "KGFD"

names(sch.race.b2)[names(sch.race.b2) == "KG (HALF DAY)"] <- "KGHD"
names(sch.race.b2)[names(sch.race.b2) == "KG (FULL DAY)"] <- "KGFD"
names(sch.race.b2)[names(sch.race.b2) == "county"] <- "COUNTY" 


names(sch.race.b3)[names(sch.race.b3) == "KG (HALF DAY)"] <- "KGHD"
names(sch.race.b3)[names(sch.race.b3) == "KG (FULL DAY)"] <- "KGFD"
names(sch.race.b3)[names(sch.race.b3) == "county"] <- "COUNTY" 

#convert appropriate columncs to numeric
sch.race.b1[,11:29] <- sapply(sch.race.b1[,11:29], as.numeric)
sch.race.b2[,10:27] <- sapply(sch.race.b2[,10:27], as.numeric)
sch.race.b3[,9:25] <- sapply(sch.race.b3[,9:25], as.numeric)


sch.race.b11 <- sch.race.b1 %>%
  mutate(PK = PKHD + PKFD) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c("DATE OF REPORT", PKHD, PKFD, KGHD, KGFD))

sch.race.b21 <- sch.race.b2 %>%  
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c(KGHD, KGFD))

sch.race <- rbind(sch.race.b11, sch.race.b21)

sch.race.b31 <- sch.race.b3 %>%
  mutate(KG = KGFD + KGHD) %>%
  select(-c(KGFD, KGHD))

sch.race <- bind_rows(sch.race,sch.race.b31)

sch.race <- sch.race %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `STATE LOCATION ID`, `LOCATION NAME`, `SCHOOL TYPE`, `SUBGROUP CODE`, `SUBGROUP NAME`, 
         `PK12 TOTAL`, `K12 TOTAL`, PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` ,
         `GRADE 11`,`GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)


#Total#
#######

setwd(sch.total.loc)
#years 2012-2019
sch.total.b1 <- do.call("rbind", lapply(FL.s.total[36:43], read_excel))
#years 1995-2011
sch.total.b2 <- do.call("rbind", lapply(FL.s.total[19:35], read_excel))
#years 1977-1994
sch.total.b3 <- do.call("rbind", lapply(FL.s.total[1:18], read_excel))

names(sch.total.b1)[names(sch.total.b1) == "PK (HALF DAY)"] <- "PKHD"
names(sch.total.b1)[names(sch.total.b1) == "PK (FULL DAY)"] <- "PKFD"
names(sch.total.b1)[names(sch.total.b1) == "KG (HALF DAY)"] <- "KGHD"
names(sch.total.b1)[names(sch.total.b1) == "KG (FULL DAY)"] <- "KGFD"

names(sch.total.b2)[names(sch.total.b2) == "KG (HALF DAY)"] <- "KGHD"
names(sch.total.b2)[names(sch.total.b2) == "KG (FULL DAY)"] <- "KGFD"
names(sch.total.b2)[names(sch.total.b2) == "county"] <- "COUNTY" 


names(sch.total.b3)[names(sch.total.b3) == "KG (HALF DAY)"] <- "KGHD"
names(sch.total.b3)[names(sch.total.b3) == "KG (FULL DAY)"] <- "KGFD"
names(sch.total.b3)[names(sch.total.b3) == "county"] <- "COUNTY" 

#convert appropriate columncs to numeric
sch.total.b1[,11:29] <- sapply(sch.total.b1[,11:29], as.numeric)
sch.total.b2[,10:27] <- sapply(sch.total.b2[,10:27], as.numeric)
sch.total.b3[,9:25] <- sapply(sch.total.b3[,9:25], as.numeric)


sch.total.b11 <- sch.total.b1 %>%
  mutate(PK = PKHD + PKFD) %>%
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c("DATE OF REPORT", PKHD, PKFD, KGHD, KGFD))

sch.total.b21 <- sch.total.b2 %>%  
  mutate(`K12 TOTAL` = `PK12 TOTAL` - PK) %>%
  mutate(KG = KGHD + KGFD) %>%
  select(-c(KGHD, KGFD))

sch.total <- rbind(sch.total.b11, sch.total.b21)

sch.total.b31 <- sch.total.b3 %>%
  mutate(KG = KGFD + KGHD) %>%
  select(-c(KGFD, KGHD))

sch.total <- bind_rows(sch.total,sch.total.b31)

sch.total <- sch.total %>%
  select(`SCHOOL YEAR`, COUNTY, `STATE DISTRICT ID`, `DISTRICT NAME`, `STATE LOCATION ID`, `LOCATION NAME`, `SCHOOL TYPE`, `SUBGROUP CODE`, `SUBGROUP NAME`, 
         `PK12 TOTAL`, `K12 TOTAL`, PK, KG, `GRADE 1`, `GRADE 2`, `GRADE 3`, `GRADE 4`, `GRADE 5`, `GRADE 6`, `GRADE 7`, `GRADE 8`, `GRADE 9`,`GRADE 10` ,
         `GRADE 11`,`GRADE 12`, `UNGRADED (ELEMENTARY)`, `UNGRADED (SECONDARY)`)

################
###Clean data###
################ PICK UP HERE

#make lists of dataframes for easy editing
dis.list = list(dis.econ, dis.dis, dis.ell, dis.gender, dis.race, dis.total)
sch.list = list(sch.econ, sch.dis, sch.ell, sch.gender, sch.race, sch.total)

dis.col.names <- c("year", "county", "dis_id", "dis_name", "subgroup_code", "subgroup_name", "pk12_total", "k12_total",
                   "pk", "kg", "grade_1", "grade_2", "grade_3", "grade_4","grade_5", "grade_6",
                   "grade_7", "grade_8","grade_9", "grade_10","grade_11", "grade_12", "ungraded_ele", "ungraded_sec")

sch.col.names <- c("year", "county", "dis_id", "dis_name", "loc_id", "loc_name", "school_type", "subgroup_code",
                       "subgroup_name", "pk12_total", "k12_total", "pk", "kg", "grade_1", "grade_2", "grade_3", "grade_4","grade_5", "grade_6",
                       "grade_7", "grade_8","grade_9", "grade_10","grade_11", "grade_12", "ungraded_ele", "ungraded_sec")



colnames(dis.race) <- dis.col.names
colnames(dis.ell) <- dis.col.names
colnames(dis.dis) <- dis.col.names
colnames(dis.total) <- dis.col.names
colnames(dis.gender) <- dis.col.names
colnames(dis.econ) <- dis.col.names

colnames(sch.race) <- sch.col.names
colnames(sch.ell) <- sch.col.names
colnames(sch.dis) <- sch.col.names
colnames(sch.total) <- sch.col.names
colnames(sch.gender) <- sch.col.names
colnames(sch.econ) <- sch.col.names


########################################
##Only working on sch.race for Tableau##
########################################***
setwd("G:/Team Drives/NYSED/Analysis/Enrollment/Data/Raw")
BEDS_correction <- read_excel("nyc_BEDScode_correction.xlsx")
BEDS_correction$loc_name_new <- as.character(BEDS_correction$loc_name_new)
BEDS_correction <- BEDS_correction %>%
  select(-loc_name)


setwd("G:/Team Drives/NYSED/Analysis/Enrollment")

unique.years <- unique(sch.race$year)

sch.race$year[sch.race$year == "1976-77"] <- "1977"
sch.race$year[sch.race$year == "1977-78"] <- "1978"
sch.race$year[sch.race$year == "1978-79"] <- "1979"
sch.race$year[sch.race$year == "1979-80"] <- "1980"
sch.race$year[sch.race$year == "1980-81"] <- "1981"
sch.race$year[sch.race$year == "1981-82"] <- "1982"
sch.race$year[sch.race$year == "1982-83"] <- "1983"
sch.race$year[sch.race$year == "1983-84"] <- "1984"
sch.race$year[sch.race$year == "1984-85"] <- "1985"
sch.race$year[sch.race$year == "1985-86"] <- "1986"
sch.race$year[sch.race$year == "1986-87"] <- "1987"
sch.race$year[sch.race$year == "1987-88"] <- "1988"
sch.race$year[sch.race$year == "1988-89"] <- "1989"
sch.race$year[sch.race$year == "1989-90"] <- "1990"
sch.race$year[sch.race$year == "1990-91"] <- "1991"
sch.race$year[sch.race$year == "1991-92"] <- "1992"
sch.race$year[sch.race$year == "1992-93"] <- "1993"
sch.race$year[sch.race$year == "1993-94"] <- "1994"
sch.race$year[sch.race$year == "1994-1995"] <- "1995"
sch.race$year[sch.race$year == "1995-1996"] <- "1996"
sch.race$year[sch.race$year == "1996-1997"] <- "1997"
sch.race$year[sch.race$year == "1997-1998"] <- "1998"
sch.race$year[sch.race$year == "1998-1999"] <- "1999"
sch.race$year[sch.race$year == "1999-2000"] <- "2000"
sch.race$year[sch.race$year == "2000-2001"] <- "2001"
sch.race$year[sch.race$year == "2001-2002"] <- "2002"
sch.race$year[sch.race$year == "2002-2003"] <- "2003"
sch.race$year[sch.race$year == "2003-2004"] <- "2004"
sch.race$year[sch.race$year == "2004-2005"] <- "2005"
sch.race$year[sch.race$year == "2005-2006"] <- "2006"
sch.race$year[sch.race$year == "2006-2007"] <- "2007"
sch.race$year[sch.race$year == "2007-2008"] <- "2008"
sch.race$year[sch.race$year == "2008-2009"] <- "2009"
sch.race$year[sch.race$year == "2009-2010"] <- "2010"
sch.race$year[sch.race$year == "2010-2011"] <- "2011"
sch.race$year[sch.race$year == "2011-12"] <- "2012"
sch.race$year[sch.race$year == "2012-13"] <- "2013"
sch.race$year[sch.race$year == "2013-14"] <- "2014"
sch.race$year[sch.race$year == "2014-15"] <- "2015"
sch.race$year[sch.race$year == "2015-16"] <- "2016"
sch.race$year[sch.race$year == "2016-17"] <- "2017"
sch.race$year[sch.race$year == "2017-18"] <- "2018"
sch.race$year[sch.race$year == "2018-19"] <- "2019"

#The district codes for NYC schools were changed from school district codes to geographical district codes. This affects the loc_id. To correct this we
#made a file in excel that maps NYC schools to their updated district code

#full outer join
sch.race.beds <- merge(sch.race, BEDS_correction, by = c("loc_id"), all.x = T)
sch.race.beds1 <- sch.race.beds %>%
  mutate(revised_loc_id = ifelse(is.na(loc_id_new), loc_id, loc_id_new)) %>%
  mutate(revised_loc_name = ifelse(is.na(loc_name_new), loc_name, loc_name_new)) %>%
  select(-c("loc_id", "loc_name", "loc_id_new", "loc_name_new")) %>%
  rename(loc_id = revised_loc_id, loc_name = revised_loc_name)

sch.race <- sch.race.beds1

#Find schools with multiple spellings and assign most recent year
all.names.sch <- sch.race %>%
  select(year, county, dis_id, dis_id, dis_name, loc_id, loc_name)

#Find schools with more than one spelling
names.test <- all.names.sch %>%
  group_by(loc_id) %>%
  summarise(num_names = n_distinct(loc_name)) %>%
  filter(num_names > 1)

#Create table of all school names tied to these school codes
many.names <- inner_join(all.names.sch,names.test, by = "loc_id") %>%
  select(loc_id, loc_name, year)

#Find most recent year of operation for each school
many.names$year <- as.numeric(many.names$year)
recent.year <- many.names %>%
  group_by(loc_id) %>%
  summarise(year = max(year))

#use most recent year to create list of master names
sch.names <- inner_join(many.names, recent.year, by = c("year", "loc_id")) %>%
  select(loc_id, master_name = loc_name)

#create list of unique master_names linked to dis_id and loc_id
all.names.sch1 <- left_join(all.names.sch, sch.names, by = "loc_id") %>%
  mutate(master_school_name = ifelse(is.na(master_name), loc_name, master_name)) %>%
  select(loc_id, dis_id, school_name = master_school_name) %>%
  distinct()



#update sch.race with the master names
sch.race.final <- inner_join(sch.race, all.names.sch1, by = c("dis_id", "loc_id")) %>%
  select(-c("subgroup_code", "loc_name"))

colnames(sch.race.final)[colnames(sch.race.final) == "school_name" ] <- "loc_name"

#******

#find districts with multiple spellings and assign most recent year's spelling

all.names.dis <- sch.race.final %>%
  select(year, county, dis_id, dis_id, dis_name, loc_id, loc_name)

#Find schools with more than one spelling
names.test.dis <- all.names.dis %>%
  group_by(dis_id) %>%
  summarise(num_names = n_distinct(dis_name)) %>%
  filter(num_names > 1)

#Create table of all school names tied to these school codes
many.names.dis <- inner_join(all.names.dis,names.test.dis, by = "dis_id") %>%
  select(dis_id, dis_name, year)

many.names.dis$year <- as.numeric(many.names.dis$year)
recent.year.dis <- many.names.dis %>%
  group_by(dis_id) %>%
  summarise(year = max(year))

#use most recent year to create list of master names
dis.names <- inner_join(many.names.dis, recent.year.dis, by = c("year", "dis_id")) %>%
  select(dis_id, master_name = dis_name)

#create list of unique master_names linked to dis_id and loc_id
#note: this line of code may take a minute or two to run
all.names.dis1 <- left_join(all.names.dis, dis.names, by = "dis_id") %>%
  mutate(master_dis_name = ifelse(is.na(master_name), dis_name, master_name)) %>%
  select(loc_id, dis_id, master_dis_name) %>%
  distinct()


#update sch.race with the master names
sch.race.final2 <- inner_join(sch.race.final, all.names.dis1, by = c("dis_id", "loc_id")) %>%
  select(-c("dis_name")) %>%
  rename(dis_name = master_dis_name)

#reassign to sch.race.final to avoid updating the variables
sch.race.final <- sch.race.final2


#standardize sub_group races
unique.races <- unique(sch.race.final$subgroup_name)
sch.race.final$subgroup_name[sch.race.final$subgroup_name == "American Indian or Alaska Native"] <- "American Indian/Alaska Native"
sch.race.final$subgroup_name[sch.race.final$subgroup_name == "Hispanic or Latino"] <- "Hispanic"
sch.race.final$subgroup_name[sch.race.final$subgroup_name == "Black or African American"] <- "Black"
sch.race.final$subgroup_name[sch.race.final$subgroup_name == "Asian or Pacific Islander"] <- "Asian/Pacific Islander"
unique.races <- unique(sch.race.final$subgroup_name)

sch.race.final.for.correction <- sch.race.final
 
sch.race.final <- sch.race.final %>%
  mutate(dis_loc_name <- paste(dis_name," - ",loc_name)) 

colnames(sch.race.final)[27] <- "dis_loc_name"

sch.race.final.names <- sch.race.final %>%
  select(loc_id, loc_name, dis_loc_name) %>%
  distinct()


sch.race.final <- sch.race.final %>%
  select(-loc_name, -dis_loc_name)


#turn it into long format for grade selection
key_col <- "Grade"
value_col <- "num_students"
gather_col <- c("pk", "kg", "grade_1", "grade_2", "grade_3", "grade_4","grade_5", "grade_6",
                "grade_7", "grade_8","grade_9", "grade_10","grade_11", "grade_12", "ungraded_ele", "ungraded_sec")

sch.race.final.long <- sch.race.final %>%
  gather(key_col, value_col, gather_col)

colnames(sch.race.final.long)[colnames(sch.race.final.long) == "key_col" ] <- "grade"
colnames(sch.race.final.long)[colnames(sch.race.final.long) == "value_col" ] <- "number_of_students"


################
###Write CSVs###
################
clean.data.output.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/data/Clean/"
tableau.output.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/output/for_tableau/"
continued.analysis.output.loc <- "G:/Team Drives/NYSED/Analysis/Enrollment/output/continued_analysis/"

#this is being written as an xlsx file because Excel removes the leading 0's when opening CSVs
#write_xlsx(sch.race.final.for.correction, paste0(continued.analysis.output.loc, "sch_race_final_for_correction.xlsx"))

#write.csv(sch.race.final, paste0(tableau.output.loc, "sch_race_final.csv"), row.names = F)
write.csv(sch.race.final.names, paste0(tableau.output.loc, "sch_race_final_names.csv"), row.names = F)
#write_xlsx(sch.race.final.names, paste0(tableau.output.loc, "sch_race_final_names.xlsx"))
write.csv(sch.race.final.long, paste0(tableau.output.loc, "sch_race_final_long.csv"), row.names = F)


# write.csv(dis.econ, paste0(clean.data.output.loc, "dis_econ.csv"), row.names = F)
# write.csv(dis.dis, paste0(clean.data.output.loc, "dis_dis.csv"), row.names = F)
# write.csv(dis.ell, paste0(clean.data.output.loc, "dis_ell.csv"), row.names = F)
# write.csv(dis.gender, paste0(clean.data.output.loc, "dis_gender.csv"), row.names = F)
# write.csv(dis.race, paste0(clean.data.output.loc, "dis_race.csv"), row.names = F)
# write.csv(dis.total, paste0(clean.data.output.loc, "dis_total.csv"), row.names = F)
# 
# write.csv(sch.econ, paste0(clean.data.output.loc, "sch_econ.csv"), row.names = F)
# write.csv(sch.dis, paste0(clean.data.output.loc, "sch_dis.csv"), row.names = F)
# write.csv(sch.ell, paste0(clean.data.output.loc, "sch_ell.csv"), row.names = F)
# write.csv(sch.gender, paste0(clean.data.output.loc, "sch_gender.csv"), row.names = F)
# write.csv(sch.race, paste0(clean.data.output.loc, "sch_race.csv"), row.names = F)
# write.csv(sch.total, paste0(clean.data.output.loc, "sch_total.csv"), row.names = F)




