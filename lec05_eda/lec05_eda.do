***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 05 ******************************************************
***********************************************************************************************************************
********************************************** Exploratory data analysis **********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec05_eda"


*************** Copying and opening data
*** We use the Hotels in Vienna dataset that we prepared in Lecture 3.
*** So first, let us copy that file into the folder of the current lecture.
copy "da-coding-stata/lec03_preparation/hotels-vienna_prep.dta" "hotels-vienna_prep.dta", replace
use "hotels-vienna_prep.dta", clear


*************** Tidy structure
describe, short
*** We have 428 observations (rows) and 24 variables (columns). 

*** We will focus on variables -rating-, -ratingta-, -price- and -offer-.
describe rating ratingta offer
*** -rating-: is the user rating average (as is shown by the label) - numerical.
*** -ratingta-: is the average user rating via Tripadvisor - string.
     * As you may remember, we attached a note to this variable in Lecture 3...
	 * ... Can you reveal this note now?
*** -offer-: is a dummy variable indicating whether there is an offer for that particular room or not.
*** -price-: is the price of the accommodation in EUR.


*************** Wild cards for variables
*** Let us take a brief digression here. In many cases we would like to refer to more than one variables,...
*** ... like in our previous example: describe rating ratingta offer...
*** ...We can use some so-called wild cards, i.e. simplifications in such cases. Instead of listing all the variables,...
*** ... we can use other solutions: the * and the - wild cards.

*** 1) Using the * character:
describe  rati* 
* We are referring here to all the variables that start with the letters rati and continue in any way.
* Note that * can be used at the beginning, at the end, or anywhere else in a combination of characters, so:
	 * *x refers to all the variables ending with the letter x.
	 * x* refers to all variables starting with the letter x.
	 * *x* refers to all variables containing the letter x and have anything (even nothing) in their names before and after.
	 
*** 2) Using the - character
describe stars-offer_cat
* We are referring here to all the variables from -stars- to -offer_cat- based on the Variable Window: ...
* ... -stars-, -ratingta-, -ratingta_count-, -scarce_room-, -offer-, and -offer_cat-.


********************************************* Topic 1: Summary statistics

*************** 'codebook'
*** Let us start with the 'codebook' command (that we already used in Lecture 3 in order to find missing values).
codebook ratingta rating offer
*** As you can see, codebook presents:
     * the type (string or numeric)
	 * the number of missings
	 * the number of unique values (that can be really helpful in the case of panel data)
	 * for numerical variables: some descriptive statistics
	 * for string variables: tabulation of the unique values (or, some examples if there are more than 9 uniques)
	 
*** Using the 'notes' option, 'codebook' also displays the notes attached:
codebook ratingta, notes
*** So, 'codebook' can be used both for numerical and string variables.


*************** 'summarize'
*** Let us now check the 'summarize' command that can be used only for numerical variables.
summarize rating offer

*** In order to calculate more pieces of descriptive statistics, we can use the 'detail' option:
summarize rating offer, detail
*** The 'detail' option produces statistics that can be used to find extreme values - see Chapter 3.4.


*************** 'tabstat'
*** Still focusing on numerical variables, we can produce even more descriptive figures with 'tabstat'.
*** We should list the statistics to be calculated in the 'statistics' option:
tabstat rating, statistics(mean range iqr)

*** Check the help menu for the entire list of statistics can be calculated using 'tabstat'.


*************** 'tabulate'
*** The tabulate command can be used to create frequency tables, e.g.:
tabulate rating

*** Note that 'tabulate' does not present missing values by default. The 'missing' option can solve this:
tabulate rating, missing

*** The plot option creates a "low-budget" histogram:
tabulate rating, missing plot

*** Two-way frequency tables can also be produced:
tabulate rating offer, missing

*** In case of labeled values, labels are presented by default, although,...
*** ... with the 'nolabels' option you can order Stata to present the values instead:
tabulate rating offer, missing nolabel


*************** 'tabulate, summarize()'
*** Combining 'tabulate' and 'summarize' you can create one- and two-way tables containing summary statistics:
tabulate offer, summarize(rating)
*** As you can see, it creates two subsamples, and calculate the summary statistics for those two subsamples.


*************** 'compare'
*** You can compare the values of two variables using the 'compare' command.
compare distance distance_alter 

*************** 'misstable'
* There is a useful command that reports only missing values, ... 
* ... and so it is easy to review the results for many variables as well.
misstable summarize

* As you can see, it displays all the variables which have missings, ...
* ... and also displays the number of missing values.


********************************************* Topic 2: Visualization

*** Please note that we cover visualization (and scaffolding) in a latter lecture, ...
*** ... so this lecture's graphs will not be as fancy and as informative as they should be.

*************** 1) Visualizing distributions
*** Let us first draw a simple histogram:
histogram price

*** As you can see, the histogram is scaled to density units by default.
*** Although, we can display frequencies, using the 'frequency' option:
histogram price, frequency

*** Or, percentage scale can also be used:
histogram price, percent

*** Using the 'normal' option, a normal density plot can be displayed...
*** ... (with the same mean and standard deviation as the plotted distribution's)
histogram price, normal

*** Although Stata determines the number of bins automatically based on the number of obs, ...
*** ... you can overrule it using...
     * either the 'bin()' option to define the number of bins
	 * or the 'width()' option to define the width of the bins
* For example:
histogram price, bin(30)
histogram price, width(20)

*** Price is a continuous variable, although we can also make histograms for discrete variables, as well:
histogram stars, discrete

*** Density plots can also be easily created:
kdensity price

*************** 2) Visualizing summary statistics
*** Boxplots can be created using the 'graph box' command:
graph box price

*** Violin plots can be created using the 'vioplot' command, which should be installed first:
ssc install vioplot
vioplot price
