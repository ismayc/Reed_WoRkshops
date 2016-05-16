# Interactive Data Visualization
<br> Chester Ismay (cismay@reed.edu) <br>  
Paideia 2k16 <br><br> Slides available at <http://rpubs.com/cismay/paideia_2k16_idv> <br> Supplementary HTML file at <http://rpubs.com/cismay/paideia_2k16_idv_sup>  

When we think about data visualization, we often think of a static plot with some colors and points.  New tools (spearheaded by Hans Rosling's Gapminder project) are constantly being developed to allow us to interact dynamically with data visualizations.  I'll discuss a variety of different tools that attempt to make data come to life!

All too often statistics is thought of as a boring subject with boring plots.  New software packages and tools are being developed to better understand the relationships between variables.  I'll demonstrate a lot of these different tools and packages using the R computing language.  We'll go through a variety of different examples from multiple fields to better understand anomalies and trends in data.




```r
pkg <- c("dplyr", "ggplot2", "knitr", "readr", 
         "xts", "maps", "googleVis", "DT", "rmarkdown")

new.pkg <- pkg[!(pkg %in% installed.packages())]

if (length(new.pkg)) {
  install.packages(new.pkg, repos = "http://cran.rstudio.com")
}

if(!require(revealjs)){
  devtools::install_github("jjallaire/revealjs", ref = "a4854c017eac44d969a216103551c21d66329a74")
}

if(!require(plotly)){
  devtools::install_github("ropensci/plotly")
}

if(!require(pnwflights14)){
  devtools::install_github("ismayc/pnwflights14")
}

if(!require(dygraphs)){
  devtools::install_github("rstudio/dygraphs", ref = "778acdaeb91b754412d928ea824632bceae3078b")
}

library(dplyr)
library(ggplot2)
library(revealjs)
library(knitr)
library(readr)
library(plotly)
library(dygraphs)
library(pnwflights14)
library(xts)
library(maps)
library(googleVis)
library(DT)

options(width = 100, scipen = 99)
```

### The __Iris__ flower data set

- Introduced by Ronald Fisher in 1936

- The data set consists of 50 samples from each of three species of Iris (_Iris setosa_, _Iris virginica_, and _Iris versicolor_). 

- Four features were measured from each sample: the length and the width of the sepals and petals, in centimetres. Based on the combination of these four features, Fisher developed a model to distinguish the species from each other.

Source: [Wikipedia](https://en.wikipedia.org/wiki/Iris_flower_data_set)

---

# Scatterplots

---

## Traditional (boring) plot


```r
with(iris, plot(x = Petal.Width, y = Sepal.Length))
```

![](slides_to_html_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

---

## Prettier (not quite as boring) plot


```r
qplot(Petal.Width, Sepal.Length, data = iris)
```

![](slides_to_html_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

---

## Interactive plot using `plotly`


```r
ggiris <- qplot(Petal.Width, Sepal.Length, data = iris)
ggplotly(ggiris)
```

<!--html_preserve--><div id="htmlwidget-4045" style="width:912px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-4045">{"x":{"data":[{"x":[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2,1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3,2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],"y":[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5,7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7,6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],"text":["Petal.Width: 0.2<br>Sepal.Length: 5.1","Petal.Width: 0.2<br>Sepal.Length: 4.9","Petal.Width: 0.2<br>Sepal.Length: 4.7","Petal.Width: 0.2<br>Sepal.Length: 4.6","Petal.Width: 0.2<br>Sepal.Length: 5","Petal.Width: 0.4<br>Sepal.Length: 5.4","Petal.Width: 0.3<br>Sepal.Length: 4.6","Petal.Width: 0.2<br>Sepal.Length: 5","Petal.Width: 0.2<br>Sepal.Length: 4.4","Petal.Width: 0.1<br>Sepal.Length: 4.9","Petal.Width: 0.2<br>Sepal.Length: 5.4","Petal.Width: 0.2<br>Sepal.Length: 4.8","Petal.Width: 0.1<br>Sepal.Length: 4.8","Petal.Width: 0.1<br>Sepal.Length: 4.3","Petal.Width: 0.2<br>Sepal.Length: 5.8","Petal.Width: 0.4<br>Sepal.Length: 5.7","Petal.Width: 0.4<br>Sepal.Length: 5.4","Petal.Width: 0.3<br>Sepal.Length: 5.1","Petal.Width: 0.3<br>Sepal.Length: 5.7","Petal.Width: 0.3<br>Sepal.Length: 5.1","Petal.Width: 0.2<br>Sepal.Length: 5.4","Petal.Width: 0.4<br>Sepal.Length: 5.1","Petal.Width: 0.2<br>Sepal.Length: 4.6","Petal.Width: 0.5<br>Sepal.Length: 5.1","Petal.Width: 0.2<br>Sepal.Length: 4.8","Petal.Width: 0.2<br>Sepal.Length: 5","Petal.Width: 0.4<br>Sepal.Length: 5","Petal.Width: 0.2<br>Sepal.Length: 5.2","Petal.Width: 0.2<br>Sepal.Length: 5.2","Petal.Width: 0.2<br>Sepal.Length: 4.7","Petal.Width: 0.2<br>Sepal.Length: 4.8","Petal.Width: 0.4<br>Sepal.Length: 5.4","Petal.Width: 0.1<br>Sepal.Length: 5.2","Petal.Width: 0.2<br>Sepal.Length: 5.5","Petal.Width: 0.2<br>Sepal.Length: 4.9","Petal.Width: 0.2<br>Sepal.Length: 5","Petal.Width: 0.2<br>Sepal.Length: 5.5","Petal.Width: 0.1<br>Sepal.Length: 4.9","Petal.Width: 0.2<br>Sepal.Length: 4.4","Petal.Width: 0.2<br>Sepal.Length: 5.1","Petal.Width: 0.3<br>Sepal.Length: 5","Petal.Width: 0.3<br>Sepal.Length: 4.5","Petal.Width: 0.2<br>Sepal.Length: 4.4","Petal.Width: 0.6<br>Sepal.Length: 5","Petal.Width: 0.4<br>Sepal.Length: 5.1","Petal.Width: 0.3<br>Sepal.Length: 4.8","Petal.Width: 0.2<br>Sepal.Length: 5.1","Petal.Width: 0.2<br>Sepal.Length: 4.6","Petal.Width: 0.2<br>Sepal.Length: 5.3","Petal.Width: 0.2<br>Sepal.Length: 5","Petal.Width: 1.4<br>Sepal.Length: 7","Petal.Width: 1.5<br>Sepal.Length: 6.4","Petal.Width: 1.5<br>Sepal.Length: 6.9","Petal.Width: 1.3<br>Sepal.Length: 5.5","Petal.Width: 1.5<br>Sepal.Length: 6.5","Petal.Width: 1.3<br>Sepal.Length: 5.7","Petal.Width: 1.6<br>Sepal.Length: 6.3","Petal.Width: 1<br>Sepal.Length: 4.9","Petal.Width: 1.3<br>Sepal.Length: 6.6","Petal.Width: 1.4<br>Sepal.Length: 5.2","Petal.Width: 1<br>Sepal.Length: 5","Petal.Width: 1.5<br>Sepal.Length: 5.9","Petal.Width: 1<br>Sepal.Length: 6","Petal.Width: 1.4<br>Sepal.Length: 6.1","Petal.Width: 1.3<br>Sepal.Length: 5.6","Petal.Width: 1.4<br>Sepal.Length: 6.7","Petal.Width: 1.5<br>Sepal.Length: 5.6","Petal.Width: 1<br>Sepal.Length: 5.8","Petal.Width: 1.5<br>Sepal.Length: 6.2","Petal.Width: 1.1<br>Sepal.Length: 5.6","Petal.Width: 1.8<br>Sepal.Length: 5.9","Petal.Width: 1.3<br>Sepal.Length: 6.1","Petal.Width: 1.5<br>Sepal.Length: 6.3","Petal.Width: 1.2<br>Sepal.Length: 6.1","Petal.Width: 1.3<br>Sepal.Length: 6.4","Petal.Width: 1.4<br>Sepal.Length: 6.6","Petal.Width: 1.4<br>Sepal.Length: 6.8","Petal.Width: 1.7<br>Sepal.Length: 6.7","Petal.Width: 1.5<br>Sepal.Length: 6","Petal.Width: 1<br>Sepal.Length: 5.7","Petal.Width: 1.1<br>Sepal.Length: 5.5","Petal.Width: 1<br>Sepal.Length: 5.5","Petal.Width: 1.2<br>Sepal.Length: 5.8","Petal.Width: 1.6<br>Sepal.Length: 6","Petal.Width: 1.5<br>Sepal.Length: 5.4","Petal.Width: 1.6<br>Sepal.Length: 6","Petal.Width: 1.5<br>Sepal.Length: 6.7","Petal.Width: 1.3<br>Sepal.Length: 6.3","Petal.Width: 1.3<br>Sepal.Length: 5.6","Petal.Width: 1.3<br>Sepal.Length: 5.5","Petal.Width: 1.2<br>Sepal.Length: 5.5","Petal.Width: 1.4<br>Sepal.Length: 6.1","Petal.Width: 1.2<br>Sepal.Length: 5.8","Petal.Width: 1<br>Sepal.Length: 5","Petal.Width: 1.3<br>Sepal.Length: 5.6","Petal.Width: 1.2<br>Sepal.Length: 5.7","Petal.Width: 1.3<br>Sepal.Length: 5.7","Petal.Width: 1.3<br>Sepal.Length: 6.2","Petal.Width: 1.1<br>Sepal.Length: 5.1","Petal.Width: 1.3<br>Sepal.Length: 5.7","Petal.Width: 2.5<br>Sepal.Length: 6.3","Petal.Width: 1.9<br>Sepal.Length: 5.8","Petal.Width: 2.1<br>Sepal.Length: 7.1","Petal.Width: 1.8<br>Sepal.Length: 6.3","Petal.Width: 2.2<br>Sepal.Length: 6.5","Petal.Width: 2.1<br>Sepal.Length: 7.6","Petal.Width: 1.7<br>Sepal.Length: 4.9","Petal.Width: 1.8<br>Sepal.Length: 7.3","Petal.Width: 1.8<br>Sepal.Length: 6.7","Petal.Width: 2.5<br>Sepal.Length: 7.2","Petal.Width: 2<br>Sepal.Length: 6.5","Petal.Width: 1.9<br>Sepal.Length: 6.4","Petal.Width: 2.1<br>Sepal.Length: 6.8","Petal.Width: 2<br>Sepal.Length: 5.7","Petal.Width: 2.4<br>Sepal.Length: 5.8","Petal.Width: 2.3<br>Sepal.Length: 6.4","Petal.Width: 1.8<br>Sepal.Length: 6.5","Petal.Width: 2.2<br>Sepal.Length: 7.7","Petal.Width: 2.3<br>Sepal.Length: 7.7","Petal.Width: 1.5<br>Sepal.Length: 6","Petal.Width: 2.3<br>Sepal.Length: 6.9","Petal.Width: 2<br>Sepal.Length: 5.6","Petal.Width: 2<br>Sepal.Length: 7.7","Petal.Width: 1.8<br>Sepal.Length: 6.3","Petal.Width: 2.1<br>Sepal.Length: 6.7","Petal.Width: 1.8<br>Sepal.Length: 7.2","Petal.Width: 1.8<br>Sepal.Length: 6.2","Petal.Width: 1.8<br>Sepal.Length: 6.1","Petal.Width: 2.1<br>Sepal.Length: 6.4","Petal.Width: 1.6<br>Sepal.Length: 7.2","Petal.Width: 1.9<br>Sepal.Length: 7.4","Petal.Width: 2<br>Sepal.Length: 7.9","Petal.Width: 2.2<br>Sepal.Length: 6.4","Petal.Width: 1.5<br>Sepal.Length: 6.3","Petal.Width: 1.4<br>Sepal.Length: 6.1","Petal.Width: 2.3<br>Sepal.Length: 7.7","Petal.Width: 2.4<br>Sepal.Length: 6.3","Petal.Width: 1.8<br>Sepal.Length: 6.4","Petal.Width: 1.8<br>Sepal.Length: 6","Petal.Width: 2.1<br>Sepal.Length: 6.9","Petal.Width: 2.4<br>Sepal.Length: 6.7","Petal.Width: 2.3<br>Sepal.Length: 6.9","Petal.Width: 1.9<br>Sepal.Length: 5.8","Petal.Width: 2.3<br>Sepal.Length: 6.8","Petal.Width: 2.5<br>Sepal.Length: 6.7","Petal.Width: 2.3<br>Sepal.Length: 6.7","Petal.Width: 1.9<br>Sepal.Length: 6.3","Petal.Width: 2<br>Sepal.Length: 6.5","Petal.Width: 2.3<br>Sepal.Length: 6.2","Petal.Width: 1.8<br>Sepal.Length: 5.9"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgb(0,0,0)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgb(0,0,0)"}},"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","name":""}],"layout":{"margin":{"b":43.8356164383562,"l":31.4155251141553,"t":29.8812785388128,"r":7.30593607305936},"plot_bgcolor":"rgb(235,235,235)","paper_bgcolor":"rgb(255,255,255)","font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[-0.02,2.62],"ticktext":["0.0","0.5","1.0","1.5","2.0","2.5"],"tickvals":[0,0.5,1,1.5,2,2.5],"ticks":"outside","tickcolor":"rgb(51,51,51)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgb(77,77,77)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgb(255,255,255)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","hoverformat":".2f"},"annotations":[{"text":"Petal.Width","x":0.5,"y":-0.082572298325723,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"center","yanchor":"middle"},{"text":"Sepal.Length","x":-0.032243851638228,"y":0.5,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-90,"xanchor":"center","yanchor":"middle"}],"yaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[4.12,8.08],"ticktext":["5","6","7","8"],"tickvals":[5,6,7,8],"ticks":"outside","tickcolor":"rgb(51,51,51)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgb(77,77,77)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgb(255,255,255)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgb(255,255,255)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgb(0,0,0)","family":"","size":11.689497716895}},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

---

## Prettier interactive plot using `plotly`


```r
ggiris_colored <- qplot(Petal.Width, Sepal.Length, data = iris, 
  color = Species)
ggplotly(ggiris_colored)
```

<!--html_preserve--><div id="htmlwidget-1451" style="width:912px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-1451">{"x":{"data":[{"x":[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2],"y":[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5],"text":["Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.9","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.7","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.6","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5.4","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 4.6","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.4","Species: setosa<br>Petal.Width: 0.1<br>Sepal.Length: 4.9","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.4","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.8","Species: setosa<br>Petal.Width: 0.1<br>Sepal.Length: 4.8","Species: setosa<br>Petal.Width: 0.1<br>Sepal.Length: 4.3","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.8","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5.7","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5.4","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 5.7","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.4","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.6","Species: setosa<br>Petal.Width: 0.5<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.8","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.2","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.2","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.7","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.8","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5.4","Species: setosa<br>Petal.Width: 0.1<br>Sepal.Length: 5.2","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.5","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.9","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.5","Species: setosa<br>Petal.Width: 0.1<br>Sepal.Length: 4.9","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.4","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 4.5","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.4","Species: setosa<br>Petal.Width: 0.6<br>Sepal.Length: 5","Species: setosa<br>Petal.Width: 0.4<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.3<br>Sepal.Length: 4.8","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.1","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 4.6","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5.3","Species: setosa<br>Petal.Width: 0.2<br>Sepal.Length: 5"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgb(248,118,109)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgb(248,118,109)"}},"name":"setosa","legendgroup":"setosa","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3],"y":[7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7],"text":["Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 7","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6.4","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6.9","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.5","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6.5","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.7","Species: versicolor<br>Petal.Width: 1.6<br>Sepal.Length: 6.3","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 4.9","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 6.6","Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 5.2","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 5","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 5.9","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 6","Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 6.1","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.6","Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 6.7","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 5.6","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 5.8","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6.2","Species: versicolor<br>Petal.Width: 1.1<br>Sepal.Length: 5.6","Species: versicolor<br>Petal.Width: 1.8<br>Sepal.Length: 5.9","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 6.1","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6.3","Species: versicolor<br>Petal.Width: 1.2<br>Sepal.Length: 6.1","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 6.4","Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 6.6","Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 6.8","Species: versicolor<br>Petal.Width: 1.7<br>Sepal.Length: 6.7","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 5.7","Species: versicolor<br>Petal.Width: 1.1<br>Sepal.Length: 5.5","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 5.5","Species: versicolor<br>Petal.Width: 1.2<br>Sepal.Length: 5.8","Species: versicolor<br>Petal.Width: 1.6<br>Sepal.Length: 6","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 5.4","Species: versicolor<br>Petal.Width: 1.6<br>Sepal.Length: 6","Species: versicolor<br>Petal.Width: 1.5<br>Sepal.Length: 6.7","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 6.3","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.6","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.5","Species: versicolor<br>Petal.Width: 1.2<br>Sepal.Length: 5.5","Species: versicolor<br>Petal.Width: 1.4<br>Sepal.Length: 6.1","Species: versicolor<br>Petal.Width: 1.2<br>Sepal.Length: 5.8","Species: versicolor<br>Petal.Width: 1<br>Sepal.Length: 5","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.6","Species: versicolor<br>Petal.Width: 1.2<br>Sepal.Length: 5.7","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.7","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 6.2","Species: versicolor<br>Petal.Width: 1.1<br>Sepal.Length: 5.1","Species: versicolor<br>Petal.Width: 1.3<br>Sepal.Length: 5.7"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgb(0,186,56)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgb(0,186,56)"}},"name":"versicolor","legendgroup":"versicolor","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],"y":[6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],"text":["Species: virginica<br>Petal.Width: 2.5<br>Sepal.Length: 6.3","Species: virginica<br>Petal.Width: 1.9<br>Sepal.Length: 5.8","Species: virginica<br>Petal.Width: 2.1<br>Sepal.Length: 7.1","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.3","Species: virginica<br>Petal.Width: 2.2<br>Sepal.Length: 6.5","Species: virginica<br>Petal.Width: 2.1<br>Sepal.Length: 7.6","Species: virginica<br>Petal.Width: 1.7<br>Sepal.Length: 4.9","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 7.3","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.7","Species: virginica<br>Petal.Width: 2.5<br>Sepal.Length: 7.2","Species: virginica<br>Petal.Width: 2<br>Sepal.Length: 6.5","Species: virginica<br>Petal.Width: 1.9<br>Sepal.Length: 6.4","Species: virginica<br>Petal.Width: 2.1<br>Sepal.Length: 6.8","Species: virginica<br>Petal.Width: 2<br>Sepal.Length: 5.7","Species: virginica<br>Petal.Width: 2.4<br>Sepal.Length: 5.8","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 6.4","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.5","Species: virginica<br>Petal.Width: 2.2<br>Sepal.Length: 7.7","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 7.7","Species: virginica<br>Petal.Width: 1.5<br>Sepal.Length: 6","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 6.9","Species: virginica<br>Petal.Width: 2<br>Sepal.Length: 5.6","Species: virginica<br>Petal.Width: 2<br>Sepal.Length: 7.7","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.3","Species: virginica<br>Petal.Width: 2.1<br>Sepal.Length: 6.7","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 7.2","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.2","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.1","Species: virginica<br>Petal.Width: 2.1<br>Sepal.Length: 6.4","Species: virginica<br>Petal.Width: 1.6<br>Sepal.Length: 7.2","Species: virginica<br>Petal.Width: 1.9<br>Sepal.Length: 7.4","Species: virginica<br>Petal.Width: 2<br>Sepal.Length: 7.9","Species: virginica<br>Petal.Width: 2.2<br>Sepal.Length: 6.4","Species: virginica<br>Petal.Width: 1.5<br>Sepal.Length: 6.3","Species: virginica<br>Petal.Width: 1.4<br>Sepal.Length: 6.1","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 7.7","Species: virginica<br>Petal.Width: 2.4<br>Sepal.Length: 6.3","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6.4","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 6","Species: virginica<br>Petal.Width: 2.1<br>Sepal.Length: 6.9","Species: virginica<br>Petal.Width: 2.4<br>Sepal.Length: 6.7","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 6.9","Species: virginica<br>Petal.Width: 1.9<br>Sepal.Length: 5.8","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 6.8","Species: virginica<br>Petal.Width: 2.5<br>Sepal.Length: 6.7","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 6.7","Species: virginica<br>Petal.Width: 1.9<br>Sepal.Length: 6.3","Species: virginica<br>Petal.Width: 2<br>Sepal.Length: 6.5","Species: virginica<br>Petal.Width: 2.3<br>Sepal.Length: 6.2","Species: virginica<br>Petal.Width: 1.8<br>Sepal.Length: 5.9"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgb(97,156,255)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgb(97,156,255)"}},"name":"virginica","legendgroup":"virginica","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"}],"layout":{"margin":{"b":43.8356164383562,"l":31.4155251141553,"t":29.8812785388128,"r":7.30593607305936},"plot_bgcolor":"rgb(235,235,235)","paper_bgcolor":"rgb(255,255,255)","font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[-0.02,2.62],"ticktext":["0.0","0.5","1.0","1.5","2.0","2.5"],"tickvals":[0,0.5,1,1.5,2,2.5],"ticks":"outside","tickcolor":"rgb(51,51,51)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgb(77,77,77)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgb(255,255,255)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","hoverformat":".2f"},"annotations":[{"text":"Petal.Width","x":0.5,"y":-0.082572298325723,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"center","yanchor":"middle"},{"text":"Sepal.Length","x":-0.032243851638228,"y":0.5,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-90,"xanchor":"center","yanchor":"middle"},{"text":"Species","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"top"}],"yaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[4.12,8.08],"ticktext":["5","6","7","8"],"tickvals":[5,6,7,8],"ticks":"outside","tickcolor":"rgb(51,51,51)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgb(77,77,77)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgb(255,255,255)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgb(255,255,255)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgb(0,0,0)","family":"","size":11.689497716895},"y":0.913385826771654},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


---

## Another interactive plot


```r
iris %>% plot_ly(x = Petal.Width, y = Sepal.Length,
  type = "scatter", color = Species, mode = "markers")
```

<!--html_preserve--><div id="htmlwidget-7575" style="width:912px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-7575">{"x":{"data":[{"type":"scatter","inherit":false,"x":[2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],"y":[6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],"mode":"markers","name":"virginica","marker":{"color":"#66C2A5"}},{"type":"scatter","inherit":false,"x":[1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3],"y":[7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7],"mode":"markers","name":"versicolor","marker":{"color":"#FC8D62"}},{"type":"scatter","inherit":false,"x":[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2],"y":[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5],"mode":"markers","name":"setosa","marker":{"color":"#8DA0CB"}}],"layout":{"xaxis":{"title":"Petal.Width"},"yaxis":{"title":"Sepal.Length"},"hovermode":"closest","margin":{"b":40,"l":60,"t":25,"r":10}},"url":null,"width":null,"height":null,"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

---

# Scatterplots (Part Deux)

---

### Reed College majors VS Total Faculty FTE by department

- Based off [analysis](http://www.reed.edu/data-at-reed/resources/R/scatter_plots.html) done by Rich Majerus in 2014 using the `googleVis` package

- Data does not include 143 interdisciplinary majors and 9 undecided majors.  

- Majors like Bio/Chem are split between the two departments 

- General Lit/Lit majors are included with English 

- Dance majors and faculty are included with Theatre



---


```r
major_data %>% ggplot(aes(x = Majors, y = FTE)) +
  geom_point() +
  ggtitle("Reed College Majors and FTE by Department")
```

![](slides_to_html_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

---


```r
# make a new data frame with only two columns to scatter plot 
keep <- c('Majors', 'FTE')
data2 <- major_data[keep]

# add names to new data frame as factor 
data2$pop.html.tooltip=major_data$Departments

# create interactive scatter plot using googleVis
Scatter1 <- gvisScatterChart(data2,                                                           
                            options=list(tooltip="{isHtml:'True'}",              # Define tooltip                            
                              legend="none", lineWidth=0, pointSize=5,                                                     
                              vAxis="{title:'Faculty (Total FTE)'}",             # y-axis label                
                              hAxis="{title:'Majors (delared and intended)'}",   # x-axis label                     
                              width=900, height=600))                            # plot dimensions  
print(Scatter1, 'chart') 
```

<!-- ScatterChart generated in R 3.2.4 by googleVis 0.5.10 package -->
<!-- Wed Apr 13 12:12:45 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataScatterChartID118c82733c48a () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 67,
7.8,
"Art" 
],
[
 19,
4,
"Music" 
],
[
 22,
5.8,
"Theatre" 
],
[
 43,
3.7,
"Anthropology" 
],
[
 53,
5.5,
"Economics" 
],
[
 58,
9.5,
"History" 
],
[
 75,
6.2,
"Political Science" 
],
[
 36,
3.4,
"Sociology" 
],
[
 7,
4,
"Chinese" 
],
[
 25,
4,
"Classics" 
],
[
 155,
10,
"English" 
],
[
 6,
5,
"French" 
],
[
 1,
3,
"German" 
],
[
 3,
3,
"Russian" 
],
[
 8,
5,
"Spanish" 
],
[
 154.5,
9.8,
"Biology" 
],
[
 88,
6.8,
"Chemistry" 
],
[
 99.5,
9.55,
"Mathematics" 
],
[
 114,
6,
"Physics" 
],
[
 42,
3,
"Linguistics" 
],
[
 63.5,
5.2,
"Philosophy" 
],
[
 117,
7,
"Psychology" 
],
[
 16.5,
4,
"Religion" 
] 
];
data.addColumn('number','Majors');
data.addColumn('number','FTE');
data.addColumn({type: 'string', role: 'tooltip', 'p': {'html': true}});
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartScatterChartID118c82733c48a() {
var data = gvisDataScatterChartID118c82733c48a();
var options = {};
options["allowHtml"] = true;
options["tooltip"] = {isHtml:'True'};
options["legend"] = "none";
options["lineWidth"] =      0;
options["pointSize"] =      5;
options["vAxis"] = {title:'Faculty (Total FTE)'};
options["hAxis"] = {title:'Majors (delared and intended)'};
options["width"] =    900;
options["height"] =    600;

    var chart = new google.visualization.ScatterChart(
    document.getElementById('ScatterChartID118c82733c48a')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartScatterChartID118c82733c48a);
})();
function displayChartScatterChartID118c82733c48a() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartScatterChartID118c82733c48a"></script>
 
<!-- divChart -->
  
<div id="ScatterChartID118c82733c48a" 
  style="width: 900; height: 600;">
</div>

---

Left-click and drag to select an area of the chart to zoom on.  Right-click to zoom back out.


```r
Scatter2 <- gvisScatterChart(data2,                                                           
                            options=list(
                              explorer="{actions: ['dragToZoom', 
                                          'rightClickToReset'],
                                           maxZoomIn:0.05}",
                              #chartArea="{width:'85%',height:'80%'}",
                              tooltip="{isHtml:'True'}",              
                              crosshair="{trigger:'both'}",                         
                              legend="none", lineWidth=0, pointSize=5,                                                     
                              vAxis="{title:'Faculty (Total FTE)'}",                        
                              hAxis="{title:'Majors (delared and intended)'}",                     
                              width=900, height=600))                                                                 
print(Scatter2, 'chart') 
```

<!-- ScatterChart generated in R 3.2.4 by googleVis 0.5.10 package -->
<!-- Wed Apr 13 12:12:45 2016 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataScatterChartID118c812c75f15 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 67,
7.8,
"Art" 
],
[
 19,
4,
"Music" 
],
[
 22,
5.8,
"Theatre" 
],
[
 43,
3.7,
"Anthropology" 
],
[
 53,
5.5,
"Economics" 
],
[
 58,
9.5,
"History" 
],
[
 75,
6.2,
"Political Science" 
],
[
 36,
3.4,
"Sociology" 
],
[
 7,
4,
"Chinese" 
],
[
 25,
4,
"Classics" 
],
[
 155,
10,
"English" 
],
[
 6,
5,
"French" 
],
[
 1,
3,
"German" 
],
[
 3,
3,
"Russian" 
],
[
 8,
5,
"Spanish" 
],
[
 154.5,
9.8,
"Biology" 
],
[
 88,
6.8,
"Chemistry" 
],
[
 99.5,
9.55,
"Mathematics" 
],
[
 114,
6,
"Physics" 
],
[
 42,
3,
"Linguistics" 
],
[
 63.5,
5.2,
"Philosophy" 
],
[
 117,
7,
"Psychology" 
],
[
 16.5,
4,
"Religion" 
] 
];
data.addColumn('number','Majors');
data.addColumn('number','FTE');
data.addColumn({type: 'string', role: 'tooltip', 'p': {'html': true}});
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartScatterChartID118c812c75f15() {
var data = gvisDataScatterChartID118c812c75f15();
var options = {};
options["allowHtml"] = true;
options["explorer"] = {actions: ['dragToZoom', 
                                          'rightClickToReset'],
                                           maxZoomIn:0.05};
options["tooltip"] = {isHtml:'True'};
options["crosshair"] = {trigger:'both'};
options["legend"] = "none";
options["lineWidth"] =      0;
options["pointSize"] =      5;
options["vAxis"] = {title:'Faculty (Total FTE)'};
options["hAxis"] = {title:'Majors (delared and intended)'};
options["width"] =    900;
options["height"] =    600;

    var chart = new google.visualization.ScatterChart(
    document.getElementById('ScatterChartID118c812c75f15')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartScatterChartID118c812c75f15);
})();
function displayChartScatterChartID118c812c75f15() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartScatterChartID118c812c75f15"></script>
 
<!-- divChart -->
  
<div id="ScatterChartID118c812c75f15" 
  style="width: 900; height: 600;">
</div>


---

### Alaskan departure delays in PNW

- The [`pnwflights14`](http://github.com/ismayc/pnwflights14) package provides information contains information about all flights that departed from SEA in Seattle and PDX in Portland, in 2014: 162,049 flights in total.

- We can use this data and the `dplyr` package to look at daily maximum departure delays throughout the year for Alaskan Airlines.

---

# Time series/line graphs

---


```r
data("flights", package = "pnwflights14")
alaskan <- flights %>% 
  filter(carrier %in% c("AS")) %>%
  mutate(date2014 = as.Date(paste0("2014/", month, "/", day))) %>%
  group_by(date2014) %>%
  summarize(max_dep_delay = max(dep_delay, na.rm=TRUE))
```


```r
alaskan %>% ggplot(aes(x = date2014, y = max_dep_delay)) +
  geom_line() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %y") +
  xlab("Date") +
  ylab("Maximum Departure Delay")
```

![](slides_to_html_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

---


```r
ggplotly()
```

<!--html_preserve--><div id="htmlwidget-4586" style="width:912px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-4586">{"x":{"data":[{"x":[1388534400000,1388620800000,1388707200000,1388793600000,1388880000000,1388966400000,1389052800000,1389139200000,1389225600000,1389312000000,1389398400000,1389484800000,1389571200000,1389657600000,1389744000000,1389830400000,1389916800000,1390003200000,1390089600000,1390176000000,1390262400000,1390348800000,1390435200000,1390521600000,1390608000000,1390694400000,1390780800000,1390867200000,1390953600000,1391040000000,1391126400000,1391212800000,1391299200000,1391385600000,1391472000000,1391558400000,1391644800000,1391731200000,1391817600000,1391904000000,1391990400000,1392076800000,1392163200000,1392249600000,1392336000000,1392422400000,1392508800000,1392595200000,1392681600000,1392768000000,1392854400000,1392940800000,1393027200000,1393113600000,1393200000000,1393286400000,1393372800000,1393459200000,1393545600000,1393632000000,1393718400000,1393804800000,1393891200000,1393977600000,1394064000000,1394150400000,1394236800000,1394323200000,1394409600000,1394496000000,1394582400000,1394668800000,1394755200000,1394841600000,1394928000000,1395014400000,1395100800000,1395187200000,1395273600000,1395360000000,1395446400000,1395532800000,1395619200000,1395705600000,1395792000000,1395878400000,1395964800000,1396051200000,1396137600000,1396224000000,1396310400000,1396396800000,1396483200000,1396569600000,1396656000000,1396742400000,1396828800000,1396915200000,1397001600000,1397088000000,1397174400000,1397260800000,1397347200000,1397433600000,1397520000000,1397606400000,1397692800000,1397779200000,1397865600000,1397952000000,1398038400000,1398124800000,1398211200000,1398297600000,1398384000000,1398470400000,1398556800000,1398643200000,1398729600000,1398816000000,1398902400000,1398988800000,1399075200000,1399161600000,1399248000000,1399334400000,1399420800000,1399507200000,1399593600000,1399680000000,1399766400000,1399852800000,1399939200000,1400025600000,1400112000000,1400198400000,1400284800000,1400371200000,1400457600000,1400544000000,1400630400000,1400716800000,1400803200000,1400889600000,1400976000000,1401062400000,1401148800000,1401235200000,1401321600000,1401408000000,1401494400000,1401580800000,1401667200000,1401753600000,1401840000000,1401926400000,1402012800000,1402099200000,1402185600000,1402272000000,1402358400000,1402444800000,1402531200000,1402617600000,1402704000000,1402790400000,1402876800000,1402963200000,1403049600000,1403136000000,1403222400000,1403308800000,1403395200000,1403481600000,1403568000000,1403654400000,1403740800000,1403827200000,1403913600000,1404000000000,1404086400000,1404172800000,1404259200000,1404345600000,1404432000000,1404518400000,1404604800000,1404691200000,1404777600000,1404864000000,1404950400000,1405036800000,1405123200000,1405209600000,1405296000000,1405382400000,1405468800000,1405555200000,1405641600000,1405728000000,1405814400000,1405900800000,1405987200000,1406073600000,1406160000000,1406246400000,1406332800000,1406419200000,1406505600000,1406592000000,1406678400000,1406764800000,1406851200000,1406937600000,1407024000000,1407110400000,1407196800000,1407283200000,1407369600000,1407456000000,1407542400000,1407628800000,1407715200000,1407801600000,1407888000000,1407974400000,1408060800000,1408147200000,1408233600000,1408320000000,1408406400000,1408492800000,1408579200000,1408665600000,1408752000000,1408838400000,1408924800000,1409011200000,1409097600000,1409184000000,1409270400000,1409356800000,1409443200000,1409529600000,1409616000000,1409702400000,1409788800000,1409875200000,1409961600000,1410048000000,1410134400000,1410220800000,1410307200000,1410393600000,1410480000000,1410566400000,1410652800000,1410739200000,1410825600000,1410912000000,1410998400000,1411084800000,1411171200000,1411257600000,1411344000000,1411430400000,1411516800000,1411603200000,1411689600000,1411776000000,1411862400000,1411948800000,1412035200000,1412121600000,1412208000000,1412294400000,1412380800000,1412467200000,1412553600000,1412640000000,1412726400000,1412812800000,1412899200000,1412985600000,1413072000000,1413158400000,1413244800000,1413331200000,1413417600000,1413504000000,1413590400000,1413676800000,1413763200000,1413849600000,1413936000000,1414022400000,1414108800000,1414195200000,1414281600000,1414368000000,1414454400000,1414540800000,1414627200000,1414713600000,1414800000000,1414886400000,1414972800000,1415059200000,1415145600000,1415232000000,1415318400000,1415404800000,1415491200000,1415577600000,1415664000000,1415750400000,1415836800000,1415923200000,1416009600000,1416096000000,1416182400000,1416268800000,1416355200000,1416441600000,1416528000000,1416614400000,1416700800000,1416787200000,1416873600000,1416960000000,1417046400000,1417132800000,1417219200000,1417305600000,1417392000000,1417478400000,1417564800000,1417651200000,1417737600000,1417824000000,1417910400000,1417996800000,1418083200000,1418169600000,1418256000000,1418342400000,1418428800000,1418515200000,1418601600000,1418688000000,1418774400000,1418860800000,1418947200000,1419033600000,1419120000000,1419206400000,1419292800000,1419379200000,1419465600000,1419552000000,1419638400000,1419724800000,1419811200000,1419897600000,1419984000000],"y":[164,164,342,126,240,249,72,93,89,168,171,82,88,67,37,120,110,48,59,199,866,77,69,171,233,44,84,66,211,162,210,51,131,212,89,128,148,248,340,184,134,78,97,139,107,128,46,224,99,210,95,227,157,52,109,45,191,98,187,108,71,161,89,140,130,233,167,119,43,89,204,320,295,115,86,199,187,94,108,58,68,293,99,84,222,122,112,138,91,179,135,64,125,89,148,152,178,148,72,110,256,81,90,190,265,63,79,43,60,60,65,53,48,325,70,145,74,228,179,282,83,47,80,83,145,102,36,272,213,120,118,105,164,89,222,181,80,105,123,135,118,121,122,55,48,28,61,108,100,111,79,88,138,69,52,94,92,125,116,51,87,113,170,167,110,70,79,149,178,122,136,104,238,93,57,136,88,145,70,130,66,114,203,163,111,105,81,82,83,92,227,165,69,115,114,121,148,141,137,101,75,207,132,125,104,94,214,122,188,310,138,167,109,137,181,115,115,74,104,320,206,358,236,149,134,179,149,44,109,190,132,113,124,254,212,132,96,115,60,103,113,72,24,194,95,120,144,117,146,162,80,147,61,216,142,66,125,185,135,103,100,144,73,111,155,134,150,69,126,245,114,140,110,101,139,149,141,112,111,109,170,109,170,124,96,144,104,103,70,73,25,84,125,109,164,111,81,83,153,100,117,49,127,168,90,176,115,145,115,89,128,116,90,124,95,115,109,51,45,59,174,113,167,189,71,60,104,84,120,194,195,46,205,134,91,161,265,115,139,64,76,242,307,202,269,186,160,179,175,114,205,195,272,163,150,169,129,140,73,129,115,99,77,316,258],"text":["date2014: 2014-01-01<br>max_dep_delay: 164","date2014: 2014-01-02<br>max_dep_delay: 164","date2014: 2014-01-03<br>max_dep_delay: 342","date2014: 2014-01-04<br>max_dep_delay: 126","date2014: 2014-01-05<br>max_dep_delay: 240","date2014: 2014-01-06<br>max_dep_delay: 249","date2014: 2014-01-07<br>max_dep_delay: 72","date2014: 2014-01-08<br>max_dep_delay: 93","date2014: 2014-01-09<br>max_dep_delay: 89","date2014: 2014-01-10<br>max_dep_delay: 168","date2014: 2014-01-11<br>max_dep_delay: 171","date2014: 2014-01-12<br>max_dep_delay: 82","date2014: 2014-01-13<br>max_dep_delay: 88","date2014: 2014-01-14<br>max_dep_delay: 67","date2014: 2014-01-15<br>max_dep_delay: 37","date2014: 2014-01-16<br>max_dep_delay: 120","date2014: 2014-01-17<br>max_dep_delay: 110","date2014: 2014-01-18<br>max_dep_delay: 48","date2014: 2014-01-19<br>max_dep_delay: 59","date2014: 2014-01-20<br>max_dep_delay: 199","date2014: 2014-01-21<br>max_dep_delay: 866","date2014: 2014-01-22<br>max_dep_delay: 77","date2014: 2014-01-23<br>max_dep_delay: 69","date2014: 2014-01-24<br>max_dep_delay: 171","date2014: 2014-01-25<br>max_dep_delay: 233","date2014: 2014-01-26<br>max_dep_delay: 44","date2014: 2014-01-27<br>max_dep_delay: 84","date2014: 2014-01-28<br>max_dep_delay: 66","date2014: 2014-01-29<br>max_dep_delay: 211","date2014: 2014-01-30<br>max_dep_delay: 162","date2014: 2014-01-31<br>max_dep_delay: 210","date2014: 2014-02-01<br>max_dep_delay: 51","date2014: 2014-02-02<br>max_dep_delay: 131","date2014: 2014-02-03<br>max_dep_delay: 212","date2014: 2014-02-04<br>max_dep_delay: 89","date2014: 2014-02-05<br>max_dep_delay: 128","date2014: 2014-02-06<br>max_dep_delay: 148","date2014: 2014-02-07<br>max_dep_delay: 248","date2014: 2014-02-08<br>max_dep_delay: 340","date2014: 2014-02-09<br>max_dep_delay: 184","date2014: 2014-02-10<br>max_dep_delay: 134","date2014: 2014-02-11<br>max_dep_delay: 78","date2014: 2014-02-12<br>max_dep_delay: 97","date2014: 2014-02-13<br>max_dep_delay: 139","date2014: 2014-02-14<br>max_dep_delay: 107","date2014: 2014-02-15<br>max_dep_delay: 128","date2014: 2014-02-16<br>max_dep_delay: 46","date2014: 2014-02-17<br>max_dep_delay: 224","date2014: 2014-02-18<br>max_dep_delay: 99","date2014: 2014-02-19<br>max_dep_delay: 210","date2014: 2014-02-20<br>max_dep_delay: 95","date2014: 2014-02-21<br>max_dep_delay: 227","date2014: 2014-02-22<br>max_dep_delay: 157","date2014: 2014-02-23<br>max_dep_delay: 52","date2014: 2014-02-24<br>max_dep_delay: 109","date2014: 2014-02-25<br>max_dep_delay: 45","date2014: 2014-02-26<br>max_dep_delay: 191","date2014: 2014-02-27<br>max_dep_delay: 98","date2014: 2014-02-28<br>max_dep_delay: 187","date2014: 2014-03-01<br>max_dep_delay: 108","date2014: 2014-03-02<br>max_dep_delay: 71","date2014: 2014-03-03<br>max_dep_delay: 161","date2014: 2014-03-04<br>max_dep_delay: 89","date2014: 2014-03-05<br>max_dep_delay: 140","date2014: 2014-03-06<br>max_dep_delay: 130","date2014: 2014-03-07<br>max_dep_delay: 233","date2014: 2014-03-08<br>max_dep_delay: 167","date2014: 2014-03-09<br>max_dep_delay: 119","date2014: 2014-03-10<br>max_dep_delay: 43","date2014: 2014-03-11<br>max_dep_delay: 89","date2014: 2014-03-12<br>max_dep_delay: 204","date2014: 2014-03-13<br>max_dep_delay: 320","date2014: 2014-03-14<br>max_dep_delay: 295","date2014: 2014-03-15<br>max_dep_delay: 115","date2014: 2014-03-16<br>max_dep_delay: 86","date2014: 2014-03-17<br>max_dep_delay: 199","date2014: 2014-03-18<br>max_dep_delay: 187","date2014: 2014-03-19<br>max_dep_delay: 94","date2014: 2014-03-20<br>max_dep_delay: 108","date2014: 2014-03-21<br>max_dep_delay: 58","date2014: 2014-03-22<br>max_dep_delay: 68","date2014: 2014-03-23<br>max_dep_delay: 293","date2014: 2014-03-24<br>max_dep_delay: 99","date2014: 2014-03-25<br>max_dep_delay: 84","date2014: 2014-03-26<br>max_dep_delay: 222","date2014: 2014-03-27<br>max_dep_delay: 122","date2014: 2014-03-28<br>max_dep_delay: 112","date2014: 2014-03-29<br>max_dep_delay: 138","date2014: 2014-03-30<br>max_dep_delay: 91","date2014: 2014-03-31<br>max_dep_delay: 179","date2014: 2014-04-01<br>max_dep_delay: 135","date2014: 2014-04-02<br>max_dep_delay: 64","date2014: 2014-04-03<br>max_dep_delay: 125","date2014: 2014-04-04<br>max_dep_delay: 89","date2014: 2014-04-05<br>max_dep_delay: 148","date2014: 2014-04-06<br>max_dep_delay: 152","date2014: 2014-04-07<br>max_dep_delay: 178","date2014: 2014-04-08<br>max_dep_delay: 148","date2014: 2014-04-09<br>max_dep_delay: 72","date2014: 2014-04-10<br>max_dep_delay: 110","date2014: 2014-04-11<br>max_dep_delay: 256","date2014: 2014-04-12<br>max_dep_delay: 81","date2014: 2014-04-13<br>max_dep_delay: 90","date2014: 2014-04-14<br>max_dep_delay: 190","date2014: 2014-04-15<br>max_dep_delay: 265","date2014: 2014-04-16<br>max_dep_delay: 63","date2014: 2014-04-17<br>max_dep_delay: 79","date2014: 2014-04-18<br>max_dep_delay: 43","date2014: 2014-04-19<br>max_dep_delay: 60","date2014: 2014-04-20<br>max_dep_delay: 60","date2014: 2014-04-21<br>max_dep_delay: 65","date2014: 2014-04-22<br>max_dep_delay: 53","date2014: 2014-04-23<br>max_dep_delay: 48","date2014: 2014-04-24<br>max_dep_delay: 325","date2014: 2014-04-25<br>max_dep_delay: 70","date2014: 2014-04-26<br>max_dep_delay: 145","date2014: 2014-04-27<br>max_dep_delay: 74","date2014: 2014-04-28<br>max_dep_delay: 228","date2014: 2014-04-29<br>max_dep_delay: 179","date2014: 2014-04-30<br>max_dep_delay: 282","date2014: 2014-05-01<br>max_dep_delay: 83","date2014: 2014-05-02<br>max_dep_delay: 47","date2014: 2014-05-03<br>max_dep_delay: 80","date2014: 2014-05-04<br>max_dep_delay: 83","date2014: 2014-05-05<br>max_dep_delay: 145","date2014: 2014-05-06<br>max_dep_delay: 102","date2014: 2014-05-07<br>max_dep_delay: 36","date2014: 2014-05-08<br>max_dep_delay: 272","date2014: 2014-05-09<br>max_dep_delay: 213","date2014: 2014-05-10<br>max_dep_delay: 120","date2014: 2014-05-11<br>max_dep_delay: 118","date2014: 2014-05-12<br>max_dep_delay: 105","date2014: 2014-05-13<br>max_dep_delay: 164","date2014: 2014-05-14<br>max_dep_delay: 89","date2014: 2014-05-15<br>max_dep_delay: 222","date2014: 2014-05-16<br>max_dep_delay: 181","date2014: 2014-05-17<br>max_dep_delay: 80","date2014: 2014-05-18<br>max_dep_delay: 105","date2014: 2014-05-19<br>max_dep_delay: 123","date2014: 2014-05-20<br>max_dep_delay: 135","date2014: 2014-05-21<br>max_dep_delay: 118","date2014: 2014-05-22<br>max_dep_delay: 121","date2014: 2014-05-23<br>max_dep_delay: 122","date2014: 2014-05-24<br>max_dep_delay: 55","date2014: 2014-05-25<br>max_dep_delay: 48","date2014: 2014-05-26<br>max_dep_delay: 28","date2014: 2014-05-27<br>max_dep_delay: 61","date2014: 2014-05-28<br>max_dep_delay: 108","date2014: 2014-05-29<br>max_dep_delay: 100","date2014: 2014-05-30<br>max_dep_delay: 111","date2014: 2014-05-31<br>max_dep_delay: 79","date2014: 2014-06-01<br>max_dep_delay: 88","date2014: 2014-06-02<br>max_dep_delay: 138","date2014: 2014-06-03<br>max_dep_delay: 69","date2014: 2014-06-04<br>max_dep_delay: 52","date2014: 2014-06-05<br>max_dep_delay: 94","date2014: 2014-06-06<br>max_dep_delay: 92","date2014: 2014-06-07<br>max_dep_delay: 125","date2014: 2014-06-08<br>max_dep_delay: 116","date2014: 2014-06-09<br>max_dep_delay: 51","date2014: 2014-06-10<br>max_dep_delay: 87","date2014: 2014-06-11<br>max_dep_delay: 113","date2014: 2014-06-12<br>max_dep_delay: 170","date2014: 2014-06-13<br>max_dep_delay: 167","date2014: 2014-06-14<br>max_dep_delay: 110","date2014: 2014-06-15<br>max_dep_delay: 70","date2014: 2014-06-16<br>max_dep_delay: 79","date2014: 2014-06-17<br>max_dep_delay: 149","date2014: 2014-06-18<br>max_dep_delay: 178","date2014: 2014-06-19<br>max_dep_delay: 122","date2014: 2014-06-20<br>max_dep_delay: 136","date2014: 2014-06-21<br>max_dep_delay: 104","date2014: 2014-06-22<br>max_dep_delay: 238","date2014: 2014-06-23<br>max_dep_delay: 93","date2014: 2014-06-24<br>max_dep_delay: 57","date2014: 2014-06-25<br>max_dep_delay: 136","date2014: 2014-06-26<br>max_dep_delay: 88","date2014: 2014-06-27<br>max_dep_delay: 145","date2014: 2014-06-28<br>max_dep_delay: 70","date2014: 2014-06-29<br>max_dep_delay: 130","date2014: 2014-06-30<br>max_dep_delay: 66","date2014: 2014-07-01<br>max_dep_delay: 114","date2014: 2014-07-02<br>max_dep_delay: 203","date2014: 2014-07-03<br>max_dep_delay: 163","date2014: 2014-07-04<br>max_dep_delay: 111","date2014: 2014-07-05<br>max_dep_delay: 105","date2014: 2014-07-06<br>max_dep_delay: 81","date2014: 2014-07-07<br>max_dep_delay: 82","date2014: 2014-07-08<br>max_dep_delay: 83","date2014: 2014-07-09<br>max_dep_delay: 92","date2014: 2014-07-10<br>max_dep_delay: 227","date2014: 2014-07-11<br>max_dep_delay: 165","date2014: 2014-07-12<br>max_dep_delay: 69","date2014: 2014-07-13<br>max_dep_delay: 115","date2014: 2014-07-14<br>max_dep_delay: 114","date2014: 2014-07-15<br>max_dep_delay: 121","date2014: 2014-07-16<br>max_dep_delay: 148","date2014: 2014-07-17<br>max_dep_delay: 141","date2014: 2014-07-18<br>max_dep_delay: 137","date2014: 2014-07-19<br>max_dep_delay: 101","date2014: 2014-07-20<br>max_dep_delay: 75","date2014: 2014-07-21<br>max_dep_delay: 207","date2014: 2014-07-22<br>max_dep_delay: 132","date2014: 2014-07-23<br>max_dep_delay: 125","date2014: 2014-07-24<br>max_dep_delay: 104","date2014: 2014-07-25<br>max_dep_delay: 94","date2014: 2014-07-26<br>max_dep_delay: 214","date2014: 2014-07-27<br>max_dep_delay: 122","date2014: 2014-07-28<br>max_dep_delay: 188","date2014: 2014-07-29<br>max_dep_delay: 310","date2014: 2014-07-30<br>max_dep_delay: 138","date2014: 2014-07-31<br>max_dep_delay: 167","date2014: 2014-08-01<br>max_dep_delay: 109","date2014: 2014-08-02<br>max_dep_delay: 137","date2014: 2014-08-03<br>max_dep_delay: 181","date2014: 2014-08-04<br>max_dep_delay: 115","date2014: 2014-08-05<br>max_dep_delay: 115","date2014: 2014-08-06<br>max_dep_delay: 74","date2014: 2014-08-07<br>max_dep_delay: 104","date2014: 2014-08-08<br>max_dep_delay: 320","date2014: 2014-08-09<br>max_dep_delay: 206","date2014: 2014-08-10<br>max_dep_delay: 358","date2014: 2014-08-11<br>max_dep_delay: 236","date2014: 2014-08-12<br>max_dep_delay: 149","date2014: 2014-08-13<br>max_dep_delay: 134","date2014: 2014-08-14<br>max_dep_delay: 179","date2014: 2014-08-15<br>max_dep_delay: 149","date2014: 2014-08-16<br>max_dep_delay: 44","date2014: 2014-08-17<br>max_dep_delay: 109","date2014: 2014-08-18<br>max_dep_delay: 190","date2014: 2014-08-19<br>max_dep_delay: 132","date2014: 2014-08-20<br>max_dep_delay: 113","date2014: 2014-08-21<br>max_dep_delay: 124","date2014: 2014-08-22<br>max_dep_delay: 254","date2014: 2014-08-23<br>max_dep_delay: 212","date2014: 2014-08-24<br>max_dep_delay: 132","date2014: 2014-08-25<br>max_dep_delay: 96","date2014: 2014-08-26<br>max_dep_delay: 115","date2014: 2014-08-27<br>max_dep_delay: 60","date2014: 2014-08-28<br>max_dep_delay: 103","date2014: 2014-08-29<br>max_dep_delay: 113","date2014: 2014-08-30<br>max_dep_delay: 72","date2014: 2014-08-31<br>max_dep_delay: 24","date2014: 2014-09-01<br>max_dep_delay: 194","date2014: 2014-09-02<br>max_dep_delay: 95","date2014: 2014-09-03<br>max_dep_delay: 120","date2014: 2014-09-04<br>max_dep_delay: 144","date2014: 2014-09-05<br>max_dep_delay: 117","date2014: 2014-09-06<br>max_dep_delay: 146","date2014: 2014-09-07<br>max_dep_delay: 162","date2014: 2014-09-08<br>max_dep_delay: 80","date2014: 2014-09-09<br>max_dep_delay: 147","date2014: 2014-09-10<br>max_dep_delay: 61","date2014: 2014-09-11<br>max_dep_delay: 216","date2014: 2014-09-12<br>max_dep_delay: 142","date2014: 2014-09-13<br>max_dep_delay: 66","date2014: 2014-09-14<br>max_dep_delay: 125","date2014: 2014-09-15<br>max_dep_delay: 185","date2014: 2014-09-16<br>max_dep_delay: 135","date2014: 2014-09-17<br>max_dep_delay: 103","date2014: 2014-09-18<br>max_dep_delay: 100","date2014: 2014-09-19<br>max_dep_delay: 144","date2014: 2014-09-20<br>max_dep_delay: 73","date2014: 2014-09-21<br>max_dep_delay: 111","date2014: 2014-09-22<br>max_dep_delay: 155","date2014: 2014-09-23<br>max_dep_delay: 134","date2014: 2014-09-24<br>max_dep_delay: 150","date2014: 2014-09-25<br>max_dep_delay: 69","date2014: 2014-09-26<br>max_dep_delay: 126","date2014: 2014-09-27<br>max_dep_delay: 245","date2014: 2014-09-28<br>max_dep_delay: 114","date2014: 2014-09-29<br>max_dep_delay: 140","date2014: 2014-09-30<br>max_dep_delay: 110","date2014: 2014-10-01<br>max_dep_delay: 101","date2014: 2014-10-02<br>max_dep_delay: 139","date2014: 2014-10-03<br>max_dep_delay: 149","date2014: 2014-10-04<br>max_dep_delay: 141","date2014: 2014-10-05<br>max_dep_delay: 112","date2014: 2014-10-06<br>max_dep_delay: 111","date2014: 2014-10-07<br>max_dep_delay: 109","date2014: 2014-10-08<br>max_dep_delay: 170","date2014: 2014-10-09<br>max_dep_delay: 109","date2014: 2014-10-10<br>max_dep_delay: 170","date2014: 2014-10-11<br>max_dep_delay: 124","date2014: 2014-10-12<br>max_dep_delay: 96","date2014: 2014-10-13<br>max_dep_delay: 144","date2014: 2014-10-14<br>max_dep_delay: 104","date2014: 2014-10-15<br>max_dep_delay: 103","date2014: 2014-10-16<br>max_dep_delay: 70","date2014: 2014-10-17<br>max_dep_delay: 73","date2014: 2014-10-18<br>max_dep_delay: 25","date2014: 2014-10-19<br>max_dep_delay: 84","date2014: 2014-10-20<br>max_dep_delay: 125","date2014: 2014-10-21<br>max_dep_delay: 109","date2014: 2014-10-22<br>max_dep_delay: 164","date2014: 2014-10-23<br>max_dep_delay: 111","date2014: 2014-10-24<br>max_dep_delay: 81","date2014: 2014-10-25<br>max_dep_delay: 83","date2014: 2014-10-26<br>max_dep_delay: 153","date2014: 2014-10-27<br>max_dep_delay: 100","date2014: 2014-10-28<br>max_dep_delay: 117","date2014: 2014-10-29<br>max_dep_delay: 49","date2014: 2014-10-30<br>max_dep_delay: 127","date2014: 2014-10-31<br>max_dep_delay: 168","date2014: 2014-11-01<br>max_dep_delay: 90","date2014: 2014-11-02<br>max_dep_delay: 176","date2014: 2014-11-03<br>max_dep_delay: 115","date2014: 2014-11-04<br>max_dep_delay: 145","date2014: 2014-11-05<br>max_dep_delay: 115","date2014: 2014-11-06<br>max_dep_delay: 89","date2014: 2014-11-07<br>max_dep_delay: 128","date2014: 2014-11-08<br>max_dep_delay: 116","date2014: 2014-11-09<br>max_dep_delay: 90","date2014: 2014-11-10<br>max_dep_delay: 124","date2014: 2014-11-11<br>max_dep_delay: 95","date2014: 2014-11-12<br>max_dep_delay: 115","date2014: 2014-11-13<br>max_dep_delay: 109","date2014: 2014-11-14<br>max_dep_delay: 51","date2014: 2014-11-15<br>max_dep_delay: 45","date2014: 2014-11-16<br>max_dep_delay: 59","date2014: 2014-11-17<br>max_dep_delay: 174","date2014: 2014-11-18<br>max_dep_delay: 113","date2014: 2014-11-19<br>max_dep_delay: 167","date2014: 2014-11-20<br>max_dep_delay: 189","date2014: 2014-11-21<br>max_dep_delay: 71","date2014: 2014-11-22<br>max_dep_delay: 60","date2014: 2014-11-23<br>max_dep_delay: 104","date2014: 2014-11-24<br>max_dep_delay: 84","date2014: 2014-11-25<br>max_dep_delay: 120","date2014: 2014-11-26<br>max_dep_delay: 194","date2014: 2014-11-27<br>max_dep_delay: 195","date2014: 2014-11-28<br>max_dep_delay: 46","date2014: 2014-11-29<br>max_dep_delay: 205","date2014: 2014-11-30<br>max_dep_delay: 134","date2014: 2014-12-01<br>max_dep_delay: 91","date2014: 2014-12-02<br>max_dep_delay: 161","date2014: 2014-12-03<br>max_dep_delay: 265","date2014: 2014-12-04<br>max_dep_delay: 115","date2014: 2014-12-05<br>max_dep_delay: 139","date2014: 2014-12-06<br>max_dep_delay: 64","date2014: 2014-12-07<br>max_dep_delay: 76","date2014: 2014-12-08<br>max_dep_delay: 242","date2014: 2014-12-09<br>max_dep_delay: 307","date2014: 2014-12-10<br>max_dep_delay: 202","date2014: 2014-12-11<br>max_dep_delay: 269","date2014: 2014-12-12<br>max_dep_delay: 186","date2014: 2014-12-13<br>max_dep_delay: 160","date2014: 2014-12-14<br>max_dep_delay: 179","date2014: 2014-12-15<br>max_dep_delay: 175","date2014: 2014-12-16<br>max_dep_delay: 114","date2014: 2014-12-17<br>max_dep_delay: 205","date2014: 2014-12-18<br>max_dep_delay: 195","date2014: 2014-12-19<br>max_dep_delay: 272","date2014: 2014-12-20<br>max_dep_delay: 163","date2014: 2014-12-21<br>max_dep_delay: 150","date2014: 2014-12-22<br>max_dep_delay: 169","date2014: 2014-12-23<br>max_dep_delay: 129","date2014: 2014-12-24<br>max_dep_delay: 140","date2014: 2014-12-25<br>max_dep_delay: 73","date2014: 2014-12-26<br>max_dep_delay: 129","date2014: 2014-12-27<br>max_dep_delay: 115","date2014: 2014-12-28<br>max_dep_delay: 99","date2014: 2014-12-29<br>max_dep_delay: 77","date2014: 2014-12-30<br>max_dep_delay: 316","date2014: 2014-12-31<br>max_dep_delay: 258"],"type":"scatter","mode":"lines","name":"","line":{"width":1.88976377952756,"color":"rgb(0,0,0)","dash":"solid"},"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text"}],"layout":{"margin":{"b":43.8356164383562,"l":43.1050228310502,"t":29.8812785388128,"r":7.30593607305936},"plot_bgcolor":"rgb(235,235,235)","paper_bgcolor":"rgb(255,255,255)","font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[1386961920000,1421556480000],"ticktext":["Jan 14","Feb 14","Mar 14","Apr 14","May 14","Jun 14","Jul 14","Aug 14","Sep 14","Oct 14","Nov 14","Dec 14","Jan 15"],"tickvals":[1388534400000,1391212800000,1393632000000,1396310400000,1398902400000,1401580800000,1404172800000,1406851200000,1409529600000,1412121600000,1414800000000,1417392000000,1420070400000],"ticks":"outside","tickcolor":"rgb(51,51,51)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgb(77,77,77)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgb(255,255,255)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","hoverformat":".2f"},"annotations":[{"text":"Date","x":0.5,"y":-0.082572298325723,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"center","yanchor":"middle"},{"text":"Maximum Departure Delay","x":-0.054674357125691,"y":0.5,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgb(0,0,0)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-90,"xanchor":"center","yanchor":"middle"}],"yaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[-18.1,908.1],"ticktext":["0","250","500","750"],"tickvals":[0,250,500,750],"ticks":"outside","tickcolor":"rgb(51,51,51)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgb(77,77,77)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgb(255,255,255)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgb(255,255,255)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgb(0,0,0)","family":"","size":11.689497716895}},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

---

## Plotting the time series using `dygraph` 

(Converting to time series format using `xts`)


```r
alaskan_ts <- xts(alaskan$max_dep_delay, alaskan$date2014)
colnames(alaskan_ts) <- "Max Departure Delay"
dygraph(alaskan_ts) %>% dyRangeSelector()
```

<!--html_preserve--><div id="htmlwidget-7818" style="width:912px;height:480px;" class="dygraphs html-widget"></div>
<script type="application/json" data-for="htmlwidget-7818">{"x":{"attrs":{"labels":["day","Max Departure Delay"],"legend":"auto","retainDateWindow":false,"axes":{"x":{"pixelsPerLabel":60}},"showRangeSelector":true,"rangeSelectorHeight":40,"rangeSelectorPlotFillColor":" #A7B1C4","rangeSelectorPlotStrokeColor":"#808FAB","interactionModel":"Dygraph.Interaction.defaultModel"},"scale":"daily","annotations":[],"shadings":[],"events":[],"format":"date","data":[["2014-01-01T00:00:00Z","2014-01-02T00:00:00Z","2014-01-03T00:00:00Z","2014-01-04T00:00:00Z","2014-01-05T00:00:00Z","2014-01-06T00:00:00Z","2014-01-07T00:00:00Z","2014-01-08T00:00:00Z","2014-01-09T00:00:00Z","2014-01-10T00:00:00Z","2014-01-11T00:00:00Z","2014-01-12T00:00:00Z","2014-01-13T00:00:00Z","2014-01-14T00:00:00Z","2014-01-15T00:00:00Z","2014-01-16T00:00:00Z","2014-01-17T00:00:00Z","2014-01-18T00:00:00Z","2014-01-19T00:00:00Z","2014-01-20T00:00:00Z","2014-01-21T00:00:00Z","2014-01-22T00:00:00Z","2014-01-23T00:00:00Z","2014-01-24T00:00:00Z","2014-01-25T00:00:00Z","2014-01-26T00:00:00Z","2014-01-27T00:00:00Z","2014-01-28T00:00:00Z","2014-01-29T00:00:00Z","2014-01-30T00:00:00Z","2014-01-31T00:00:00Z","2014-02-01T00:00:00Z","2014-02-02T00:00:00Z","2014-02-03T00:00:00Z","2014-02-04T00:00:00Z","2014-02-05T00:00:00Z","2014-02-06T00:00:00Z","2014-02-07T00:00:00Z","2014-02-08T00:00:00Z","2014-02-09T00:00:00Z","2014-02-10T00:00:00Z","2014-02-11T00:00:00Z","2014-02-12T00:00:00Z","2014-02-13T00:00:00Z","2014-02-14T00:00:00Z","2014-02-15T00:00:00Z","2014-02-16T00:00:00Z","2014-02-17T00:00:00Z","2014-02-18T00:00:00Z","2014-02-19T00:00:00Z","2014-02-20T00:00:00Z","2014-02-21T00:00:00Z","2014-02-22T00:00:00Z","2014-02-23T00:00:00Z","2014-02-24T00:00:00Z","2014-02-25T00:00:00Z","2014-02-26T00:00:00Z","2014-02-27T00:00:00Z","2014-02-28T00:00:00Z","2014-03-01T00:00:00Z","2014-03-02T00:00:00Z","2014-03-03T00:00:00Z","2014-03-04T00:00:00Z","2014-03-05T00:00:00Z","2014-03-06T00:00:00Z","2014-03-07T00:00:00Z","2014-03-08T00:00:00Z","2014-03-09T00:00:00Z","2014-03-10T00:00:00Z","2014-03-11T00:00:00Z","2014-03-12T00:00:00Z","2014-03-13T00:00:00Z","2014-03-14T00:00:00Z","2014-03-15T00:00:00Z","2014-03-16T00:00:00Z","2014-03-17T00:00:00Z","2014-03-18T00:00:00Z","2014-03-19T00:00:00Z","2014-03-20T00:00:00Z","2014-03-21T00:00:00Z","2014-03-22T00:00:00Z","2014-03-23T00:00:00Z","2014-03-24T00:00:00Z","2014-03-25T00:00:00Z","2014-03-26T00:00:00Z","2014-03-27T00:00:00Z","2014-03-28T00:00:00Z","2014-03-29T00:00:00Z","2014-03-30T00:00:00Z","2014-03-31T00:00:00Z","2014-04-01T00:00:00Z","2014-04-02T00:00:00Z","2014-04-03T00:00:00Z","2014-04-04T00:00:00Z","2014-04-05T00:00:00Z","2014-04-06T00:00:00Z","2014-04-07T00:00:00Z","2014-04-08T00:00:00Z","2014-04-09T00:00:00Z","2014-04-10T00:00:00Z","2014-04-11T00:00:00Z","2014-04-12T00:00:00Z","2014-04-13T00:00:00Z","2014-04-14T00:00:00Z","2014-04-15T00:00:00Z","2014-04-16T00:00:00Z","2014-04-17T00:00:00Z","2014-04-18T00:00:00Z","2014-04-19T00:00:00Z","2014-04-20T00:00:00Z","2014-04-21T00:00:00Z","2014-04-22T00:00:00Z","2014-04-23T00:00:00Z","2014-04-24T00:00:00Z","2014-04-25T00:00:00Z","2014-04-26T00:00:00Z","2014-04-27T00:00:00Z","2014-04-28T00:00:00Z","2014-04-29T00:00:00Z","2014-04-30T00:00:00Z","2014-05-01T00:00:00Z","2014-05-02T00:00:00Z","2014-05-03T00:00:00Z","2014-05-04T00:00:00Z","2014-05-05T00:00:00Z","2014-05-06T00:00:00Z","2014-05-07T00:00:00Z","2014-05-08T00:00:00Z","2014-05-09T00:00:00Z","2014-05-10T00:00:00Z","2014-05-11T00:00:00Z","2014-05-12T00:00:00Z","2014-05-13T00:00:00Z","2014-05-14T00:00:00Z","2014-05-15T00:00:00Z","2014-05-16T00:00:00Z","2014-05-17T00:00:00Z","2014-05-18T00:00:00Z","2014-05-19T00:00:00Z","2014-05-20T00:00:00Z","2014-05-21T00:00:00Z","2014-05-22T00:00:00Z","2014-05-23T00:00:00Z","2014-05-24T00:00:00Z","2014-05-25T00:00:00Z","2014-05-26T00:00:00Z","2014-05-27T00:00:00Z","2014-05-28T00:00:00Z","2014-05-29T00:00:00Z","2014-05-30T00:00:00Z","2014-05-31T00:00:00Z","2014-06-01T00:00:00Z","2014-06-02T00:00:00Z","2014-06-03T00:00:00Z","2014-06-04T00:00:00Z","2014-06-05T00:00:00Z","2014-06-06T00:00:00Z","2014-06-07T00:00:00Z","2014-06-08T00:00:00Z","2014-06-09T00:00:00Z","2014-06-10T00:00:00Z","2014-06-11T00:00:00Z","2014-06-12T00:00:00Z","2014-06-13T00:00:00Z","2014-06-14T00:00:00Z","2014-06-15T00:00:00Z","2014-06-16T00:00:00Z","2014-06-17T00:00:00Z","2014-06-18T00:00:00Z","2014-06-19T00:00:00Z","2014-06-20T00:00:00Z","2014-06-21T00:00:00Z","2014-06-22T00:00:00Z","2014-06-23T00:00:00Z","2014-06-24T00:00:00Z","2014-06-25T00:00:00Z","2014-06-26T00:00:00Z","2014-06-27T00:00:00Z","2014-06-28T00:00:00Z","2014-06-29T00:00:00Z","2014-06-30T00:00:00Z","2014-07-01T00:00:00Z","2014-07-02T00:00:00Z","2014-07-03T00:00:00Z","2014-07-04T00:00:00Z","2014-07-05T00:00:00Z","2014-07-06T00:00:00Z","2014-07-07T00:00:00Z","2014-07-08T00:00:00Z","2014-07-09T00:00:00Z","2014-07-10T00:00:00Z","2014-07-11T00:00:00Z","2014-07-12T00:00:00Z","2014-07-13T00:00:00Z","2014-07-14T00:00:00Z","2014-07-15T00:00:00Z","2014-07-16T00:00:00Z","2014-07-17T00:00:00Z","2014-07-18T00:00:00Z","2014-07-19T00:00:00Z","2014-07-20T00:00:00Z","2014-07-21T00:00:00Z","2014-07-22T00:00:00Z","2014-07-23T00:00:00Z","2014-07-24T00:00:00Z","2014-07-25T00:00:00Z","2014-07-26T00:00:00Z","2014-07-27T00:00:00Z","2014-07-28T00:00:00Z","2014-07-29T00:00:00Z","2014-07-30T00:00:00Z","2014-07-31T00:00:00Z","2014-08-01T00:00:00Z","2014-08-02T00:00:00Z","2014-08-03T00:00:00Z","2014-08-04T00:00:00Z","2014-08-05T00:00:00Z","2014-08-06T00:00:00Z","2014-08-07T00:00:00Z","2014-08-08T00:00:00Z","2014-08-09T00:00:00Z","2014-08-10T00:00:00Z","2014-08-11T00:00:00Z","2014-08-12T00:00:00Z","2014-08-13T00:00:00Z","2014-08-14T00:00:00Z","2014-08-15T00:00:00Z","2014-08-16T00:00:00Z","2014-08-17T00:00:00Z","2014-08-18T00:00:00Z","2014-08-19T00:00:00Z","2014-08-20T00:00:00Z","2014-08-21T00:00:00Z","2014-08-22T00:00:00Z","2014-08-23T00:00:00Z","2014-08-24T00:00:00Z","2014-08-25T00:00:00Z","2014-08-26T00:00:00Z","2014-08-27T00:00:00Z","2014-08-28T00:00:00Z","2014-08-29T00:00:00Z","2014-08-30T00:00:00Z","2014-08-31T00:00:00Z","2014-09-01T00:00:00Z","2014-09-02T00:00:00Z","2014-09-03T00:00:00Z","2014-09-04T00:00:00Z","2014-09-05T00:00:00Z","2014-09-06T00:00:00Z","2014-09-07T00:00:00Z","2014-09-08T00:00:00Z","2014-09-09T00:00:00Z","2014-09-10T00:00:00Z","2014-09-11T00:00:00Z","2014-09-12T00:00:00Z","2014-09-13T00:00:00Z","2014-09-14T00:00:00Z","2014-09-15T00:00:00Z","2014-09-16T00:00:00Z","2014-09-17T00:00:00Z","2014-09-18T00:00:00Z","2014-09-19T00:00:00Z","2014-09-20T00:00:00Z","2014-09-21T00:00:00Z","2014-09-22T00:00:00Z","2014-09-23T00:00:00Z","2014-09-24T00:00:00Z","2014-09-25T00:00:00Z","2014-09-26T00:00:00Z","2014-09-27T00:00:00Z","2014-09-28T00:00:00Z","2014-09-29T00:00:00Z","2014-09-30T00:00:00Z","2014-10-01T00:00:00Z","2014-10-02T00:00:00Z","2014-10-03T00:00:00Z","2014-10-04T00:00:00Z","2014-10-05T00:00:00Z","2014-10-06T00:00:00Z","2014-10-07T00:00:00Z","2014-10-08T00:00:00Z","2014-10-09T00:00:00Z","2014-10-10T00:00:00Z","2014-10-11T00:00:00Z","2014-10-12T00:00:00Z","2014-10-13T00:00:00Z","2014-10-14T00:00:00Z","2014-10-15T00:00:00Z","2014-10-16T00:00:00Z","2014-10-17T00:00:00Z","2014-10-18T00:00:00Z","2014-10-19T00:00:00Z","2014-10-20T00:00:00Z","2014-10-21T00:00:00Z","2014-10-22T00:00:00Z","2014-10-23T00:00:00Z","2014-10-24T00:00:00Z","2014-10-25T00:00:00Z","2014-10-26T00:00:00Z","2014-10-27T00:00:00Z","2014-10-28T00:00:00Z","2014-10-29T00:00:00Z","2014-10-30T00:00:00Z","2014-10-31T00:00:00Z","2014-11-01T00:00:00Z","2014-11-02T00:00:00Z","2014-11-03T00:00:00Z","2014-11-04T00:00:00Z","2014-11-05T00:00:00Z","2014-11-06T00:00:00Z","2014-11-07T00:00:00Z","2014-11-08T00:00:00Z","2014-11-09T00:00:00Z","2014-11-10T00:00:00Z","2014-11-11T00:00:00Z","2014-11-12T00:00:00Z","2014-11-13T00:00:00Z","2014-11-14T00:00:00Z","2014-11-15T00:00:00Z","2014-11-16T00:00:00Z","2014-11-17T00:00:00Z","2014-11-18T00:00:00Z","2014-11-19T00:00:00Z","2014-11-20T00:00:00Z","2014-11-21T00:00:00Z","2014-11-22T00:00:00Z","2014-11-23T00:00:00Z","2014-11-24T00:00:00Z","2014-11-25T00:00:00Z","2014-11-26T00:00:00Z","2014-11-27T00:00:00Z","2014-11-28T00:00:00Z","2014-11-29T00:00:00Z","2014-11-30T00:00:00Z","2014-12-01T00:00:00Z","2014-12-02T00:00:00Z","2014-12-03T00:00:00Z","2014-12-04T00:00:00Z","2014-12-05T00:00:00Z","2014-12-06T00:00:00Z","2014-12-07T00:00:00Z","2014-12-08T00:00:00Z","2014-12-09T00:00:00Z","2014-12-10T00:00:00Z","2014-12-11T00:00:00Z","2014-12-12T00:00:00Z","2014-12-13T00:00:00Z","2014-12-14T00:00:00Z","2014-12-15T00:00:00Z","2014-12-16T00:00:00Z","2014-12-17T00:00:00Z","2014-12-18T00:00:00Z","2014-12-19T00:00:00Z","2014-12-20T00:00:00Z","2014-12-21T00:00:00Z","2014-12-22T00:00:00Z","2014-12-23T00:00:00Z","2014-12-24T00:00:00Z","2014-12-25T00:00:00Z","2014-12-26T00:00:00Z","2014-12-27T00:00:00Z","2014-12-28T00:00:00Z","2014-12-29T00:00:00Z","2014-12-30T00:00:00Z","2014-12-31T00:00:00Z"],[164,164,342,126,240,249,72,93,89,168,171,82,88,67,37,120,110,48,59,199,866,77,69,171,233,44,84,66,211,162,210,51,131,212,89,128,148,248,340,184,134,78,97,139,107,128,46,224,99,210,95,227,157,52,109,45,191,98,187,108,71,161,89,140,130,233,167,119,43,89,204,320,295,115,86,199,187,94,108,58,68,293,99,84,222,122,112,138,91,179,135,64,125,89,148,152,178,148,72,110,256,81,90,190,265,63,79,43,60,60,65,53,48,325,70,145,74,228,179,282,83,47,80,83,145,102,36,272,213,120,118,105,164,89,222,181,80,105,123,135,118,121,122,55,48,28,61,108,100,111,79,88,138,69,52,94,92,125,116,51,87,113,170,167,110,70,79,149,178,122,136,104,238,93,57,136,88,145,70,130,66,114,203,163,111,105,81,82,83,92,227,165,69,115,114,121,148,141,137,101,75,207,132,125,104,94,214,122,188,310,138,167,109,137,181,115,115,74,104,320,206,358,236,149,134,179,149,44,109,190,132,113,124,254,212,132,96,115,60,103,113,72,24,194,95,120,144,117,146,162,80,147,61,216,142,66,125,185,135,103,100,144,73,111,155,134,150,69,126,245,114,140,110,101,139,149,141,112,111,109,170,109,170,124,96,144,104,103,70,73,25,84,125,109,164,111,81,83,153,100,117,49,127,168,90,176,115,145,115,89,128,116,90,124,95,115,109,51,45,59,174,113,167,189,71,60,104,84,120,194,195,46,205,134,91,161,265,115,139,64,76,242,307,202,269,186,160,179,175,114,205,195,272,163,150,169,129,140,73,129,115,99,77,316,258]]},"evals":["attrs.interactionModel"],"jsHooks":[]}</script><!--/html_preserve-->

---

### Canadian and US population and geography

- Canada is an extremely large land mass (2nd largest country in the world), but is only the 37th largest country in terms of population

- The US ranks 4th highest in land mass and 3rd highest in population

- We can use data in the `maps` package to better visualize why these rankings exist

---

# Maps

---



```r
data(canada.cities, package = "maps")
canada_plot <- ggplot(canada.cities, aes(x = long, y = lat)) +
  coord_map("ortho") +
  geom_point(aes(size=pop, text = paste0(name, ",",
    "Pop: ", prettyNum(pop, big.mark = ",", scientific = FALSE))), 
    colour = "red", alpha = 1/2) +
  borders(regions="canada")
canada_plot
```

![](slides_to_html_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

---


```r
ggplotly(canada_plot)
```

<!--html_preserve--><div id="htmlwidget-3164" style="width:912px;height:480px;" class="plotly html-widget"></div>

---


```r
data(us.cities, package = "maps")
us_plot <- ggplot(us.cities, aes(x = long, y = lat)) +
  coord_map("ortho") +
  geom_point(aes(size=pop, text = paste0(name, ",",
    "Pop: ", prettyNum(pop, big.mark = ",", scientific = FALSE))), 
    colour = "red", alpha = 1/2) +
  borders(regions="usa", xlim = c(-200, -60), ylim = c(20, 80))
us_plot
```

![](slides_to_html_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

---


```r
ggplotly(us_plot)
```

<!--html_preserve--><div id="htmlwidget-4972" style="width:912px;height:480px;" class="plotly html-widget"></div>

---

# 3D objects

---

## New Zealand's highest volcano


```r
plot_ly(z = volcano, type = "surface")
```

<!--html_preserve--><div id="htmlwidget-6242" style="width:912px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-6242">{"x":{"data":[{"type":"surface","inherit":false,"z":[[100,100,101,101,101,101,101,100,100,100,101,101,102,102,102,102,103,104,103,102,101,101,102,103,104,104,105,107,107,107,108,108,110,110,110,110,110,110,110,110,108,108,108,107,107,108,108,108,108,108,107,107,107,107,106,106,105,105,104,104,103],[101,101,102,102,102,102,102,101,101,101,102,102,103,103,103,103,104,105,104,103,102,102,103,105,106,106,107,109,110,110,110,110,111,112,113,114,116,115,114,112,110,110,110,109,108,109,109,109,109,108,108,108,108,107,107,106,106,105,105,104,104],[102,102,103,103,103,103,103,102,102,102,103,103,104,104,104,104,105,106,105,104,104,105,106,107,108,110,111,113,114,115,114,115,116,118,119,119,121,121,120,118,116,114,112,111,110,110,110,110,109,109,109,109,108,108,107,107,106,106,105,105,104],[103,103,104,104,104,104,104,103,103,103,103,104,104,104,105,105,106,107,106,106,106,107,108,110,111,114,117,118,117,119,120,121,122,124,125,126,127,127,126,124,122,120,117,116,113,111,110,110,110,109,109,109,109,108,108,107,107,106,106,105,105],[104,104,105,105,105,105,105,104,104,103,104,104,105,105,105,106,107,108,108,108,109,110,112,114,115,118,121,122,121,123,128,131,129,130,131,131,132,132,131,130,128,126,122,119,115,114,112,110,110,110,110,110,109,109,108,107,107,107,106,106,105],[105,105,105,106,106,106,106,105,105,104,104,105,105,106,106,107,109,110,110,112,113,115,116,118,119,121,124,126,126,129,134,137,137,136,136,135,136,136,136,135,133,129,126,122,118,116,115,113,111,110,110,110,110,109,108,108,108,107,107,106,106],[105,106,106,107,107,107,107,106,106,105,105,106,106,107,108,109,111,113,114,116,118,120,121,122,123,125,127,129,130,135,140,142,142,142,141,140,140,140,140,139,137,134,129,125,121,118,116,114,112,110,110,110,111,110,109,109,108,108,107,107,106],[106,107,107,108,108,108,108,107,107,106,106,107,108,108,110,113,115,117,118,120,122,124,125,127,128,129,131,134,135,141,146,147,146,146,145,144,144,144,143,142,141,139,135,130,126,122,118,116,114,112,112,113,112,110,110,109,109,108,108,107,106],[107,108,108,109,109,109,109,108,108,107,108,108,110,111,113,116,118,120,123,125,127,129,130,132,134,135,137,139,142,146,152,152,151,151,150,149,148,148,146,145,143,142,139,135,131,127,122,119,117,115,115,115,114,112,110,110,109,109,108,107,107],[108,109,109,110,110,110,110,109,109,108,110,110,113,116,118,120,122,125,127,129,133,136,138,140,141,142,148,150,151,156,158,159,158,157,158,158,154,151,149,148,146,144,141,137,134,130,125,122,120,118,117,117,115,113,111,110,110,109,108,107,107],[109,110,110,111,111,111,111,110,110,110,112,114,118,121,123,125,127,129,133,137,141,143,145,146,148,150,154,156,159,161,162,163,164,163,164,164,160,157,154,151,149,146,144,140,137,133,129,126,124,121,119,118,116,114,112,111,110,109,108,107,106],[110,110,111,113,112,111,113,112,112,114,116,119,121,124,127,129,133,138,143,146,149,149,151,153,154,157,159,160,163,165,166,167,168,168,168,168,166,162,159,157,154,152,149,144,140,136,133,131,128,125,122,119,117,115,113,111,110,109,108,107,106],[110,111,113,115,114,113,114,114,115,117,119,121,124,126,129,133,140,145,150,154,155,155,157,159,161,162,164,165,167,168,169,170,172,174,172,172,171,169,166,163,161,158,153,148,143,140,137,134,131,128,125,120,118,116,114,112,110,109,108,107,105],[111,113,115,117,116,115,116,117,117,119,121,124,126,128,132,137,143,151,156,161,161,162,163,165,166,167,168,170,171,173,175,177,179,178,177,176,176,174,171,169,165,161,156,152,148,144,140,138,135,131,127,123,119,117,115,113,111,110,108,106,105],[114,115,117,117,117,118,119,119,120,121,124,126,128,131,137,143,150,156,160,163,165,168,170,171,172,173,174,175,177,179,180,182,183,183,183,183,180,178,177,172,168,164,160,156,152,148,144,141,138,134,130,126,121,117,114,112,110,110,108,106,104],[116,118,118,118,120,121,121,122,122,123,125,128,130,134,141,147,152,156,160,165,168,170,174,176,179,180,181,181,182,182,183,184,186,187,187,184,184,181,180,176,172,168,165,161,157,153,149,145,142,138,133,129,125,120,115,111,110,110,108,106,104],[118,120,120,121,122,123,124,124,125,126,127,129,132,135,142,149,153,157,161,166,170,174,178,180,182,183,184,184,185,186,186,187,189,189,189,189,189,186,182,179,175,171,168,165,162,157,152,149,145,141,137,131,125,120,116,111,110,110,108,106,104],[120,121,122,123,124,125,126,127,127,128,130,132,134,137,142,151,155,158,162,169,172,176,181,183,184,186,187,188,189,189,189,189,190,190,191,190,190,188,186,183,180,175,171,168,165,161,157,152,149,145,141,134,127,121,116,112,110,110,108,106,104],[120,122,125,126,126,127,128,129,130,130,132,134,136,139,145,152,157,160,167,172,175,178,181,185,186,188,190,191,192,193,193,192,192,191,192,191,191,190,190,187,184,181,177,172,169,165,161,156,152,147,143,139,131,123,119,115,111,110,108,106,105],[121,124,126,128,129,129,130,131,132,133,135,137,139,143,150,154,159,164,170,173,176,179,184,186,189,190,191,192,193,194,195,194,193,192,191,191,191,191,190,190,188,184,181,177,173,169,165,160,155,149,145,142,136,129,123,118,114,110,108,108,107],[122,125,127,130,130,131,133,134,135,136,137,140,143,147,154,158,162,166,171,174,177,181,186,189,190,190,191,192,191,191,190,189,188,189,190,190,191,190,190,190,189,186,184,181,177,173,169,164,158,152,148,144,140,134,125,118,115,111,110,108,107],[122,125,128,130,132,133,135,136,137,139,140,143,147,152,157,161,164,168,172,175,179,182,186,190,190,190,190,189,187,184,184,183,182,182,183,183,183,184,185,186,187,186,185,184,181,177,173,169,163,157,149,145,141,136,130,119,116,112,110,108,106],[123,126,129,131,133,135,137,138,139,141,143,147,150,156,161,164,167,170,173,177,181,184,187,188,190,189,187,185,183,179,176,174,174,174,174,174,176,177,179,180,182,183,182,181,181,180,176,171,166,160,152,147,142,138,133,126,121,115,110,106,105],[124,127,130,132,135,137,138,140,142,144,147,149,154,157,161,165,168,171,175,178,181,184,186,187,187,184,184,181,179,175,171,169,168,168,168,169,170,172,174,177,178,179,180,181,181,180,179,174,167,161,155,148,144,139,134,128,121,115,110,106,105],[123,128,131,133,136,138,140,142,144,146,149,151,154,157,160,164,168,172,175,178,181,183,184,184,185,183,180,177,174,170,167,165,164,164,164,165,166,168,171,175,176,178,180,181,180,180,179,177,170,163,157,150,144,139,134,128,121,115,110,108,107],[123,127,131,134,136,138,140,142,144,147,149,151,154,157,160,164,168,171,174,178,180,181,181,182,183,181,178,173,169,166,163,161,161,160,160,161,163,165,168,173,176,178,179,180,181,180,180,175,173,166,159,152,145,139,134,127,121,115,110,109,108],[120,124,128,131,134,137,139,142,144,146,149,151,153,156,160,163,167,171,174,178,180,180,180,180,180,180,175,171,167,162,160,158,157,157,157,158,159,162,166,170,175,177,178,180,181,181,180,178,175,169,160,154,148,140,134,128,121,115,110,110,109],[118,121,125,129,132,134,137,140,142,145,147,149,151,155,159,163,166,169,173,177,179,180,180,180,180,179,174,169,166,161,158,156,154,153,153,154,156,159,163,169,173,175,178,180,181,180,180,179,175,170,160,154,149,142,135,128,122,116,111,110,110],[117,120,121,125,129,132,135,138,140,143,145,147,149,153,157,160,163,166,171,174,177,179,180,180,180,179,172,168,164,160,157,154,151,149,150,150,154,158,164,169,174,178,180,180,180,180,178,177,175,170,161,153,148,142,135,129,123,116,113,112,110],[115,118,120,122,126,130,133,136,138,141,143,145,148,151,154,157,160,163,168,171,174,177,179,179,179,176,171,167,164,160,156,153,149,148,149,151,155,158,163,170,173,177,179,180,180,180,178,175,173,171,162,154,147,141,136,130,124,117,115,112,110],[114,116,118,120,122,127,131,133,136,138,141,143,146,148,151,154,157,160,164,168,171,174,178,178,179,177,173,169,165,161,157,154,151,149,150,152,155,159,166,171,175,177,179,180,180,179,176,174,171,168,159,151,146,141,135,129,124,119,116,113,110],[115,114,116,118,120,122,127,129,132,136,139,141,143,146,148,151,153,156,160,164,167,172,174,176,177,176,173,170,166,162,159,157,154,153,154,155,158,161,169,172,174,176,178,178,178,178,175,172,169,162,156,149,144,140,134,128,123,118,115,112,110],[113,113,114,116,118,120,122,125,129,133,136,138,141,143,146,149,150,153,156,160,165,170,173,176,176,176,173,172,169,165,163,160,158,157,158,159,161,166,170,170,173,175,176,178,176,173,171,168,164,158,153,146,140,137,132,127,121,117,113,111,110],[111,112,113,114,116,118,120,122,126,130,133,136,139,142,145,147,148,151,155,158,163,168,173,176,177,177,176,174,171,169,166,164,161,161,162,164,165,167,170,170,171,173,173,173,170,168,165,163,160,155,149,143,138,134,130,125,119,116,112,110,109],[110,112,113,113,114,116,118,120,123,127,131,134,137,141,143,145,148,150,154,157,161,166,171,176,178,178,178,176,174,172,170,167,167,167,166,168,170,169,168,167,168,168,168,168,167,165,163,160,156,152,146,140,136,131,128,122,118,114,110,110,109],[109,110,111,112,114,116,118,119,120,124,128,131,136,140,142,145,147,150,153,157,160,165,170,174,178,179,179,178,178,176,174,171,170,170,170,168,167,166,164,163,161,162,163,163,163,161,160,157,153,148,142,136,130,127,124,120,117,113,110,110,109],[108,109,111,112,114,116,117,118,120,121,125,128,132,138,142,144,147,149,153,156,160,164,170,174,178,180,180,179,179,178,176,172,170,170,170,168,166,164,162,160,157,156,157,158,158,156,153,151,149,144,139,130,127,124,121,118,115,112,110,110,109],[108,109,111,113,114,116,117,118,119,120,122,126,130,135,139,143,147,149,152,156,160,164,169,173,177,180,180,180,180,179,178,174,170,170,168,167,165,163,161,157,154,153,152,152,152,149,148,147,144,140,134,128,125,122,119,117,114,110,110,109,109],[107,108,111,112,114,115,116,117,119,120,121,124,128,133,137,141,145,149,152,156,160,164,168,172,176,179,180,180,180,179,178,174,170,168,166,165,163,161,158,154,150,149,148,146,145,143,143,143,140,136,130,126,123,120,118,115,112,110,110,109,109],[107,108,110,112,113,113,115,116,118,120,122,125,128,132,136,140,145,148,150,155,160,164,167,170,174,177,179,179,178,176,176,173,169,166,164,163,161,159,155,152,148,145,143,141,140,139,139,138,136,132,128,124,121,118,116,114,111,110,110,109,108],[107,108,109,111,113,114,116,117,119,120,122,125,128,132,137,141,144,146,149,152,157,162,166,168,171,173,175,175,173,172,172,171,168,165,162,160,158,156,153,149,145,142,139,138,137,136,135,133,131,129,126,122,119,117,114,112,110,110,109,108,107],[108,109,110,112,114,115,116,117,119,120,122,126,129,133,137,141,143,146,148,151,155,160,164,167,168,169,170,170,169,168,167,168,166,163,160,158,155,153,150,147,143,140,137,136,134,133,132,130,129,127,125,121,118,115,112,110,110,110,108,107,107],[109,110,111,113,115,116,117,118,120,121,123,126,129,133,138,141,143,146,148,150,155,159,163,165,166,167,168,168,166,165,164,161,160,159,158,155,152,149,147,144,141,138,135,134,132,130,129,128,126,124,122,120,117,113,111,110,110,110,108,107,107],[110,111,112,113,116,117,118,119,120,122,125,127,130,133,138,141,143,146,148,150,154,159,162,163,164,166,166,166,165,163,161,159,157,156,155,153,150,146,143,140,138,136,133,132,130,129,128,125,124,122,120,119,117,114,111,110,110,109,108,107,107],[111,112,113,114,116,117,118,119,120,123,125,128,130,134,139,141,144,146,148,151,154,158,161,164,166,167,168,166,165,163,161,158,156,154,152,150,146,142,139,137,135,133,131,130,129,128,127,125,123,121,120,118,116,113,111,110,110,109,108,107,106],[111,112,113,115,117,118,118,120,121,124,126,128,131,135,139,142,144,146,148,151,155,160,164,165,168,169,169,168,166,163,160,158,156,153,151,148,145,142,139,137,135,132,130,129,127,126,125,124,123,120,120,117,116,114,112,110,110,108,107,106,106],[112,113,114,116,117,118,119,120,122,124,127,129,132,135,139,142,144,146,149,152,157,162,167,169,170,170,170,168,165,163,161,159,157,155,151,148,145,141,139,136,134,132,130,128,127,126,124,123,122,120,119,117,116,114,112,111,109,107,106,106,105],[113,114,115,116,117,119,119,120,122,125,127,129,132,135,139,142,144,147,149,154,159,164,169,170,170,170,170,170,168,165,163,161,158,155,151,148,145,142,139,137,135,132,131,128,126,125,124,122,121,120,119,117,115,113,111,110,109,106,105,105,104],[113,114,115,117,118,119,120,121,123,125,127,130,132,135,139,142,145,148,150,156,161,166,170,170,170,170,170,170,169,166,163,161,159,155,151,148,146,143,140,138,135,134,132,130,127,125,123,121,120,120,119,116,114,112,110,110,108,106,105,104,104],[114,115,116,117,118,119,120,121,123,126,128,130,133,136,139,142,145,148,152,157,161,166,168,170,170,170,170,168,166,164,163,160,159,155,151,148,146,143,141,138,136,134,132,130,128,125,123,121,120,120,118,116,113,111,110,110,109,106,105,104,104],[115,116,117,118,119,120,121,121,123,126,128,131,134,136,139,142,145,149,152,157,161,163,164,166,168,167,166,164,163,161,160,158,156,152,149,147,144,143,141,139,136,134,132,130,128,125,122,120,120,119,117,115,113,110,110,109,107,106,105,104,104],[115,116,117,118,119,120,121,122,123,125,128,131,134,137,139,142,145,149,152,156,159,159,160,162,162,161,161,160,159,158,157,155,153,150,148,146,145,143,142,140,137,134,131,129,126,124,122,120,119,117,115,113,111,110,109,109,107,106,105,104,104],[114,115,116,116,118,119,120,121,122,126,129,132,135,137,140,143,146,149,152,155,156,157,158,159,159,159,158,158,157,155,153,151,150,149,147,146,145,144,142,141,138,135,132,128,125,122,120,118,117,115,113,112,110,109,108,108,106,105,105,104,104],[113,114,115,116,117,118,119,120,123,126,129,132,135,138,140,143,146,148,151,153,154,156,157,157,157,157,156,155,154,152,150,149,148,147,146,145,144,142,141,140,139,136,132,129,125,121,118,116,115,113,111,110,109,108,108,107,106,105,104,104,104],[112,113,114,115,116,117,119,120,122,126,130,133,136,138,141,143,146,148,150,152,154,155,155,155,155,155,154,152,152,150,148,147,146,145,145,143,142,141,140,140,140,137,133,129,125,120,117,115,111,110,110,109,108,107,107,106,105,105,104,104,103],[111,112,114,115,116,117,118,120,122,125,131,134,137,139,142,144,146,148,150,152,153,153,153,153,153,153,153,151,149,147,146,144,144,143,143,142,141,140,140,140,140,138,134,130,123,120,118,111,110,110,110,108,107,106,108,105,105,104,104,103,103],[111,112,113,115,115,116,117,119,121,126,131,135,138,140,142,144,146,148,150,151,151,151,151,151,151,151,151,150,148,146,144,142,141,141,142,141,140,140,140,140,140,140,136,132,126,120,115,110,110,110,109,107,106,105,107,105,104,104,104,103,103],[112,113,113,114,115,116,117,119,122,127,132,135,139,141,143,145,147,149,150,150,150,150,150,150,150,150,150,149,147,144,142,141,140,140,140,140,140,140,140,140,140,140,137,133,128,120,117,110,110,110,108,106,105,105,106,105,104,104,103,103,103],[112,113,114,114,116,117,118,120,122,128,132,136,139,141,144,146,147,149,150,150,150,150,150,150,150,150,150,149,146,143,141,140,140,139,139,139,140,140,140,140,140,140,137,133,129,121,118,110,110,109,107,106,105,105,105,104,104,103,103,103,102],[112,114,114,115,116,117,119,120,122,128,133,136,140,142,144,146,148,150,150,150,150,150,150,150,150,150,150,148,145,142,140,138,138,138,137,138,140,140,140,140,140,140,137,134,130,122,118,110,110,108,106,105,103,104,104,104,104,103,103,102,102],[113,114,115,116,116,117,118,120,123,129,133,137,140,142,144,146,149,150,150,150,150,150,150,150,150,150,150,147,143,141,139,137,136,136,135,136,138,140,140,140,140,139,136,134,130,123,119,113,109,108,106,104,103,104,104,104,103,103,102,102,101],[114,115,115,116,117,118,118,120,123,129,133,137,140,143,145,147,150,150,150,150,150,150,150,150,150,150,148,145,142,139,138,136,135,134,134,134,136,138,137,138,139,137,134,132,125,122,117,114,109,107,105,103,102,104,104,103,103,102,102,101,101],[114,115,116,117,117,119,118,120,123,128,132,136,139,142,145,148,150,150,150,150,150,150,150,150,150,150,147,144,141,139,136,135,134,133,132,132,134,134,134,134,135,133,131,128,124,120,116,113,110,107,104,102,102,103,103,103,102,102,102,101,100],[115,116,116,117,118,119,119,120,124,128,132,136,139,142,145,148,150,150,150,150,150,150,150,150,150,149,146,143,140,138,135,134,133,131,131,131,131,131,131,131,130,127,124,122,119,117,115,112,109,106,104,101,102,103,103,102,102,102,101,100,100],[115,116,117,118,118,119,120,123,125,128,131,135,138,141,145,148,150,150,150,150,150,150,150,150,150,147,145,142,139,137,134,132,131,130,129,128,128,128,128,128,126,123,121,119,116,114,112,110,108,105,103,101,103,103,103,102,102,101,100,100,100],[116,117,118,118,119,120,122,123,125,128,131,134,137,141,145,148,149,150,150,150,150,150,150,150,148,145,143,141,138,135,133,130,129,128,127,126,125,125,125,124,123,120,118,116,114,111,109,107,106,104,102,100,101,101,102,102,101,100,100,100,100],[116,117,118,119,120,121,123,124,126,128,130,133,137,140,144,145,147,148,149,150,149,149,147,146,144,141,139,136,133,131,129,128,127,126,125,124,123,123,122,121,120,118,116,114,112,108,107,105,103,102,100,100,100,100,101,101,100,100,100,100,100],[117,118,119,119,120,121,123,124,126,128,129,131,135,139,142,143,145,146,147,147,147,146,144,142,140,138,135,133,130,128,127,126,125,124,123,122,121,120,119,118,117,115,114,112,110,106,105,102,101,100,100,100,100,100,100,100,100,99,99,99,99],[117,118,119,120,120,121,123,124,125,126,128,129,132,137,140,142,143,143,144,144,144,143,141,139,137,135,133,130,128,127,126,125,123,122,121,120,119,117,116,115,114,112,111,108,107,105,100,100,100,100,100,100,100,99,99,99,99,99,99,99,98],[116,117,118,120,120,121,122,123,124,125,126,128,130,134,139,140,141,141,141,141,141,140,138,136,134,133,131,129,127,125,124,123,122,120,119,118,117,116,114,112,111,108,109,106,106,100,100,100,100,100,99,99,99,99,99,99,99,98,98,98,97],[114,115,116,117,119,119,120,121,122,123,125,127,129,133,136,134,134,136,138,138,137,137,135,133,132,130,129,127,125,124,122,121,120,119,117,116,115,114,112,110,109,108,107,105,105,100,100,100,100,99,99,99,98,98,98,98,98,97,97,97,97],[112,113,114,115,116,116,117,119,120,122,124,126,127,129,129,128,127,129,132,133,133,133,133,131,129,127,126,125,124,122,121,119,118,117,116,114,113,112,110,109,108,106,106,105,100,100,100,98,98,98,98,98,98,97,97,97,97,97,97,97,96],[109,111,112,112,113,113,113,114,116,119,121,123,124,125,124,123,123,123,125,127,129,129,128,128,127,125,124,123,122,121,119,118,117,116,114,113,112,110,109,108,107,106,105,100,100,100,97,97,97,97,97,97,97,96,96,96,96,96,96,96,96],[106,107,108,108,109,110,110,112,113,114,117,119,120,121,119,117,117,117,118,120,123,124,125,125,125,123,121,120,120,119,118,117,116,115,114,113,111,109,109,107,106,105,100,100,100,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96],[104,105,105,106,106,107,108,108,109,109,111,115,116,114,113,112,111,110,111,113,116,119,122,122,122,121,120,119,118,118,117,116,115,114,113,112,111,108,108,106,105,100,100,100,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96],[102,103,103,104,104,105,106,106,107,108,109,111,112,110,109,108,108,108,108,109,110,112,116,117,117,118,118,118,117,116,116,115,114,113,112,111,110,107,107,105,100,100,100,97,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96],[101,102,103,103,104,105,105,106,106,107,108,109,109,107,106,106,105,105,105,106,107,108,109,110,111,113,114,115,115,115,114,113,112,111,110,108,108,106,105,100,100,100,97,97,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96],[100,101,102,102,103,103,104,104,105,106,106,107,106,106,106,105,105,104,103,103,104,105,107,108,110,111,111,112,112,113,113,112,111,110,108,107,106,105,100,100,100,98,97,97,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96],[100,101,101,102,102,103,103,104,104,105,105,105,105,106,105,105,104,103,102,101,102,103,104,106,107,110,111,111,111,112,112,112,110,107,107,106,105,102,100,100,99,98,97,97,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,95],[99,100,101,102,102,103,103,103,104,104,104,104,103,104,104,104,104,102,101,101,102,103,104,105,107,110,111,111,111,111,111,111,108,106,105,105,102,101,100,99,99,98,97,97,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,95,95],[99,100,100,101,101,102,102,102,103,103,103,103,102,103,103,104,103,102,101,101,101,102,103,104,106,109,110,111,111,111,110,110,107,105,103,104,100,100,99,99,98,98,97,97,96,96,96,96,96,96,96,96,96,96,95,95,95,95,95,95,95],[99,100,100,100,101,101,101,102,102,103,102,102,101,102,102,103,103,101,101,100,101,101,102,103,105,109,110,110,111,110,110,109,106,105,100,102,100,99,99,99,98,98,97,97,96,96,96,96,96,96,95,95,95,95,95,95,95,95,95,95,94],[99,99,99,99,100,100,101,101,102,102,101,101,101,101,101,102,102,101,100,100,101,101,101,103,104,107,109,109,110,110,109,108,105,102,100,100,99,99,99,98,98,98,97,96,96,96,96,96,95,95,95,95,95,95,95,94,94,94,94,94,94],[98,99,99,99,99,100,100,101,101,102,101,100,100,100,101,101,101,100,100,100,100,101,101,101,103,106,107,109,109,109,109,107,104,101,100,99,99,99,98,98,98,97,96,96,96,96,95,95,95,95,95,95,95,94,94,94,94,94,94,94,94],[98,98,98,99,99,99,100,100,101,101,100,100,99,99,100,100,100,100,100,100,100,101,101,101,102,105,106,109,108,109,107,105,102,100,100,99,99,98,98,98,97,96,96,96,96,95,95,95,95,95,95,94,94,94,94,94,94,94,94,94,94],[97,98,98,98,99,99,99,100,100,100,100,100,99,99,99,100,100,100,100,100,100,100,101,101,101,103,104,105,106,105,104,101,100,100,99,99,98,98,97,97,97,96,96,96,95,95,95,95,95,94,94,94,94,94,94,94,94,94,94,94,94],[97,97,97,98,98,99,99,99,100,100,100,99,99,99,99,99,100,100,100,100,100,100,101,101,100,100,100,100,100,100,100,100,100,100,99,99,98,97,97,97,96,96,96,95,95,95,95,94,94,94,94,94,94,94,94,94,94,94,94,94,94]],"colorbar":{"title":"volcano"},"colorscale":[[0,"#440154"],[0.111111111111111,"#482878"],[0.222222222222222,"#3E4A89"],[0.333333333333333,"#31688E"],[0.444444444444444,"#26828E"],[0.555555555555556,"#1F9E89"],[0.666666666666667,"#35B779"],[0.777777777777778,"#6DCD59"],[0.888888888888889,"#B4DE2C"],[1,"#FDE725"]]}],"layout":{"scene":{"zaxis":{"title":"volcano"}},"margin":{"b":40,"l":60,"t":25,"r":10}},"url":null,"width":null,"height":null,"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

---

# Interactive Data Tables

---


```r
datatable(iris, options = list(pageLength = 5))
```

<!--html_preserve--><div id="htmlwidget-1170" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1170">{"x":{"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5,7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7,6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],[3.5,3,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3,3,4,4.4,3.9,3.5,3.8,3.8,3.4,3.7,3.6,3.3,3.4,3,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.6,3,3.4,3.5,2.3,3.2,3.5,3.8,3,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2,3,2.2,2.9,2.9,3.1,3,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3,2.8,3,2.9,2.6,2.4,2.4,2.7,2.7,3,3.4,3.1,2.3,3,2.5,2.6,3,2.6,2.3,2.7,3,2.9,2.9,2.5,2.8,3.3,2.7,3,2.9,3,3,2.5,2.9,2.5,3.6,3.2,2.7,3,2.5,2.8,3.2,3,3.8,2.6,2.2,3.2,2.8,2.8,2.7,3.3,3.2,2.8,3,2.8,3,2.8,3.8,2.8,2.8,2.6,3,3.4,3.1,3,3.1,3.1,3.1,2.7,3.2,3.3,3,2.5,3,3.4,3],[1.4,1.4,1.3,1.5,1.4,1.7,1.4,1.5,1.4,1.5,1.5,1.6,1.4,1.1,1.2,1.5,1.3,1.4,1.7,1.5,1.7,1.5,1,1.7,1.9,1.6,1.6,1.5,1.4,1.6,1.6,1.5,1.5,1.4,1.5,1.2,1.3,1.4,1.3,1.5,1.3,1.3,1.3,1.6,1.9,1.4,1.6,1.4,1.5,1.4,4.7,4.5,4.9,4,4.6,4.5,4.7,3.3,4.6,3.9,3.5,4.2,4,4.7,3.6,4.4,4.5,4.1,4.5,3.9,4.8,4,4.9,4.7,4.3,4.4,4.8,5,4.5,3.5,3.8,3.7,3.9,5.1,4.5,4.5,4.7,4.4,4.1,4,4.4,4.6,4,3.3,4.2,4.2,4.2,4.3,3,4.1,6,5.1,5.9,5.6,5.8,6.6,4.5,6.3,5.8,6.1,5.1,5.3,5.5,5,5.1,5.3,5.5,6.7,6.9,5,5.7,4.9,6.7,4.9,5.7,6,4.8,4.9,5.6,5.8,6.1,6.4,5.6,5.1,5.6,6.1,5.6,5.5,4.8,5.4,5.6,5.1,5.1,5.9,5.7,5.2,5,5.2,5.4,5.1],[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2,1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3,2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],["setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> \u003c/th>\n      <th>Sepal.Length\u003c/th>\n      <th>Sepal.Width\u003c/th>\n      <th>Petal.Length\u003c/th>\n      <th>Petal.Width\u003c/th>\n      <th>Species\u003c/th>\n    \u003c/tr>\n  \u003c/thead>\n\u003c/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":[1,2,3,4]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]},"callback":null,"filter":"none"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

---

## Another data table example

[RA Duty Scheduling](http://rpubs.com/cismay/ra_schedule_s2016)

---

## Other resources

[Plotting maps in R with `ggplot2`](https://github.com/dkahle/ggmap)

[HTML Widgets for R](http://www.htmlwidgets.org)

[Leaflet package for R](https://rstudio.github.io/leaflet/)

[GapMinder (now owned by Google)](http://www.google.com/publicdata/directory)

[Hans Rosling's TED talk - "The Best Stats You've Ever Seen"](https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen?language=en)

---

## What can I help you with?

> - Data analysis
> - Data wrangling/cleaning
> - Data visualization
> - Data tidying/manipulating
> - Reproducible research

---

## When am I available?

> - Email me at cismay@reed.edu or chester.ismay@reed.edu to schedule a time to meet if office hours don't work
> - Tentative Spring 2016 office (ETC 223) hours
>     - Mondays (10 AM to 11 AM)
>     - Tuesdays (2 PM to 3 PM)
>     - Wednesdays (1:30 PM to 2:30 PM)
> - Sometimes available for virtual office hours via Google Hangouts (email me for details)

---

# Thanks! 

<br>

<font size="7">cismay@reed.edu</font>

<br>

>- Code for slide creation on [my GitHub page](https://github.com/ismayc/Reed_WoRkshops/tree/master/Paideia_interactive_dataviz_2016)
>- Slides available [here](http://rpubs.com/cismay/paideia_2k16_idv)

---


```r
sessionInfo()
```

```
## R version 3.2.4 (2016-03-10)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: OS X 10.11.4 (El Capitan)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] DT_0.1                  googleVis_0.5.10        maps_3.1.0              xts_0.9-7              
##  [5] zoo_1.7-12              readr_0.2.2             knitr_1.12.3            dplyr_0.4.3.9001       
##  [9] dygraphs_0.8            pnwflights14_0.1.0.9000 plotly_3.4.1            ggplot2_2.1.0          
## [13] revealjs_0.6           
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.3        RColorBrewer_1.1-2 formatR_1.3        plyr_1.8.3         base64enc_0.1-3   
##  [6] viridis_0.3.4      tools_3.2.4        digest_0.6.9       jsonlite_0.9.19    evaluate_0.8.3    
## [11] tibble_1.0         gtable_0.2.0       lattice_0.20-33    DBI_0.3.1          mapproj_1.2-4     
## [16] yaml_2.1.13        gridExtra_2.2.1    httr_1.1.0         stringr_1.0.0.9000 htmlwidgets_0.6   
## [21] grid_3.2.4         R6_2.1.2           rmarkdown_0.9.5.9  RJSONIO_1.3-0      tidyr_0.4.1       
## [26] magrittr_1.5       scales_0.4.0       htmltools_0.3      assertthat_0.1     colorspace_1.2-6  
## [31] labeling_0.3       stringi_1.0-1      lazyeval_0.1.10    munsell_0.4.3
```
