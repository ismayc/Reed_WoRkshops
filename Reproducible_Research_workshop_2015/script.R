install.packages("devtools")
devtools::install_github("dtkaplan/DCF")
devtools::install_github("dtkaplan/DCFinteractive")

library(DCF)
library(DCFinteractive)
DCFinteractive::mScatter(CountryData)


# This workshop will begin with a discussion on what it means to visualize data in effective ways.
# What kinds of things should you focus on?  What makes a plot good and what makes it bad?  
# We will then discuss many of the ideas from two books on data visualization:  
# Edward Tufte's "Beautiful Evidence" and Leland Wilkinson's "The Grammar of Graphics."  
# Examples of how to perform these ideas in R using the ggplot2 package will be given in 
# addition to the chance for participants to work with these tools during the 
# workshop in RStudio.





# This workshop will begin with a discussion on what it means to visualize data in effective ways.
# What kinds of things should you focus on?  What makes a plot good and what makes it bad?  

# "The simple graph has brought more information to the data analyst's mind
# than any other device." - John Tukey

# "A picture is not merely worth a thousand words, it is much more likely
# to be scrutinized than words are to be read." - John Tukey

# "The greatest value of a picture is when it forces us to notice what we never expected to see."
# - John Tukey

# We will then discuss many of the ideas from two books on data visualization:  
# Edward Tufte’s "Beautiful Evidence" and Leland Wilkinson’s "The Grammar of Graphics."

# Talk about how various plots violate Tufte and GG principles

# Talk about how other plots match with these principles

# Examples of how to perform these ideas in R using the ggplot2 package will be given in 
# addition to the chance for participants to work with these tools during the 
# workshop in RStudio.

# Make predictions before plotting

# Use qplot and then shift to ggplot

# Changes from coloring/size from discrete to continuous

# Play with facet_grid and facet_wrap by showing plots
# Ask how to produce plots by requesting code

# Use ?qplot

# reorder(class, hwy) -> x-axis

# http://docs.ggplot2.org/current/

# Vocabulary + grammar = language

# position = fill

# parameters different than other things
# parameter name = parameter value

# glyph -> Page 53
# Ask them what are the observation units / cases corresponding to each glyph

# Tidy the movies dataset first?

# Show a couple more interactive examples

# Links to more info
## https://github.com/hadley/ggplot2-book

# Let them work through some HW problems