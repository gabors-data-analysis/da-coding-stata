# Lecture 04: Reshaping data

## Motivation

In Lecture 3 we got to know the basics of data wrangling, i.e. getting data prepared for analysis. In this lecture we still focus on data wrangling, dealing shortly with restructuring multi-dimensional data. Nowadays a great proportion of datasets is panel data (a special kind of multi-dimensional data), and so an analyst should now the difference between long format and wide format, how to restructure the one to the other, and how to create tidy data. This is the topic of this lecture. 

## This lecture

This lecture introduces students to the usage of the reshape command.

Case studies (at least partly) connected to this lecture:
  - [Chapter 02, 2.B1: Displaying Immunization Rates across Countries](https://gabors-data-analysis.com/casestudies/#ch02b-displaying-immunization-rates-across-countries)

## Learning outcomes
After successfully completing the code in `lecture04_reshape.do` students should be able to:

  - Reshape datasets from wide form to long form and vice versa.

## Datasets used

* In the lecture: [worldbank-immunization-panel.dta](https://osf.io/ku4fd)
* In the homework: [worldbank-immunization-continents.csv](https://osf.io/58zrj)

## Lecture Time

Ideal overall time: **20mins**.

## Homework

*Type*: quick practice, approx 15 mins

Import the [worldbank-immunization-continents.csv](https://osf.io/58zrj) dataset that contains immunization rate and survival rate data for the following regions on yearly frequency: East Asia and Pacific (EAS), Europe and Central Asia (ECS), Latin America and the Caribbean (LCN), Middle East and North Africa (MEA), North America (NAC), South Asia (SAS), and Sub-Saharan Africa (SSF). Reshape the data

## Detailed online descriptions for the most important commands from the Stata website

  - [reshape](https://www.stata.com/manuals/dreshape.pdf) 

## Further material

  - The second part of the [3rd lesson](https://datacarpentry.org/stata-economics/03-transform-data/index.html) of Data Carpentry's Economics Lesson with Stata course offers a detailed description of the topic with many exercises.

  - UCLA has two modules with many examples on reshaping data: [wide to long](https://stats.oarc.ucla.edu/stata/modules/reshaping-data-wide-to-long/) and [long to wide](https://stats.oarc.ucla.edu/stata/modules/reshaping-data-long-to-wide/).
