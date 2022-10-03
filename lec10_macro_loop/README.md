# Lecture 10: Macros, loops, and stored results

## Motivation

A well-written do file is clear, well-structured, and generally written enough to be able to deal with the slight changes of the data flexibly. It is way too tiring to rewrite your code each time when the data changes, i.e. if you get a new wave of survey data, you should drop some observations during the cleaning process etc. So, it is worth learning coding trick that helps generalization.   

## This lecture

In this lecture we discuss the most important solutions for generalizing your code and make your analysis easily reproducible. 

## Learning outcomes
After successfully completing the code in `lecture10_macroloop.do` students should be able to:

  - Deal with global and local macros.
  - Apply loops in order to make repetitive tasks clear and compact.
  - Use stored results to make their code general and reproducible.

## Datasets used

* [wms_da_textbook-xsec.dta](https://osf.io/qx4fn)
* [Football raw data as homework](https://osf.io/zqm6c/)

## Lecture Time

Ideal overall time: **90 mins**.

## Homework

*Type*: longer practice, approx 40 mins

Exercise 1
In Exercise 1 you use the football data that is introduced in case studies of Chapter 2, and is also used in Chapter 3. The game-level data is available originally in yearly .csv files, which can be found in the ‚Äúraw‚Äù folder at [OSF](https://osf.io/zqm6c/). Your task is to take all these .csv files (fdata_pl_2008.csv, ..., fdata_pl_2018.csv) and combine them into one .dta file. 

Exercise 2
In Exercise 2 you use the [wms_da_textbook-xsec.dta](https://osf.io/qx4fn) that we used in the lecture. Create a frequency table for each year showing the distribution of the industry code, -sic-, variable for those observations that have a larger -degree_t- score than its median value for that particular year.

## Detailed online descriptions for the most important commands from the Stata website

  - [Macros](https://www.stata.com/manuals/pmacro.pdf) 
  - [The forvalues loop](https://www.stata.com/manuals/pforvalues.pdf)
  - [The foreach loop](https://www.stata.com/manuals/pforeach.pdf)
  - [Stored results](https://www.stata.com/manuals/rstoredresults.pdf)

## Further material

  - The [relevant part](https://sscc.wisc.edu/sscc/pubs/stata_prog1.htm) of SSCC's Stata for student course gives a detailed description of macros and loops.

  - The [6th lesson](https://datacarpentry.org/stata-economics/06-loops/index.html) of Data Carpentry's Economics Lesson with Stata course offers a detailed description of loops with many exercises.

  - The first part of [Section 4](https://data.princeton.edu/stata/programming) of Germ·n RodrÌguez's Stata Tutorial course describes macros and loops. The second part of the section is also worth reading since it containts further elements of Stata programming.
