# Lecture 02: Opening and saving data

## Motivation

Datasets can be stored in many types of files, our first task is to import them to Stata. On the other hand, the dataset we successfully prepared to analysis, and also the results of our analysis should be saved or exported. This is the topic of this lecture.

## This lecture

This lecture introduces students to opening and saving datasets focusing on the most common types like Excel tables, delimited text files, and Stata’s own file extension, the .dta.

## Learning outcomes
After successfully completing the code in `lecture02_opensave.do` students should be able to:

  - Import and export .xls, .xlsx, and .csv files.
  - Open and save .dta files.
  - Execute some basic commands in order to communicate with their computer via Stata.

## Datasets used

* [managers_epl.xlsx](https://osf.io/pu3vx)
* [hotels-vienna.csv](https://osf.io/y6jvb)
* [wms_da_textbook.csv](https://osf.io/uzpce)

## Lecture Time

Ideal overall time: **30 mins**.

## Homework

*Type*: quick practice, approx 20 mins

Let us now put you into deep water and give you a homework assignment that may be a bit hard at first. Use the help menu, or the search command if it is needed. Do the followings
  - Define a default folder.
  - Create a new subfolder called all_data in your default folder.
  - Download into this all_data folder all the datasets from the book. You can find them as a .zip file: [da_data_repo.zip](https://osf.io/9gw4a). It may take some time since the size of the .zip is about 180 MB.
  - Unzip the data.
  - Import the wms_da_textbook.csv file (that can be found in the wms-management-survey folder).
  - Save it as a .dta file into your default folder.
  - Delete the all_data folder with all its content.

## Detailed online descriptions for the most important commands from the Stata website

  - Importing and exporting text-delimited files: [here](https://www.stata.com/manuals/dimportdelimited.pdf)
  - Importing and exporting Excel files: [here](https://www.stata.com/manuals/dimportexcel.pdf)

## Further material

  - Stata Press' Getting Started with Stata for Windows discusses the topic in [Chapter 8](https://www.stata.com/manuals/gsw8.pdf).

  - The Stata User Guide discusses in details the importing of datasets in [Chapter 22](https://www.stata.com/manuals/u22.pdf).

  - The [relevant part](https://sscc.wisc.edu/sscc/pubs/dws/data_wrangling_stata2.htm) of SSCC's Stata for student course gives a detailed description of reading in data.