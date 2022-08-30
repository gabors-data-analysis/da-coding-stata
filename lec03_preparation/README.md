# Lecture 03: Preparing data for analysis

## Motivation

Data analysis is always preceded by data preparation, i.e. organizing, managing and cleaning data. This data wrangling is unavoidable, in fact desirable: it makes the data analyst know the data, and also helps avoiding false results. Data wrangling is the conjoined twin of exploratory data analysis (that we are going to cover in the next lecture): they are inseparable. The lecture discusses some basic tools of data wrangling.

## This lecture

This lecture introduces students to the usage of the most important data-wrangling commands: log, browse, describe, sort, order, isid, duplicates, codebook, label, and note.

Case studies (at least partly) connected to this lecture:
  - [Chapter 01, 1.A1: Finding a Good Deal among Hotels: Data Collection](https://gabors-data-analysis.com/casestudies/#ch01a-finding-a-good-deal-among-hotels-data-collection) - emphasis on the most important pieces of characteristics of the data: obs, variables, id etc.
  - [Chapter 02, 2.A1: Finding a Good Deal among Hotels: Data Preparation](https://gabors-data-analysis.com/casestudies/#ch03a-finding-a-good-deal-among-hotels-data-exploration) - emphasis on the types of variables

This lecture uses the [hotels-vienna.dta](https://osf.io/dn8je) dataset.

## Learning outcomes
After successfully completing the code in `lecture03_preparation.do` students should be able to:

  - Get some basic intuition about the data (variables and observations).
  - Execute basic data wrangling (sorting and ordering, dealing with duplicates, looking for missing values, and making labels and notes).
  - Take a step towards making their work traceable and reproducible.

## Datasets used

* [hotels-vienna.dta](https://osf.io/dn8je)
* lec03HW.dta as homework

## Lecture Time

Ideal overall time: **30mins**.

## Homework

*Type*: quick practice, approx 20 mins

Open the lec03HW.dta file which is a simulated dataset. Suppose that it is a sample of 20 employees of a big company. Do some data preparation by solving the following exercises.
  - How many variables do we have in the dataset? How many of them are string?
  - If you check the number of observations, you can see that something is wrong. Look for duplicated observations based on all the employee characteristics. If you find duplicates, also tag them, so later you can find and treat them easily.
  - Make also a brief note to the ID variable about the previous problem.
  - Check whether ID can be used as a unique identifier.
  - Count the number of missing values in case of all the variables.
  - According to the documentation you got from the data provider, in the case of variable gender 0 means female, and 1 means male. Label the values of gender accordingly.
  - Define a value label, where 0 means no, and 1 means yes. Attach this value label to variable university.
  - We know that wage is gross monthly wage. Label the wage variable accordingly.
  - Make a note to the dataset about the current time and indicate that this was the time when the preparation was done.
  - Save your updated dataset.

## Detailed online descriptions for the most important commands from the Stata website

  - [.log files](https://www.stata.com/manuals/rlog.pdf) 
  - [isid](https://www.stata.com/manuals/disid.pdf)
  - [duplicates](https://www.stata.com/manuals/dduplicates.pdf)
  - [labeling](https://www.stata.com/manuals/dlabel.pdf)
  - [making notes](https://www.stata.com/manuals/dnotes.pdf)

## Further material

  - Stata Press' Getting Started with Stata for Windows discusses the relevance of labeling in [Chapter 9](https://www.stata.com/manuals/gsw9.pdf), and describes the usage of log files in [Chapter 16](https://www.stata.com/manuals/gsw16.pdf).

  - UCLA has a module on [labeling](https://stats.oarc.ucla.edu/stata/modules/labeling-data/).

  - SSCC has a nice intro on [data structure](https://sscc.wisc.edu/sscc/pubs/intro_stata/intro_stata2.htm), and some parts of the [data wrangling module](https://sscc.wisc.edu/sscc/pubs/dws/data_wrangling_stata3.htm) are also relevant here.

  - [Subsection 2.3](https://data.princeton.edu/stata/dataManagement) of Germán Rodríguez's Stata Tutorial course discusses the usage of labels and notes.


