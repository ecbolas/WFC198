############# WFCB 198 - Lab 5 N mixture models

## set working directory to Lab 5
## install and load package unmarked

################ Slide 3
data(mallard)
str(mallard.y)
str(mallard.site)
str(mallard.obs)

################ Slide 4 - data summaries

##number of sites surveyed
dim(mallard.y)[1]

##avg number of mallards per survey
mean(mallard.y, na.rm=T)

##total number of mallards over all survyes
sum(mallard.y, na.rm=T)

##mean, range of elevation, forest cover
mean(mallard.site$elev); range(mallard.site$elev)
mean(mallard.site$forest); range(mallard.site$forest)

##avg day of year per survey
mean(mallard.obs$date[,1])
mean(mallard.obs$date[,2])
mean(mallard.obs$date[,3], na.rm=T)

##how many sites had all 3 surveys?
no3rdsurvey<-sum(is.na(mallard.obs$date[,3]))
allsurveys<-dim(mallard.y)[1]-no3rdsurvey


############ Slide 5
## build unmarked frame 
## to find out input format, use ?pcount

mallardUMF <- unmarkedFramePCount(mallard.y, siteCovs = mallard.site,
                                  obsCovs = mallard.obs)
summary(mallardUMF)


############# Slide 7

## run two models, one with and one without covariate X
## check arguments of pcount function with ?pcount

mod0<-pcount(~1~1, mallardUMF, K=30,mixture= "P")
mod.forest <- pcount(~ 1 ~ forest, mallardUMF, K=30)
mod.elevation <- pcount(~ 1 ~ elev, mallardUMF, K=30)
mod.both<-pcount(~ 1 ~ elev+forest, mallardUMF, K=30)

mod0.date<-pcount(~date~1, mallardUMF, K=30,mixture= "P")
mod.forest.date <- pcount(~ date ~ forest, mallardUMF, K=30)
mod.elevation.date <- pcount(~ date ~ elev, mallardUMF, K=30)
mod.both.date<-pcount(~ date ~ elev+forest, mallardUMF, K=30)

## compare models with AIC
fitlist<-fitList(mod0, mod.forest, mod.elevation, mod.both, mod0.date, mod.forest.date,
                 mod.elevation.date, mod.both.date)
modSel(fitlist)


############## Slide 8
##look at estimates of top model

summary(mod.both.date)


######### Slide 9

##get back-transformed estimates of expected abundance at each site
exp.N<-predict(mod.both.date, "state")

##average expected number of mallards
mean(exp.N$Predicted)

##compare that to average observed number of mallards from beginning of lab
mean(mallard.y, na.rm=T)

##back-transformed estimate of detection probability
exp.p<-predict(mod.both.date, "det")













