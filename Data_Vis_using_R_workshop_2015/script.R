install.packages("devtools")
devtools::install_github("dtkaplan/DCF")
devtools::install_github("dtkaplan/DCFinteractive")

library(DCF)
library(DCFinteractive)
DCFinteractive::mScatter(CountryData)

# Use DCFinteractive for data visualization, look into Networks pages 99-101

# Focus on not hard coding, frequently compiling, and saving

# Page 39 of Data Computing for Rmd