install.packages("devtools")
devtools::install_github("dtkaplan/DCF")
devtools::install_github("dtkaplan/DCFinteractive")

library(DCF)
library(DCFinteractive)
DCFinteractive::mScatter(CountryData)



# Use DCFinteractive for data visualization, look into Networks pages 99-101

# Focus on not hard coding, frequently compiling, and saving

# Page 39 for Rmd


"http://reed.edu/data-at-reed/software/R/workshops/2015/weather.RDS"
"http://reed.edu/data-at-reed/software/R/workshops/2015/flights.RDS"

# This is the case with e.g. qplot, but note the data = . argument. 
# This tells %>% to place the left-hand side there, and not as the first argument. 
babynames %>% filter(name == "Chester") %>% qplot(x = year, y = n, data = .)