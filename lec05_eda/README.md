# Lecture 05: Exploratory data analysis

## Motivation

After data wrangling the next step is exploratory data analysis (EDA) that is made due to five main reasons:
 - To know whether your data is clean and ready for analysis.
 - To guide subsequent analysis.
 - To give context.
 - To spare further effort on analysis, since sometimes EDA is enough to answer the question.
 - To be able to ask more questions.


## This lecture

This lecture introduces students to the usage of the most important EDA commands. Students will be able to visualize data with histograms, box plots and violin plots, and to calculate the most important summary statistics focusing on measures of central value and spread.

Case studies (at least partly) connected to this lecture:
  - [Chapter 03, 3.A1 and 3.A2: Finding a Good Deal among Hotels: Data Exploration](https://gabors-data-analysis.com/casestudies/#ch03a-finding-a-good-deal-among-hotels-data-exploration)
  - [Chapter 03, 3.B1: Comparing Hotel Prices in Europe: Vienna vs. London](https://gabors-data-analysis.com/casestudies/#ch03b-comparing-hotel-prices-in-europe-vienna-vs-london) - dealing only with Vienna

This lecture uses the [hotels-vienna.dta](https://osf.io/dn8je) dataset.

## Learning outcomes
After successfully completing the code in `lecture05_eda.do` students should be able to:

  - Calculate standard measures of central value and spread (mean, minimum, maximum, median, quantiles, mode, range, interquartile range, standard deviation, variance etc.).
  - Make histograms, box plots and violin plots (without scaffolding since we discuss it in a latter lecture.)
  - Deal with subsamples using the if condition and the bysort prefix.

## Datasets used

* [hotels-vienna.dta](https://osf.io/dn8je)

## Lecture Time

Ideal overall time: **60mins**.

## Homework

*Type*: quick practice, approx 25 mins

In this homework you are invited to do some exploratory data analysis on the Hotels in Vienna dataset. Your task is to reproduce some results of the case studies of Chapter 3 by doing the following exercises.
  - Define a default folder and open the dataset.
  - Determine the number of observations and variables.
  - Reproduce figures 3.1 (pp. 63), 3.2 (pp. 64), 3.3 (pp. 64), and 3.4 (pp 67). Do not bother with the scaffolding now.
  - Do the sample focusing based on the histograms. You can find its steps on page 68. To remove observations from the sample you will need the drop command. However, we have not discussed this command yet, you are invited to figure out its basic usage using the help menu, by typing: help drop. Combining drop with the if condition you can easily remove the unneeded observations.
  - Calculate the most important descriptive statistics (find them in Table 3.5 on pp. 74) for the price and distance variable. Also visualize the results using box plots or violin plots.


## Detailed online descriptions for the most important commands from the Stata website

  - [summarize](https://www.stata.com/manuals/rsummarize.pdf) 
  - [tabstat](https://www.stata.com/manuals/rtabstat.pdf)
  - [tabulate oneway](https://www.stata.com/manuals/rtabulateoneway.pdf)
  - [tabulate twoway](https://www.stata.com/manuals/rtabulatetwoway.pdf)
  - [tabulate, summarize](https://www.stata.com/manuals/rtabulatesummarize.pdf)
  - [by and bysort](https://www.stata.com/manuals/dby.pdf)
  - [histogram](https://www.stata.com/manuals/dby.pdf)
  - [density plot](https://www.stata.com/manuals16/rkdensity.pdf)
  - [box plot](https://www.stata.com/manuals16/g-2graphbox.pdf)