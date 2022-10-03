# Coding for Data Analysis with Stata 
Introduction to Data Analysis with Stata - lecture materials
by [László Tõkés](https://www.uni-corvinus.hu/elerhetosegek/tokes-laszlo/) (CUB) 

This course material is a supplement to ***Data Analysis for Business, Economics, and Policy** 
by Gábor Békés (CEU) and Gábor Kézdi (U. Michigan),  Cambridge University Press, 2021*

*Textbook* information: see the textbook's website [gabors-data-analysis.com](https://gabors-data-analysis.com/) or visit [Cambridge University Press](https://www.cambridge.org/highereducation/books/data-analysis-for-business-economics-and-policy/D67A1B0B56176D6D6A92E27F3F82AA20)    
To get a copy: [Inspection copy for instructors](https://www.cambridge.org/highereducation/books/data-analysis-for-business-economics-and-policy/D67A1B0B56176D6D6A92E27F3F82AA20/examination-copy/personal-details) or [Order online](https://gabors-data-analysis.com/order)


## Status

This is version 1.0. (2022-10-03)

Comments are really welcome in email or as a GitHub issue. 

## About this lecture series

This series of lectures offers a brief introduction to Stata, containing 13+1 lectures, including a summary lecture. The course serves as an introduction to the Stata programming language and software environment for data exploration, data wrangling, data analysis, and visualization.  The structure tries to follow the structure of the [textbook](https://gabors-data-analysis.com/), although there are of course some differences: the main organization principle of the lectures is the logic of Stata, not necessary the logic of the book. After going through the lectures, students will be able to reproduce the results of the first two parts of the textbook (Data Exploration, and Regression Analysis) in Stata. Moreover, they will hopefully also understand the language of Stata enough to be able to go on in the textbook, and do the exercises in the second two parts on their own.

Note that in the lectures I use **Stata 14**, however, all the elements discussed here are compatible forward (and in most cases backward) as well.

Lectures 1 to 11 - complementing [Part I: Data Exploration (Chapter 1-6)](https://gabors-data-analysis.com/chapters/#part-i-data-exploration) - focus the logic of the Stata language, data preparation and wrangling, exploratory data amaéysis, and hypothesis testing. Please note that the first lecture is boring, but unfortunately unavoidable. I tried to be as brief as possible there.

Lecture 12 to 14 - complementing [PART II: Regression Analysis (Chapter 7-12)](https://gabors-data-analysis.com/chapters/#part-ii-regression-analysis) - focus on the basics of regression analysis, the presentation of regression results, and visualization.


## Teaching philosophy

We believe in learning by doing, so although the lectures offer a detailed introduction to the topic with many explanations and examples, the more important part is the homework assignments that can help students practicing. We also recommend students to deal with the data exercises at the end of the chapters of the textbook.

This is not a hardcore coding course, but a course to supplement the material of the textbook. The lectures focus on the commands that are needed to reproduce the case studies and to solve the data exercises of the textbook.

The structure of the material reflects these principles. On one hand, the lectures include pre-written codes as an introduction to the topic, while, on the other hand, homework assignments and data exercises of the textbook can help students to gain experience in coding. In most cases, pre-written codes and homework assignments reproduce case study results that can be found in the textbook.

## How to use

These lectures can serve as a basis for a course on Stata programming for data wrangling and basic regression analysis. Although, the series is structured and comprehensive enough to be able to stand alone, we recommend to teach (or and learn) it hand in hand with the textbook, since almost all examples are from the textbook. 

This series of lectures does not need any prior knowledge in Stata programming.

## Sources 

The material is based on experience coming from years of teaching coding and empirical courses at [Corvinus University of Budapest](https://uni-corvinus.hu/), being a research assistant and later researcher, and of course advice from many great resources such as 
  - [Getting Started with Stata for Windows](https://www.stata.com/bookstore/getting-started-windows/) by Stata Press
  - [Economics Lesson with Stata](https://datacarpentry.org/stata-economics/index.html) by Data Carpentry
  - UCLA's [Stata Learning Modules](https://stats.oarc.ucla.edu/stata/modules/)
  - Kurt Schmidheiny's brief intro [document](https://www.schmidheiny.name/teaching/stataguide2up.pdf)
  - [Fundamentals of data analysis and visualization](https://geocenter.github.io/StataTraining/) from a group of instructors
  - A huge collection of advanced Stata stuff on the [Medium site](https://medium.com/the-stata-guide)
  - A [great online training](https://www.sscc.wisc.edu/statistics/training/) by SSCC
  - A [four-piece tutorial](https://data.princeton.edu/stata) by Germán Rodríguez from Princeton University

and many others, listed in the lecture's READMEs.


## Lectures, contents, and case-studies

The following table shows a brief summary of the lectures: what is the type of the lecture, what is the expected learning outcome, and how it relates to the textbook's case studies and datasets.

| Lecture  | Content | Case-study (at least partly) covered | Dataset |
| -------  | ----------------- | ---------- | ------- |
| PART I. | | | |
| [lecture01-boring_stuff](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec01_boring_stuff) | Introduction to the Stata interface and communication. Basics of .do files and the logic of syntaxes. | - | - |
| [lecture02-open_save](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec02_open_save) | Opening and saving datasets. | - | [football](https://gabors-data-analysis.com/datasets/#football), [hotels-vienna](https://gabors-data-analysis.com/datasets/#hotels-vienna), [wms](https://gabors-data-analysis.com/datasets/#wms-management-survey) |
| [lecture03-preparation](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec03_preparation) | Basics of data wrangling | [Chapter 01, 1.A1: Finding a Good Deal among Hotels: Data Collection](https://gabors-data-analysis.com/casestudies/#ch01a-finding-a-good-deal-among-hotels-data-collection), [Chapter 02, 2.A1: Finding a Good Deal among Hotels: Data Preparation](https://gabors-data-analysis.com/casestudies/#ch03a-finding-a-good-deal-among-hotels-data-exploration) | [hotels-vienna](https://gabors-data-analysis.com/datasets/#hotels-vienna) |
| [lecture04-reshape](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec04_reshape) | Reshaping multi-dimensional data. Wide and long formats. | [Chapter 02, 2.B1: Displaying Immunization Rates across Countries](https://gabors-data-analysis.com/casestudies/#ch02b-displaying-immunization-rates-across-countries) | [worldbank-immunization](https://gabors-data-analysis.com/datasets/#world-bank-immunization) |
| [lecture05-eda](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec05_eda)| Exploratory data analysis. | [Chapter 03, 3.A1 and 3.A2: Finding a Good Deal among Hotels: Data Exploration](https://gabors-data-analysis.com/casestudies/#ch03a-finding-a-good-deal-among-hotels-data-exploration), [Chapter 03, 3.B1: Comparing Hotel Prices in Europe: Vienna vs. London](https://gabors-data-analysis.com/casestudies/#ch03b-comparing-hotel-prices-in-europe-vienna-vs-london) | [hotels-vienna](https://gabors-data-analysis.com/datasets/#hotels-vienna)|
| [lecture06-subsamples](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec06_subsamples)| Dealing with subsamples using the if condition, the in range, and the bysort prefix. | [Chapter 03, 3.A1 and 3.A2: Finding a Good Deal among Hotels: Data Exploration](https://gabors-data-analysis.com/casestudies/#ch03a-finding-a-good-deal-among-hotels-data-exploration), [Chapter 03, 3.B1: Comparing Hotel Prices in Europe: Vienna vs. London](https://gabors-data-analysis.com/casestudies/#ch03b-comparing-hotel-prices-in-europe-vienna-vs-london) | [hotels-vienna](https://gabors-data-analysis.com/datasets/#hotels-vienna) |
| [lecture07-graphs](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec07_graphs)| Making graphs. | [Chapter 7, 7.A1 and 7.A2: Finding a good deal among hotels with simple regression](https://gabors-data-analysis.com/casestudies/#ch07a-finding-a-good-deal-among-hotels-with-simple-regression) | [hotels-vienna](https://gabors-data-analysis.com/datasets/#hotels-vienna)  |
| [lecture08-moredatasets](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec08_moredatasets)| Combining datasets: adding observations (append) and variables (merge). | [Chapter 02, 2.C1: Identifying Successful Football Managers](https://gabors-data-analysis.com/casestudies/#ch02c-identifying-successful-football-managers) | [football](https://gabors-data-analysis.com/datasets/#football)|
| [lecture09-datamanipulation](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec09_datamanipulation)| Manipulating data: Producing new variables and changing existing ones. Deleting variables and observations. | [Chapter 04, 4.A1: Management Quality and Firms Size: Describing Patterns of Association](https://gabors-data-analysis.com/casestudies/#ch04a-management-quality-and-firm-size-describing-patterns-of-association) | [wms](https://gabors-data-analysis.com/datasets/#wms-management-survey) |
| [lecture10-macro_loop](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec10_macro_loop)| Working with local and global macros, applying loops, and using stored results. | - | [wms](https://gabors-data-analysis.com/datasets/#wms-management-survey), [football](https://gabors-data-analysis.com/datasets/#football) |
| [lecture11-hypothesis_testing](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec11_hypothesis_testing)| Testing hypothesis. | [Chapter 06, 6.A1, 6.A2, and 6.A3: Comparing online and offline prices: testing the difference](https://gabors-data-analysis.com/casestudies/#ch06a-comparing-online-and-offline-prices-testing-the-difference) | [billion-prices.dta](https://gabors-data-analysis.com/datasets/#billion-prices)|
| PART II. | | | |
| [lecture12-regression_basics](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec12_regression_basics)| Basics of regressions: fitting, predicting, dummy variables and interaction terms. | [Chapter 07, 7.A1, 7.A2, and 7.A3: Finding a good deal among hotels with simple regression](https://gabors-data-analysis.com/casestudies/#ch07a-finding-a-good-deal-among-hotels-with-simple-regression) | [hotels-vienna](https://gabors-data-analysis.com/datasets/#hotels-vienna) |
| [lecture13-presenting_regresults](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec13_presenting_regresults) | Presenting regression results nicely and compactly. |  [Chapter 10, 10.A1: Understanding the gender difference in earnings](https://gabors-data-analysis.com/casestudies/#ch10a-understanding-the-gender-difference-in-earnings) | [cps-earnings](https://gabors-data-analysis.com/datasets/#cps-earnings)|
| [lecture14-TSdata](https://github.com/gabors-data-analysis/da-coding-stata/tree/main/lec1_TSdata)| Basics of time series data commands. | [Chapter 12, 12.A1: Returns on a company stock and market returns](https://gabors-data-analysis.com/casestudies/#ch12a-returns-on-a-company-stock-and-market-returns) | [sp500](https://gabors-data-analysis.com/datasets/#sp500)|


## Found an error or have a suggestion?

Awesome, we know there are errors and bugs. Or just much better ways to do a procedure.

To make a suggestion, please open a `GitHub issue` here with a title containing the case study name. You may also [contact us directly](https://gabors-data-analysis.com/contact-us/). 
