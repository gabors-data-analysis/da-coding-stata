# Lecture 07: Data manipulation

## Motivation

Finishing the exploratory data analysis, we almost always go on with the deeper analysis, i.e. statistical or econometric analysis: looking for association between variables, testing hypotheses, and executing regressions. Although, one important step is still missing. During the exploratory data analysis, we may realize that some values of variables are wrong, so they need to be cleaned; or theory suggests that there is a non-linear relationship between variables, so we need to use the natural logarithm of them etc. In general, we need to do some data manipulation: changing the values of existing variables, producing new variables, deleting variables etc. This data manipulation is the topic of this lecture.


## This lecture

In this lecture we discuss the most important commands of data manipulation.

Case studies (at least partly) connected to this lecture:
  - [Chapter 04, 4.A1: Management Quality and Firms Size: Describing Patterns of Association](https://gabors-data-analysis.com/casestudies/#ch04a-management-quality-and-firm-size-describing-patterns-of-association)

This lecture uses the [hotels-vienna.dta](https://osf.io/dn8je) dataset.

## Learning outcomes
After successfully completing the code in `lecture05_eda.do` students should be able to:

  - Calculate standard measures of central value and spread (mean, minimum, maximum, median, quantiles, mode, range, interquartile range, standard deviation, variance etc.).
  - Make histograms, box plots and violin plots (without scaffolding since we discuss it in a latter lecture.)
  - Deal with subsamples using the if condition and the bysort prefix.

## Datasets used

* [wms_da_textbook-xsec.dta]("https://osf.io/qx4fn/")

## Lecture Time

Ideal overall time: **70mins**.

## Homework

*Type*: quick practice, approx 30 mins

In this homework you are invited to use the WMS dataset, and do some data manipulation. Do the following exercises step by step:
  - Define a default folder.
  - Open wms_da_textbook-xsec.dta.
  - As it is mentioned in Case Study 4.A1 (pp. 99), the measure of quality of management is the simple average of the 18 score variables (lean1, lean2, perf1, …, perf10, talent1, … talent6). Check it by producing a new variable containing the average of the 18 score variables and compare it with the management score variable. If the original management score variable seems to be okay, you can delete the variable you produced.
  - Generate a numerical identifier for the countries.
  - Generate a dummy variable, called postcrisis that equals to 1 if the observation was surveyed after 2009, and 0 otherwise.
  - Produce a new variable that contains the average management score before and after the crisis (use the variable you produced in the previous point) for each country.
  - Create a new variable that contains the value of the previously created average management score rounded to two decimals.
  - In the next few steps, you will reproduce some results from Case Study 4.A1: Management Quality and Firms Size: Describing Patterns of Association.
     - Keep the Mexican firms from the 2013 wave of the survey.
     - Drop firms with fewer than 100 or more than 5000 employees.
     - Produce three new variables, containing (i) the average, (ii) the median, and (iii) the standard deviation of the management score.
     - Figure 4.1 (pp. 99) shows the histogram of the management score. You do not have to reproduce the histogram but produce a new variable that shows which bin (the histogram contains 20 bins: 0-0.25, 0.25-0.5, …, 4.75-5.00) does the particular observation belong to.

## Detailed online descriptions for the most important commands from the Stata website

  - [An introduction to creating new variables](https://www.stata.com/manuals/gsw11.pdf) 
  - [generate](https://www.stata.com/manuals/dgenerate.pdf)
  - [egen](https://www.stata.com/manuals/degen.pdf)
  - [An introduction to deleting variables and observations](https://www.stata.com/manuals/gsw12.pdf)
  - [destring](https://www.stata.com/manuals/ddestring.pdf)