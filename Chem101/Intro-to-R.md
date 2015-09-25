---
title: "Introduction to R"
subtitle: "Why It's Cool"
author: Chester Ismay, Instructional Technologist for Quantitative Applications
date: September 11, 2015
output:
  ioslides_presentation:
    logo: griffin.png # http://www.reed.edu/biology/professors/srenn/pages/teaching/web_2007/emmylinh/images/griffin.svg.png
---

## About me

<img src="https://avatars1.githubusercontent.com/u/163582?s=200" align="right" />

> - http://yihui.name
> - first language: Chinese
> - second language: R (10 years)
> - third language: English
> - graduated from Iowa State Univ (Stats, 2013)
> - joined RStudio
> - (co-)author and maintainer of some R packages (e.g. animation, knitr, cranvas, formatR, testit, highr, Rd2roxygen, fun, servr, tikzDevice, shiny, evaluate, markdown)
> - initiated the Chinese R Conference in 2008 (7th this year)
> - Capital of Statistics (http://cos.name)

# Dynamic Documents

## I know you click, click, copy and paste

![](http://i.imgur.com/tYxVO4w.jpg)

## But imagine you hear these words after you finished a project {.build}

**Please do that again!** (sorry we made a mistake in the data, want to change a parameter, and yada yada)

![](http://i.imgur.com/9g5M6Hq.gif)

## Basic idea

- code + narratives = report
- i.e. computing languages + authoring languages

        We built a linear regression model.

        ```{r}
        fit <- lm(dist ~ speed, data = cars)
        b   <- coef(fit)
        plot(fit)
        ```

        The slope of the regression is `r b[1]`.
- an example

## knitr

- an R package (`install.packages('knitr')`)
- document formats
    - .Rnw (R + LaTeX)
    - .Rmd (R + Markdown)
    - any computing language + any authoring language (in theory)
- editors
    - RStudio
    - LyX
    - Emacs/ESS
    - ...

# One world, many dreams | worse, one world == one (MS) Word? {.build}

```tex
\section{Introduction}

We did a \emph{cool} study.
```

```html
<h1>Introduction</h1>

<p>We did a <em>cool</em> study.</p>
```

## Markup Languages

<div class="centered">
![](http://i.imgur.com/38KAMOH.gif)
</div>

## Two extremes

- LaTeX: precise control, full complexity, horrible readability
- Markdown: simple, simple, simple

<div class="columns-2">
```latex
\section{Introduction}

We did a \emph{cool} study,
and our main findings:


\begin{enumerate}
\item You can never remember
  how to escape backslashes.
\item A dollar sign is \$,
  an ampersand \&, and
  a \textbackslash{}.
\item How about ~? Use $\sim$.
\end{enumerate}
```

```markdown
# Introduction

We did a _cool_ study, and
our main findings:

1. You do not need to remember
  a lot of rules.
2. A dollar sign is $,
  an ampersand is &, and
  a backslash \.
3. A tilde is ~.

Write content instead of
markup languages.
```
</div>

## Or a graphical comparison {.build}

LaTeX

![](http://i.imgur.com/lO1b04M.gif)

Markdown

![](http://i.imgur.com/teZV0Ru.gif)

# Is Markdown too simple? | probably, but the real question is

# How much do you want? | do you really want _that_ word to be in \\textbf{\\textsf{}}? {.build}

<div class="centered">
![](http://i.imgur.com/vGwGF7s.gif)
</div>

## Challenge: do this in LaTeX

- the [`docco_classic` style](http://cran.rstudio.com/web/packages/knitr/vignettes/docco-classic.html)
- [gitbook](http://gitbook.io)
- the challenges do not really make much sense
    - LaTeX is for printing
    - HTML is not as powerful in terms of typsetting (not bad either!), but is excellent for interaction

# The evolution of R Markdown

## R Markdown v1: how can I convert Markdown to Word?

We used to tell them "go to Pandoc".

<div class="centered">
![](http://i.imgur.com/G07twm2.gif)
</div>

## R Markdown v2

Now _we go to Pandoc_ and solve the problem directly.

<div class="centered">
![](http://i.imgur.com/OHCXj1m.gif)
</div>

## Markdown with Pandoc

<div class="centered">
![](http://i.imgur.com/mGLCGbx.jpg)
</div>

## Original Markdown

- primarily for HTML
- paragraphs, `# headers`, `> blockquotes`
- phrase `_emphasis_`
- `- lists`
- `[links](url)`
- `![images](url)`
- code blocks

## Pandoc's Markdown

- markdown extensions
    - tables
    - LaTeX math `$\sum_{i=1}^n \alpha_i$` = $\sum_{i=1}^n \alpha_i$
    - YAML metadata
    - raw HTML/LaTeX

            <div class="my-class">
              ![image](url)
            </div>

            _emphasis_ and \emph{emphasis}

    - footnotes `^[A footnote here.]`
    - citations `[@joe2014]`

## Pandoc's Markdown (cont'd)

- types of output document
    - LaTeX/PDF
    - beamer
    - HTML
    - ioslides
    - reveal.js
    - Word (MS Word, OpenOffice)
    - E-books
    - ...

# rmarkdown

## The rmarkdown package

- we used to call **knitr** and Pandoc separately

    ```r
    # in R
    library(knitr)
    knit('input.Rmd')
    # in command line
    pandoc -to beamer -o output.pdf --smart input.md
    ```

- do you want to mess with
    - Pandoc's 73 command line arguments?
    - knitr's 49 chunk options?
- **rmarkdown** provides wrappers that produce reasonably beautiful output by default
    - [Bootstrap 3](http://getbootstrap.com/) and [themes](http://bootswatch.com/)
    - highlight.js

## Installation and usage

- http://rmarkdown.rstudio.com
- **rmarkdown** and Pandoc are currently shipped with RStudio preview version
- can be used as a standalone package as well (require separate Pandoc installation)

    ```r
    library(rmarkdown)
    render('input.Rmd')
    render('input.Rmd', pdf_document())
    render('input.Rmd', word_document())
    render('input.Rmd', beamer_presentation())
    render('input.Rmd', ioslides_presentation())
    ```

## YAML metadata

```yaml
---
title: "Sample Document"
output:
  html_document:
    toc: true
    theme: united
---
```

This is equivalent to:

```r
rmarkdown::render('input.Rmd',
    html_document(toc = TRUE, theme = 'united'))
```

## What is `html_document()`


```r
str(rmarkdown::html_document(), 2)
```

```
## List of 7
##  $ knitr                  :List of 3
##   ..$ opts_knit : NULL
##   ..$ opts_chunk:List of 5
##   ..$ knit_hooks: NULL
##  $ pandoc                 :List of 5
##   ..$ to      : chr "html"
##   ..$ from    : chr "markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash-implicit_figures"
##   ..$ args    : chr [1:8] "--smart" "--email-obfuscation" "none" "--self-contained" ...
##   ..$ keep_tex: logi FALSE
##   ..$ ext     : NULL
##  $ keep_md                : logi FALSE
##  $ clean_supporting       : logi TRUE
##  $ pre_processor          :function (...)  
##  $ intermediates_generator:function (original_input, encoding, intermediates_dir)  
##  $ post_processor         :function (metadata, input_file, output_file, clean, verbose)  
##  - attr(*, "class")= chr "rmarkdown_output_format"
```

## Output format is extensible

```yaml
title: "Sample Document"
output:
  my_nice_document:
    fig_width: 8
    toc: true
```

`my_nice_document()` is your own function that returns a list of **knitr** and Pandoc options.

# RStudio IDE support

## You do not have to remember everything

- new markdown document wizard
- setting YAML metadata
- one-click compilation
- navigation between Rmd source and slides

# Demo

# Customize printing

## The `knit_print()` function

- the new chunk option `render = knit_print` by default
- currently in the development version (will appear in knitr 1.6 on CRAN): https://github.com/yihui/knitr
- an S3 generic function
- you can define how to "print" your objects
- by default it is approximately equal to `print()`

## Example: print data frames as tables by default


```r
library(knitr)
# define a method for objects of the class data.frame
knit_print.data.frame = function(x, options) {
  res = paste(c('', '', kable(x, output = FALSE)), collapse = '\n')
  asis_output(res)
}
```

## Shiny

- an R package for interactive web applications
- http://shiny.rstudio.com
- `shiny::runExample('01_hello')`

## Where shiny meets knitr

- a document is both dynamic and interactive
- knitr: R Markdown --> Markdown
- rmarkdown: Markdown --> HTML
- shiny: HTML <--> R
- demo

## The goal {.build}

You have done the hard work of research, data collection, and analysis, etc. We hope the last step can be easier.

<div class="centered">
![](http://i.imgur.com/IwhhHY8.gif)
</div>

## Try it yourself!

Don't just believe everything I said...

![](http://i.imgur.com/sbog0SS.gif)
