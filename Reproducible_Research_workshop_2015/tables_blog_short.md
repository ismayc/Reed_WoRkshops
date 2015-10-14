


List of packages required for this analysis


```r
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
```

```r
worst_arr_delays <- flights %>% group_by(dest) %>%
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(mean_arr_delay)) %>%
  top_n(n = 5, wt = mean_arr_delay)
```

```r
data("airports", package = "pnwflights14")
joined_worst <- inner_join(worst_arr_delays, airports, by = c("dest" = "faa")) %>%
  select(name, dest, mean_arr_delay) %>%
  rename("Airport Name" = name, "Airport Code" = dest, "Mean Arrival Delay" = mean_arr_delay)
```

```r
kable(joined_worst)
```



|Airport Name              |Airport Code | Mean Arrival Delay|
|:-------------------------|:------------|------------------:|
|Cleveland Hopkins Intl    |CLE          |          26.150000|
|William P Hobby           |HOU          |          10.250000|
|Metropolitan Oakland Intl |OAK          |          10.067460|
|San Francisco Intl        |SFO          |           8.864937|
|Bellingham Intl           |BLI          |           8.673913|

```r
dep_delays_by_month <- flights %>% group_by(origin, month) %>%
summarize(max_delay = max(dep_delay, na.rm = TRUE))
```

```r
datatable(dep_delays_by_month,
          filter = 'top', options = list(
            pageLength = 12, autoWidth = TRUE
          ))
```

```r
data("airlines", package = "pnwflights14")
by_airline <- flights %>% group_by(origin, carrier) %>%
  summarize(count = n()) %>%
  inner_join(x = ., y = airlines, by = "carrier") %>%
  arrange(desc(count))
```

```r
print(xtable(by_airline),
      comment = FALSE)
```

\begin{table}[ht]
\centering
\begin{tabular}{rllrl}
  \hline
 & origin & carrier & count & name \\ 
  \hline
1 & PDX & AS & 12844 & Alaska Airlines Inc. \\ 
  2 & PDX & WN & 11193 & Southwest Airlines Co. \\ 
  3 & PDX & OO & 9841 & SkyWest Airlines Inc. \\ 
  4 & PDX & UA & 6061 & United Air Lines Inc. \\ 
  5 & PDX & DL & 5168 & Delta Air Lines Inc. \\ 
  6 & PDX & US & 2361 & US Airways Inc. \\ 
  7 & PDX & AA & 2187 & American Airlines Inc. \\ 
  8 & PDX & F9 & 1362 & Frontier Airlines Inc. \\ 
  9 & PDX & B6 & 1287 & JetBlue Airways \\ 
  10 & PDX & VX & 666 & Virgin America \\ 
  11 & PDX & HA & 365 & Hawaiian Airlines Inc. \\ 
  12 & SEA & AS & 49616 & Alaska Airlines Inc. \\ 
  13 & SEA & WN & 12162 & Southwest Airlines Co. \\ 
  14 & SEA & DL & 11548 & Delta Air Lines Inc. \\ 
  15 & SEA & UA & 10610 & United Air Lines Inc. \\ 
  16 & SEA & OO & 8869 & SkyWest Airlines Inc. \\ 
  17 & SEA & AA & 5399 & American Airlines Inc. \\ 
  18 & SEA & US & 3585 & US Airways Inc. \\ 
  19 & SEA & VX & 2606 & Virgin America \\ 
  20 & SEA & B6 & 2253 & JetBlue Airways \\ 
  21 & SEA & F9 & 1336 & Frontier Airlines Inc. \\ 
  22 & SEA & HA & 730 & Hawaiian Airlines Inc. \\ 
   \hline
\end{tabular}
\end{table}

```r
kable(by_airline)
```



|origin |carrier | count|name                   |
|:------|:-------|-----:|:----------------------|
|PDX    |AS      | 12844|Alaska Airlines Inc.   |
|PDX    |WN      | 11193|Southwest Airlines Co. |
|PDX    |OO      |  9841|SkyWest Airlines Inc.  |
|PDX    |UA      |  6061|United Air Lines Inc.  |
|PDX    |DL      |  5168|Delta Air Lines Inc.   |
|PDX    |US      |  2361|US Airways Inc.        |
|PDX    |AA      |  2187|American Airlines Inc. |
|PDX    |F9      |  1362|Frontier Airlines Inc. |
|PDX    |B6      |  1287|JetBlue Airways        |
|PDX    |VX      |   666|Virgin America         |
|PDX    |HA      |   365|Hawaiian Airlines Inc. |
|SEA    |AS      | 49616|Alaska Airlines Inc.   |
|SEA    |WN      | 12162|Southwest Airlines Co. |
|SEA    |DL      | 11548|Delta Air Lines Inc.   |
|SEA    |UA      | 10610|United Air Lines Inc.  |
|SEA    |OO      |  8869|SkyWest Airlines Inc.  |
|SEA    |AA      |  5399|American Airlines Inc. |
|SEA    |US      |  3585|US Airways Inc.        |
|SEA    |VX      |  2606|Virgin America         |
|SEA    |B6      |  2253|JetBlue Airways        |
|SEA    |F9      |  1336|Frontier Airlines Inc. |
|SEA    |HA      |   730|Hawaiian Airlines Inc. |

