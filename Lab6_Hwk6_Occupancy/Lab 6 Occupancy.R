############# WFCB 198 - Lab 6 Occupancy models

## set working directory to Lab 6
## install and load package unmarked

##?unmarked

################ Slide 5
## read in willow tit data
dat<-read.csv("wtmatrix.csv")
head(dat)

################ Slide 6
## set up observations in site-by-occasion matrix

obs<-dat[,c("y.1","y.2","y.3")]
class(obs)

## has to be a matrix: use as.matrix()
obs<-as.matrix(obs)
class(obs)

## make data frame for site level covariates
## remember: site covariates can be used on occupancy and detection probability

siteCovs<-data.frame(elev=dat[,"elev"], forest=dat[,"forest"],
                     length=dat[,"length"])


## make list with data frame for occasion level covariate
## list structure is necessary because we could have multiple occasion covariates
## In this case we only have one but still need to set up the list structure
## name of the list element has to correspond to column names in data frame
## Remember: occasion covariates can only be used on detection probability

obsCovs<-list(day=dat[,c("day.1","day.2","day.3")])


##NOTE: even though we have 3 columns, they all refer to a single covariate
##because the value of that covariate changes with occasion

## combine everything into unmarkedFrameOccu
umf<-unmarkedFrameOccu(y=obs, siteCovs=siteCovs, obsCovs=obsCovs)
summary(umf)
           
            
######### Slide 7

##number of sites (rows), number of occasions (columns)
dim(obs)

##range of site covariates
range(siteCovs$elev); range(siteCovs$forest) 

##range of occasion covariate
range(obsCovs$day, na.rm=T)


####### Slide 8
##calcualate total number of times species was detected at each site
## missing data (some sites had no 3rd visit) - we need to specify what to do with NAs
obs.tot<-apply(obs, 1, sum, na.rm=T)
range(obs.tot)

detected<-which(obs.tot>0)
#provides index of sites where species was detected at least once

n.detected<-length(detected)
#length of that vector corresponds to number of sites at which species was detected at least oncec

##raw occupancy
J<-dim(obs)[1] ##number of sites
#or
J <- nrow(obs)
raw.occ<-n.detected/J


###### Slide 9
## use ?occu to determine arguments of the function to run occupancy model
## we only need to specify formula and data

##model without covariates

##two-part formula: first part is for detection component, second part is for occupancy component
mod0<-occu(~1~1, umf)
summary(mod0)



########## Slide 11

plogis(-0.665) ##occupancy probability
plogis(1.32)  ##detection probability

##get back-transformed estimates of occupancy with SE, CI 
backTransform(mod0, "state")

##get backtransformed estimate of detection with SE, CI

backTransform(mod0,"det")

##function only works for no-covariate models


###### Slide 12

##model with occu~elevation and p~length

mod.elev.L<-occu(~length ~elev, umf)
summary(mod.elev.L)



###### Slide 15
##plotting covariate relationships

##get expected occupancy probability for a range of elevations using predict
## In the unmarked package, predict() automatically back-transforms
## Note: if you don't specify new covariate values, the function automatically
##       uses the original covariate values used in the model
## Note: the column name for the new values of elevation has to be the same as the 
##       name used in the model!
## Note: You HAVE TO provide the new covariate data with the argument name "newdata"
##       Otherwise the original covariate values will be used for prediction
## VERY IMPORTANT NOTE: the predict() function may give you an error, depending on the 
##      version of unmarked that you use. If it does not work, see alternative code below.

new.elev<-data.frame(elev=seq(min(dat$elev), max(dat$elev), 10))
pred.psi<-predict(mod.elev.L, newdata=new.elev, "state")

## Plot predicted occupancy against new values for elevation

plot(new.elev$elev, pred.psi$Predicted, type="l", 
     xlab="Elevation", ylab="Occupancy probability", ylim=c(0,1))

##add confidence intervals
##lty stands for line type, 2 codes a dashed line
points(new.elev$elev,pred.psi$lower, type="l", lty=2, col="blue")
points(new.elev$elev,pred.psi$upper, type="l", lty=2, col="blue")


##### ALTERNATIVE CODE TO MAKE THIS PLOT IF predict() DOES NOT WORK

##values are paramter estimates from best model
logitpsi<--3.3813+ 0.0025*new.elev$elev
psi<-plogis(logitpsi)

plot(new.elev$elev, psi, type="l", 
     xlab="Elevation", ylab="Occupancy probability", ylim=c(0,1))

##no confidencen intervals for this alternative version of the code

#####################################################################

##get expected detection probability for a range of possible values for length

##set up new values for length
new.length<-data.frame(length=seq(min(dat$length) ,max(dat$length), 0.1))
pred.p<-predict(mod.elev.L, newdata=new.length, "det")

##plot predicted p against new values of length
plot(new.length$length, pred.p$Predicted, type="l", 
     xlab="Route length", ylab="Detection probability", ylim=c(0,1))

##add confidence intervals
points(new.length$length,pred.p$lower, type="l", lty=2, col="blue")
points(new.length$length,pred.p$upper, type="l", lty=2, col="blue")

##### ALTERNATIVE CODE TO MAKE THIS PLOT IF predict() DOES NOT WORK

##values are paramter estimates from best model
logitp<--1.71+ 0.51*new.length$length
p<-plogis(logitp)

plot(new.length$length, p, type="l", 
     xlab="Route length", ylab="Detection probability", ylim=c(0,1))

##no confidencen intervals for this alternative version of the code

#####################################################################


###### Slide 16

## run a set of models with different covariates on detection; 
## keep forest and elev as covariates on occupancy for all models
mod.E.F.0<-occu(~1 ~elev+forest, umf)
mod.E.F.Length<-occu(~length ~elev+forest, umf)
mod.E.F.Day<-occu(~day ~elev+forest, umf)
mod.E.F.Length.Day<-occu(~length+day ~elev+forest, umf)

##collect in fitList
detList<-fitList(mod.E.F.0, mod.E.F.Length, mod.E.F.Day, mod.E.F.Length.Day)

##do AIC model selection
modSel(detList) 
##top 3 models are similarly good at explaining our data with as few parametres as possible

##look at output for model with length and day as detection covariates
summary(mod.E.F.Length.Day)






