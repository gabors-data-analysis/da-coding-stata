# Lecture 12: Regression basics

## Motivation

Economic growth is an important topic in macroeconomics, and is analyzed by thousands of economists, including for example Xavier Sala-i-Martin. One of his articles was published in the American Economic Review in 1997 (87(2), pages 178-183), and its title is [I Just Ran Two Million Regressions](https://www.jstor.org/stable/2950909). This title is funny, but also shows the importance of regression analysis in economics: it is the Swiss army knife for economists. If economists would like to uncover patterns of association between variables, in most cases they use regression analysis.

## This lecture

This lecture introduces students to the basics of regression analysis. We deal with many topics from Chapters 7, 8, 9, and 10. From an econometric point of view, regression analysis means a huge amount of material, although, from a Stata point of view it only needs one lecture to discuss the basics.

Case studies (at least partly) connected to this lecture:
  - [Chapter 07, 7.A1, 7.A2, and 7.A3: Finding a good deal among hotels with simple regression](https://gabors-data-analysis.com/casestudies/#ch07a-finding-a-good-deal-among-hotels-with-simple-regression)

This lecture uses the [hotels-vienna.dta](https://osf.io/dn8je) dataset.

## Learning outcomes
After successfully completing the code in `lecture10_regression_basics.do` students should be able to:

  - Run simple regression models.
  - Calculate fitted values and residuals.
  - Include qualitative variables in the regression models.
  - Include interaction terms in the regression models.

## Datasets used

* [hotels-vienna.dta](https://osf.io/dn8je)

## Lecture Time

Ideal overall time: **60 mins**.

## Homework

*Type*: quick practice, approx 20 mins

In this homework you are invited to reproduce the regression results of the following case studies:

  - 9.A4: Tables 9.1 and 9.2.
  - 10.A1: Table 10.1.
  - 10.A3: Table 10.2.
  - 10.A4: Table 10.3.
  - 10.A5: Table 10.4.
  - 10.A6: Table 10.5.


## Detailed online descriptions for the most important commands from the Stata website

  - [regress](https://www.stata.com/manuals/rregress.pdf)
  - [lowess](https://www.stata.com/manuals/rlowess.pdf)

## Further material

  - [Chapter 1](https://stats.oarc.ucla.edu/stata/webbooks/reg/chapter1/regressionwith-statachapter-1-simple-and-multiple-regression/) of UCLA's Regression with Stata book offers an extensive introduction to the topic.

  - The [paper](https://www.stata.com/why-use-stata/easy-to-grow-with/linear.pdf) of Rose Madeiros is an astonishingly great description of interactions.

  - There is a brief description of the usage of factor variables at the Stata [webpage](https://www.stata.com/features/overview/factor-variables/).
