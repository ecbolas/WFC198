###BOLAS_HWK1

###Task1 calculations###
#a
54^2
#b
5*(4-2)


###Task2 make variables###
#a
x <- 54^2
y <- 5*(4-2)
#b
z <- x>=y
#c
class(z)


###Task3 make vectors###
#a
numbers <- c(5:10)
#b
length(numbers)
#c
numbers2 <- c(3:8)
numbers - numbers2
#d
sum(numbers)


###Task4 character vectors###
#a
friends <- c("Jack", "Matt","Deb", "Maren")
#b Select only the first element of that vector and assign it to a variable 'nam' (use subsetting to select the first element)
nam <- friends[1]
#c
class(nam)
#d Select the second and fourth element of 'friends' 
friends[c(2,4)]

#Task5 matrices###
#a
mat <- matrix(data = c(2,1,1,5,3,9,0,4,2,6,6,8), nrow = 3, ncol = 4)
#b
dim(mat) #[1] 3 4
#c make names of rows
rownames(mat) <- c("R1", "R2", "R3")
#d make names of columns
colnames(mat) <- c("C1", "C2", "C3", "C4")
mat
#e Calculate the sum of the second row of mat
sum(mat[2,]) #2,1 means select second row
#f	Calculate the mean of the third column of 'mat'
mean(mat[,3])


###Task6 add to matrix###
#a make a new row
Rnew <- c(2,3,2,3)
mat2 <- rbind(mat, Rnew)
mat2
#b make a new column
Cnew <- c(4,5,4,5)
mat3 <- cbind(mat2, Cnew)
mat3


###Task7 dataframe###
#a
dfr <- read.csv("Homework1.csv")
#b
head(dfr)
#c extract column names
colnames(dfr)
#d types of variables in dfr columns
class(dfr$Individual) #integer
class(dfr$Length) #numeric
class(dfr$Height.cm) #numeric
class(dfr$Sex) #factor
#e Create a new object, 'Height', and assign it the column from 'dfr' that is called 'Height.cm' 
Height <- dfr$Height.cm
Height
#f	Extract the third element of the column from 'dfr' that is called 'Length' 
dfr$Length


###Task8 List###
#a Create a list object that contains (in this order) the data frame from Task 7, the matrix from Task 5, and the character vector from Task 4; call the object 'lst'.
lst <- list(dataframe = dfr, matrix = mat, cvector = friends)
#b	Add the numerical variable x from Task 2 to that list (the new list should also be called 'lst')
lst <- c(lst, x)
lst
#c	Determine the type and dimensions of all elements in the list with a single R command
str(lst)
#d	Using list sub-setting, select the third element of 'lst'
lst[[3]]
#e	Calculate the sum of the second element of 'lst'
sum(lst[[2]])
sum(mat) #it's correct
