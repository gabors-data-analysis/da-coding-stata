# Lecture 06: Combining datasets

## Motivation

In many cases you have to work with more than one datasets. For example, let us consider the case of the game-level data we use in case study 2.C1 on pp. 40, [Identifying Successful Football Managers](https://gabors-data-analysis.com/casestudies/#ch02c-identifying-successful-football-managers). The data covers 11 seasons of EPL games, and originally comes in separate .csv files: one .csv contains the data of one season, so we have 11 files. Moreover, we also have data on managers, and in a latter analysis (see case study 24.B1, [Estimating the Impact of Replacing Football Team Managers](https://gabors-data-analysis.com/casestudies/#ch24-estimating-the-impact-of-replacing-football-team-managers)) we would like to use both the game-level and the manager-level data. How can we integrate these datasets? How can we deal with more than one datasets? 

Stata always works with one dataset, so if we would like to use more datasets simultaneously, we should combine them first. This is the topic of this lecture. (In fact, data frames were introduced in Stata 16, and so it became possible to have multiple datasets in memory, but it is still much easier to follow the old logic of working with one dataset. For further details on data frames please check the [website](https://www.stata.com/features/overview/multiple-datasets-in-memory/) of Stata.


## This lecture

In this lecture we first discuss some definitions according to combining datasets, and then we also review the two most important commands - append and merge - that can be used to combine multiple datasets.

Case studies (at least partly) connected to this lecture:
  - [Chapter 02, 2.C1: Identifying Successful Football Managers](https://gabors-data-analysis.com/casestudies/#ch02c-identifying-successful-football-managers)

This lecture uses some raw [football](https://osf.io/zqm6c/) data.

## Learning outcomes

After successfully completing the code in lecture06_moredatasets.do students should be able to combine datasets both vertically and horizontally, using the append and merge commands.

## Datasets used

* [raw football data](https://osf.io/zqm6c/)

## Lecture Time

Ideal overall time: **90mins**.

## Homework

*Type*: quick practice, approx 30 mins

In this homework you are invited to combine some artificial datasets containing different pieces of information on products and shops selling the products. The following variables are in the datasets:
  - id: unique identifier of the product
  - price: price of the product
  - quantity: quantity of the product in storage
  - shop_id: unique identifier of the shop where the product is sold
  - region: identifier of the region where the shop can be found
Do the following exercises step by step:
  - Define a default folder.
  - Open lec06_hw_data1.xlsx, take a look at it (use the list command), and then save it as hw6_data1.dta.
  - Open lec06_hw_data2.csv, take a look at it (use the list command), and then save it as hw6_data2.dta.
  - Open hw6_data1.dta and try to combine it with hw6_data2.dta. Do the process in a way that the most information is used (i.e. pay attention to values that are missing in one dataset and non-missing in another). At first, it will not work. Find and solve the problem first (hint: use isid and duplicates), and then try to combine the two datasets again.
  - Save the combined dataset as hw6_data12.dta.
  - Open lec06_hw_data3.dta and take a look at it (use the list command).
  - Combine it with hw6_data12.dta. Then save it as hw6_data123.dta.
  - Open lec06_hw_data4.dta and take a look at it (use the list command). This dataset shows the region of all shops.
  - Combine it with hw6_data123.dta. You will again face a problem. You can solve it looking for the adequate option in the help menu of the combining command you use.


## Detailed online descriptions for the most important commands from the Stata website

  - [An intro on combining datasets](https://www.stata.com/manuals/u23.pdf) 
  - [merge](https://www.stata.com/manuals/dmerge.pdf)
  - [append](https://www.stata.com/manuals/dappend.pdf)