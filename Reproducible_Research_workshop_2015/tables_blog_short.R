#+ setup, warning = FALSE, message = FALSE
# List of packages required for this analysis
pkg <- c("dplyr", "knitr", "devtools", "DT", "xtable")
# Check if packages are not installed and assign the
# names of the packages not installed to the variable new.pkg
new.pkg <- pkg[!(pkg %in% installed.packages())]
# If there are any packages in the list that aren't installed,
# install them
if (length(new.pkg)) {
  install.packages(new.pkg, repos = "http://cran.rstudio.com")
}
# Load the packages into R
library(dplyr)
library(knitr)
library(DT)
library(xtable)
# Install Chester's pnwflights14 package (if not already)
if (!require(pnwflights14)){
  library(devtools)
  devtools::install_github("ismayc/pnwflights14")
  }
library(pnwflights14)
# Load the flights dataset
data("flights", package = "pnwflights14")
#'

#+ worst_arr_delays
worst_arr_delays <- flights %>% group_by(dest) %>%
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(mean_arr_delay)) %>%
  top_n(n = 5, wt = mean_arr_delay)
#'

#+ join
data("airports", package = "pnwflights14")
joined_worst <- inner_join(worst_arr_delays, airports, by = c("dest" = "faa")) %>%
  select(name, dest, mean_arr_delay) %>%
  rename("Airport Name" = name, "Airport Code" = dest, "Mean Arrival Delay" = mean_arr_delay)
#'

#+ kable
kable(joined_worst)
#'

#+ get_by_month
dep_delays_by_month <- flights %>% group_by(origin, month) %>%
summarize(max_delay = max(dep_delay, na.rm = TRUE))
#'

#+ DT, results = "hide"
datatable(dep_delays_by_month,
          filter = 'top', options = list(
            pageLength = 12, autoWidth = TRUE
          ))
#'