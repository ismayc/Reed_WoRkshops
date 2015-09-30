install.packages("devtools")
devtools::install_github("dtkaplan/DCF")
devtools::install_github("dtkaplan/DCFinteractive")

library(DCF)
library(DCFinteractive)
DCFinteractive::mScatter(CountryData)