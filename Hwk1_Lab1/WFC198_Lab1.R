#WFC198_Lab1

#Data Types

#VECTORS
#adding vectors of equal length
v1 <- c(4,5,10,3) #creating a numerical vector
v2 <- c(12,5,5,1)
v1 + v2
v3 <- v1 + v2

#adding vectors of unequal length
v1 <- c(4,5,10,3)
v2 <- c(12,5,5,1,6)
v1 + v2

#by default, arithmetic operators apply to each element of a vector
sum(v1) #adds all the elements of the vector tog.
min(v1)
max(v1)
length(v2)
v1 > 3 #tells you if this is true for each element in the vector

v1_comp <- v1 > 3
v1[v1_comp] #gives you only the elements of v1 that are greater than 3
v1[v1>3] #gives you the same thing

#FACTORS
#factors are used for categorical data, elements fall into different levels. Factor data examples: sex, species, habitat type. R often assumes data as factors

#make a character vector
spec <- c("elephant", "giraffe", "giraffe", "mouse", "mouse", "mouse")
class(spec)

#convert character to factor
spec_factor <- factor(spec)
spec_factor #changes the order and tells you the three levels of the factor
levels(spec_factor)

y <- c("cat", "fish", "maggot")
#name elements of the vector
names(y) <- c("favorite animal", "average animal", "least favorite animal")
y

animal <- c("skunk", "fox", "pig")
names(animal) <- c("favorite animal", "average animal", "least favorite animal")
animal
animal[1]

#c(1,2) = 1:2

#MATRICES
#2-D arrays, vectors stacked on each other

mat <- matrix(data = 1:12, nrow = 3, ncol = 4, byrow = FALSE, dimnames = NULL) #byrow = false means it fills in the numbers into columns first
mat
rownames(mat) <- c("R1", "R2", "R3")
colnames(mat) <- c("C1", "C2", "C3", "C4")
mat
mat[1,1] #returns first row first column
mat[1,] #returns all of the first row
mat[,2] #returns all of column 2
mat["R1",] #also returns all the first row
C5<- c(4,2,8) #make another vector to add on to matrix, make sure it has the same dimensions
mat3 <- cbind(mat, C5) #adds that vector as another column at the end
mat3

R4 <- c(7,5,0,1)
mat4 <- rbind(mat, R4)
mat4
dim(mat4)

#dataframes
#like matrices, BUT, they can hold several types of data at once
vn <- 1:3 #numeric vector
vb <- c(TRUE, FALSE, TRUE) #boolean vector
vc <- c("river", "lake", "lagoon") #character vector

dfm <- data.frame(Numerical = vn, Boolean = vb, Character = vc) #created column names for the vectors 
dfm
dfm$Numerical #can only use "$" for df, brings everything in that column up
dfm$Character #this was actually read in as a factor bc it has levels
dfm$Character <- as.character(vc)
class(dfm$Character)

dfm2 <- read.csv("WFC198/Lab1/Matrix1.csv")
dfm2
class(dfm2)
colnames(dfm2)

dfm3 <- read.table("WFC198/Lab1/Matrix2.txt", header = TRUE, sep = "") #in txt files you have to specify these things
dfm3

#Lists
#a list let's you gather a variety of objects under one name. access elements objects within the list using [[]]
#used in forloops and by some computer programs instead of dataframes

lst <- list(animalvec = animal, matrix = mat, dataframe = dfm)
lst
lst[[1]] #returns animals
lst$dataframe
str(lst)

vv <- 5
lst2 <- c(lst, vv)
lst2 #just adds the fourth element, which we didn't give a name to
