#WFC198_Lab2

###getting started
x <- 1:10
save.image("test.rdata") #saves the data, then will load the actual data into your environment
load("test.rdata")
ls() #tells you all the object names in your environment

#4d <- 2 #trying to make a new variable, but you can't start it with a number

a <- 24; b <- 33 #semicolon let's you assign two things at once

###sequence and repeat
seq1 <- seq(1,10) #run a sequence 1:10
seq2 <- seq(1,10,0.5) #run it by every .5

rep1 <- rep(a,5) #repeat variable a five times
rep1

#can combine the functions
rep2 <- rep(seq2, 2)

sort(rep2) #sorts numbers in increasing order
sort(rep2, decreasing = TRUE)


###examples with missing data (NAs) NAs don't change the class of the vector
weight <- c(NA, 86, 94, NA, 79)
class(weight)

animal <- c("frog", "cat", NA, "fish")
class(animal)

###playing with data/df
dat <- read.csv("DataLab2.csv")
head(dat)

#average weight and NAs
mean(dat$weight) #or mean(dat[,"weight"])
mean(dat$weight, na.rm = TRUE) #takes the average with NAs removed
is.na(dat$weight) #tells you which entries are NAs
which(is.na(dat$weight)) #tells you speicifically which elements are missing data

#new df that excludes the two missing rows
missing <- which(is.na(dat$weight)) #you can select any column here, creates an object with the rows that are missing

dat2 <- dat[-missing,] #means subset everything except for the missing object, MAKE SURE THAT COMMA IS THERE so it knows, "cut these rows"
which(is.na(dat2))
dat2

###Visualizing data
#plot
plot(dat2$size, dat2$weight, xlab = "Size", ylab = "Weight") #x vs y
#use points() to add more data to an existing plot, i.e., a mean
points( x = mean(dat2$size), y = mean(dat2$weight), col = "red", pch = 19) #set color and symbol type

#add lines
abline(h=mean(dat2$weight)) #h means add horizontal line
abline(v=mean(dat2$size))

#histograms: y has frequency (amount of data), x has values
hist(dat2$size, xlab = "Size", main = "Histogram of Size")

###For-Loops
#automatically apply the same opperations to a set of values

#some of this is already built in
y <- c(5,3,8)
y + 3 #repeats the addition of 3 to each part of the vector


#simple for-loop
x <- 3
result <- NULL #this makes an empty placeholder object to hold the results

for (i in 1:x){#for each element in 1 to x, you want to do some function
 result[i] <- y[i] + 3 #for each i(element) in y, add 3, assign the results to the result object
  
} 

result



#going to do something to weight
newweight <- NULL
dim(dat2) #tells you there are 18 rows

for(i in 1:18){ #remember i refers to each element in the list
  newweight[i] <- dat2$weight[i] - mean(dat2$weight) #took original weight, subtracted the mean from each to get the new value
}
newweight



#something with averages

above.av <- NULL

for(i in 1:18){
  above.av[i] <- dat2$weight[i] > mean(dat2$weight)
} #is the actual weight greater than the average?

above.av


###For-Loop for simple population model with age structure
#N.adult(t +1) = N.adult(t)Sa + N.juv(t)Sj

Sj <- 0.5 #survival rate for juvies
Sa <- 0.8 #adult survival
b <- 0.5 #repro/birth rate
tsp <- 50 #means we will look at 50 time steps
N.adult <- rep(NA,tsp) #we need a placeholder that is empty for all time steps
N.adult[1] <- 50 #means 50 adults at the first time step
N.adult
N.juv <- rep(NA, tsp)
N.juv[1] <- 30 #30 juvies at time step 1
N.total <- N.adult + N.juv #total population, have to do this out here to get info for the first time step
age.ratio <- N.juv/N.adult

#need for-loop to start at time 2 bc we already have time 1
#i is the index for different time steps

for(i in 2:tsp){
  N.adult[i] <- N.juv[i-1] * Sj + N.adult[i-1]*Sa #for each timte step, N.adult is takes all surviving juvies from pervious time step added to all the previous steps adults that survive
  N.juv[i] <- N.adult[i]*b #numb juvies is how many adults there are that reproduce
  N.total[i] <- N.adult[i] + N.juv[i]
  age.ratio[i] <- N.juv[i]/N.adult[i]
}
N.adult #now we have pop. sizes
N.juv
N.total
age.ratio

time.index <- 1:tsp
plot(time.index, N.total, xlab = "time", ylab = "pop", type = "l")
