###############################################################
#Data wrangling, Paula Bergman, paula.h.bergman(at)helsinki.fi#
###############################################################

#Set working directory into my course file in my computer
setwd("C:/Users/Paula/Documents/GitHub/IODS-project/IODS-final/IODS-final")

#Load the dataset into RStudio 
library(Hmisc)
science <- spss.get("daF3137.por", use.value.labels=FALSE)
# last option converts value labels to R factors

#I am interested in people's interest in science. So I decided to use variables
#Q2.1-Q2.9, that are all questions about how interested the respondent is in 
#different fields of science.
#I combined the variables by summing all these variables together and divided 
#by 9, that is the number of variables.
science$interest<-(science$Q2.1+science$Q2.2+science$Q2.3+science$Q2.4+
  science$Q2.5+science$Q2.6+science$Q2.7+science$Q2.8+science$Q2.9)/9

##I then turned the variable into a dicotomous one by categorizing the obsrevations
#>=2.5 into not interested (=0) and <2.5 into interested (=1). First I removed
#all the observations that have NA in science$interest.
science<-subset(science, !is.na(interest))

#Because the data was first in SPSS-form, I had to remove the label values
#from the variables in order to be able to use it as numeric.
library(labelled)
science$interest<-remove_val_labels(science$interest)

#Categorizing the variable
science$interested<-ifelse(science$interest<2.5,1,0)

#So now we have 1012 observations in the data. 552 of those are not interested
#in science and 460 are.

#The background variables that I chose were sex, agegroup, size of the hometown,
#and the level of professional education
#So for the purposes of this project I decided to make a whole new subset with 
#only the variable to be explained and the potential explanatory variables.
#I first removed the labels from these variables as well and turned them into
#numeric
science$BV1<-remove_val_labels(science$BV1)
science$BV1<-as.numeric(science$BV1)
science$BV2<-remove_val_labels(science$BV2)
science$BV2<-as.numeric(science$BV2)
science$BV3<-remove_val_labels(science$BV3)
science$BV3<-as.numeric(science$BV3)
science$BV6<-remove_val_labels(science$BV6)
science$BV6<-as.numeric(science$BV6)

#Subsetting
myvars<-c("BV1","BV2","BV3","BV6","interested")
SCIENCE<-science[myvars]

#I renamed the variables to be a little bit clearer to the reader
names(SCIENCE) <- c("sex","age","townsize","edu","interested")

##Lastly I decided to remove the rows that contain any missingness
#Print out a completeness indicator of the 'human' data
comp<-complete.cases(SCIENCE)
comp

# filter out all rows with NA values
SCIENCE_ <- filter(SCIENCE, comp==TRUE)

#Save the data for the future analysis
write.csv(SCIENCE_,"SCIENCE.csv",row.names=F)
#Read the data back in to check if everything went correctly
testi<-read.csv("SCIENCE.csv",header=T)

