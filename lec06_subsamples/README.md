# Lecture 06: Dealing with subsamples

## Motivation

In many cases we would like to analyze only parts of our whole dataset: we would like to deal with subsamples. Characterizing only male employees in our employee-level dataset, or checking only developing countries, instead of all countries in the world, etc.

## This lecture

This lecture introduces students to the three most important approaches of defining subsamples.

Case studies (at least partly) connected to this lecture:
  - [Chapter 03, 3.A1 and 3.A2: Finding a Good Deal among Hotels: Data Exploration](https://gabors-data-analysis.com/casestudies/#ch03a-finding-a-good-deal-among-hotels-data-exploration)
  - [Chapter 03, 3.B1: Comparing Hotel Prices in Europe: Vienna vs. London](https://gabors-data-analysis.com/casestudies/#ch03b-comparing-hotel-prices-in-europe-vienna-vs-london) - dealing only with Vienna

This lecture uses the [hotels-vienna.dta](https://osf.io/dn8je) dataset.

## Learning outcomes
After successfully completing the code in `lecture05_eda.do` students should be able to:

  - Deal with subsamples using the if condition, the by or bysort prefixes, and the in range.

## Datasets used

* [hotels-vienna.dta](https://osf.io/dn8je)

## Lecture Time

Ideal overall time: **30 mins**.

## Homework

*Type*: quick practice, approx 20 mins

In this homework you are invited to use the Hotels in Vienna dataset again. Do the following exercises:

  - Calculate the most important descriptive statistics (find them in Table 3.5 on pp. 74) for the price and distance variables, and also visualize the results using box plots or violin plots. Do it for all types of accommodazions.
  - Reproduce figures 3.1 (pp. 63), and 3.3 (pp. 64). Please note that these figures use only a subsample, and you should also use only those observations. The precise definition of the sample narrowing can be found on the top of page 68. 


## Detailed online descriptions for the most important commands from the Stata website

  - [by and bysort](https://www.stata.com/manuals/dby.pdf)

## Further material
  
  - UCLA offers a module on the [if condition](https://stats.oarc.ucla.edu/stata/modules/using-if-with-stata-commands/).

