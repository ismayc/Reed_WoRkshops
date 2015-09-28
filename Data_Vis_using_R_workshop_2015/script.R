install.packages("devtools")
devtools::install_github("dtkaplan/DCF")
devtools::install_github("dtkaplan/DCFinteractive")

library(DCF)
library(DCFinteractive)
DCFinteractive::mScatter(CountryData)


# This workshop will begin with a discussion on what it means to visualize data in effective ways.
# What kinds of things should you focus on?  What makes a plot good and what makes it bad?  
# We will then discuss many of the ideas from two books on data visualization:  
# Edward Tufte’s "Beautiful Evidence" and Leland Wilkinson’s "The Grammar of Graphics."  
# Examples of how to perform these ideas in R using the ggplot2 package will be given in 
# addition to the chance for participants to work with these tools during the 
# workshop in RStudio.

# Use DCFinteractive for data visualization, look into Networks pages 99-101

# Focus on not hard coding, frequently compiling, and saving

# Page 39 of Data Computing for Rmd

# "The simple graph has brought more information to the data analyst's mind
# than any other device." - John Tukey

# "A picture is not merely worth a thousand words, it is much more likely
# to be scrutinized than words are to be read." - John Tukey

# "The greatest value of a picture is when it forces us to notice what we never expected to see."
# - John Tukey

# Make predictions before plotting

# Use qplot and then shift to ggplot

# Changes from coloring/size from discrete to continuous

# Play with facet_grid and facet_wrap by showing plots
# Ask how to produce plots by requesting code

# Use ?qplot

