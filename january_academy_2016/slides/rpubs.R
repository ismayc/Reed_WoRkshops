if(!require(markdown))
  install.packages("markdown", repos = "https://cran.rstudio.com")
library(markdown)

#result <- markdown::rpubsUpload(title = "Data Viz - January Academy 2016", 
# htmlFile = "january_academy_2016/slides/slides.html")
result2 <- markdown::rpubsUpload(title = "Data Viz - January Academy 2016", 
  htmlFile = "january_academy_2016/slides/slides.html",
  id = result$id)
if (!is.null(result2$continueUrl)) 
  browseURL(result2$continueUrl) else stop(result2$error)