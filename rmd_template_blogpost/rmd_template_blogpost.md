
"Science is reportedly in the middle of a reproducibility crisis."  This is the claim of quite a few these days including an article from [ROpenSci](https://ropensci.org/blog/2014/06/09/reproducibility/) which directly references another article by [The Conversation](http://theconversation.com/science-is-in-a-reproducibility-crisis-how-do-we-resolve-it-16998).  But what is "reproducible research" and how can statistical tools be used to help facilitate it?

I agree with Roger Peng and the folks behind Coursera's massively popular  Data Science Specialization and the front page of their [Reproducible Research course](https://www.coursera.org/course/repdata) on their definition of "reproducible research":

> Reproducible research is the idea that data analyses, and more generally, scientific claims, are published with their data and software code so that others may verify the findings and build upon them.  The need for reproducibility is increasing dramatically as data analyses become more complex, involving larger datasets and more sophisticated computations. Reproducibility allows for people to focus on the actual content of a data analysis, rather than on superficial details reported in a written summary. In addition, reproducibility makes an analysis more useful to others because the data and code that actually conducted the analysis are available. 

One of the goals at Reed is for students to be engaged in the research process earlier on in their academic careers in order to make their senior thesis experience more meaningful and rewarding.  The collecting and analysis of data has been a challenging part of the process.  Additionally, updating analyses and bibliographies as advisors request has been time consuming and frustrating.

So how does this tie into the reproducible research concept?  As more and more students use *R Markdown* while taking courses at Reed (Chem 101/102, Mathematics 141, Mathematics 243, and Bio 101/102 next year!), it became clear that a nice option for students writing their theses would to also be able to use *R Markdown* and the simplicity of *Markdown* commands and improved readability to create their thesis document.

*R Markdown* provides a wonderful environment to publish data and software code along with text and commentary and, in my opinion, is the best software currently available for writing journal articles, homework assignments, **AND** senior theses....reproducible senior theses!

What I'll be discussing in this blog post is a template I've created using *R Markdown* for Reed College senior theses.  This template derives a lot of the features of the current \LaTeX\ template (in fact it directly calls this template) so you can expect many of the great things about that including automatic creation of figure and table numbers, a table of contents, easy addition of beautiful plots and graphics, and the use of bibiolography style files.  (Do you really want to have to memorize what APA or MLA looks like?...No!)  In addition, you won't need to learn \LaTeX.  I've done the hard work of getting all that set up.  You only need to learn *Markdown*.  (Don't worry.  That's really not hard!)

### Markdown

*Markdown* allows you to write in an easy-to-read, easy-to-write plain text format, which then converts to a variety of different formats.  (*R Markdown* which is really just *Markdown* with the ability to add in *R* code and output directly allows you to produce HTML, PDF, and even Word documents!  The sky is the limit for *Markdown*!)  I'm going to cover just a few of the ways to produce some basic writing using *Markdown* below.  

The template will automatically convert the *Markdown* code you type to \LaTeX\ code which will then produce a PDF document.  Again, I've done the hard work of getting this *Markdown* code to produce the correct output.

Now, back to *Markdown* basics.  You can find a lot more information on *Markdown* [here](https://help.github.com/articles/markdown-basics/) and an interactive tutorial [here](http://markdowntutorial.com/).  You'll get used to it before you know it.  Probably in less than an hour!

### Install the package

After you've stepped through the basics of _Markdown_, it's time to check out this template for yourself.  Make sure you have RStudio and \LaTeX\ installed and then direct your browser to the GitHub page for the template: <http://github.com/ismayc/rticles>.  You'll see instructions there in the `README.md` file near the bottom of the page.  As you see there, you'll want to install the `rticles` package via the following commands:


```r
install.packages("devtools")
devtools::install_github("ismayc/rticles")
```

This allows for **Reed Senior Thesis** to be an option when you create a New R Markdown file via the File -> New File -> R Markdown dialog.  Specify the name you would like to give the file and also the location where you'd like the template and its files to be stored.  I've called it "MyReedThesis" in what follows.  After hitting the OK button, you'll see an Rmd file load up onto your RStudio window.  

If you click on the folder you've just created in the Files tab in RStudio, you can see a lot of files that have been created to assist you.  You will see Rmd files for the abstract, bibliography, different chapters, and conclusion, and your main Rmd file (`MyReedThesis.Rmd` for me).  You also see folders that hold your bibliography database files (`bib`), bibliography style files (`csl`), data files (`data`), and images (`figure`).  You'll find that I've preloaded a bibliography database file (`thesis.bib`), an American Psychological Association (APA) style file (`apa.csl`) from the [Zotero Style Repository](https://www.zotero.org/styles), a dataset derived from departing flights from Seattle and Portland in 2014 (`flights.csv`), and a couple figures in the `figure` folder.

If you click on the **Knit** button near the top of the RStudio window on your main Rmd file, a PDF linking together all of the files will be created.  I've tried to show you how to do a variety of things in this `Markdown` template including

**In the Introduction**

- Creating a different headers including a chapter using the `#` syntax, a section using `##`, a subsection using `###`, etc.
- Bolding of text by surrounding the text in `**` or `__`
- Adding a comment using the `<!--` and `-->` syntax

**In Chapter 1**

- Easily creating numbered or non-numbered lists
- Using whitespace to create a new paragraph in your output
- Including **R** code in chunks to be added into your document
- Specifying different chunk options to tweak the output
- Using inline **R** code for calculations and directly referring to **R** results in the text of your document
- Including plots created in **R**
- Creating tables based on data stored in **R**
- Creating hyperlinks to web resources

**In Chapter 2**

- Including mathematical equations
- Using \LaTeX\ to create chemical reaction equations
- Adding other discipline specific content to your theses

**In Chapter 3**

- Creating tables using _Pandoc_ 
- Labelling and referencing tables and figures (both created in **R** and stored in files) using custom **R** functions I created
- Adding footnotes into your document
- Developing bibliography database files using Zotero (highly recommended) or other programs like BibDesk

**In the Conclusion**

- Making a few tweaks to how chapters are displayed
- Creating appendices if desired

Lastly, in the `bibliography.Rmd` file, you'll find ways to currently fix the hanging indent issue with some citation styles.  (You might need to delete a few lines if your style doesn't require hanging indents.)  I also provide a way to cite sources in your bibliography at the end of the document that you don't directly cite throughout your thesis here.

### The main driver R Markdown file

If you go back to the main Rmd file, you'll see a lot of text that is commented out.  This provides more information about what is happening in this file.  In summary, this file links all of the chapter files together creates a way to input the preliminaries (the abstract, the preface, etc.) as either inline at the top of the document or in a file stored like `abstract.Rmd`.  You'll also change your name, your advisor's name and other metadata here. One last thing:  `lot` stands for "List of Tables" and `lof` stands for "List of Figures".  These are automatically created when you include a table or a figure into your theses.  

Currently, everything links throughout the document as well.  When you make a reference to `Figure 3.1` in Chapter 2, you can click on that link in the PDF and it will go directly to that figure.  Chapters and sections are also linked in this same fashion.

There will be slight modifications (hopefully only slight if any at all!) occurring to this document as students and faculty test it.  I highly recommend running the `devtools::install_github("ismayc/rticles")` from time to time to make sure you have the latest version of the template.  You can easily copy your files into the new template as needed.  (Some of the changes may occur to \LaTeX\ files that you won't directly access.)

I'm hopeful that this template will be of great use to seniors throughout Reed College this year and in years to come.  Science majors may get the most immediate benefit, but I believe that _Markdown_ is an incredible valuable language to learn.  It's easy and extremely flexible in the type of output it can produce.  I've written this template to be as user friendly as possible and I hope that non-science majors will consider using it!  If you have any questions, feedback, or would like to report any issues, please (email me)[cismay@reed.edu].

(The generating R Markdown file for this HTML document---saved in the .Rmd extension---is available [here](http://reed.edu/data-at-reed/software/R/blogposts/tables_blogpost.Rmd).)