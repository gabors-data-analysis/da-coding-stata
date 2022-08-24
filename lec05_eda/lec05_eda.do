***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 05 ******************************************************
***********************************************************************************************************************
********************************************** Exploratory data analysis **********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "\bekeskezdi_stata\lec05_eda\"

*************** Copying and opening data
*** We use the Hotels in Vienna dataset that we prepared in Lecture 3.
*** So first, let us copy that file into the folder of the current lecture.
copy "C:\bekeskezdi_stata\lec03_preparation\hotels-vienna_prep.dta" "hotels-vienna_prep.dta", replace
use "hotels-vienna_prep.dta", clear

*************** Tidy structure
*** We have 428 observations (rows) and 24 variables (columns). 
*** We will focus on variables -rating-, -ratingta-, -price- and -offer-.
describe rating ratingta offer
*** -rating-: is the user rating average (as is shown by the label) - numerical.
*** -ratingta-: is the average user rating via Tripadvisor - string.
     * As you may remember, we attached a note to this variable in Lecture 3...
	 * ... Can you reveal this note now?
*** -offer-: is a dummy variable indicating whether there is an offer for that particular room or not.
*** -price-: is the price of the accommodation in EUR.

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

********************************************* Topic 2: Defining and characterising subsamples
*** There are basically three main tools to define subsamples: 
     * the if condition 
	 * the by or bysort prefix 
	 * the in range.

*************** 1) The 'if' condition
* The 'if' condition refers to a (or more) variable(s) and checked at the level of observations.
* Stata runs through the observations, and the command will only be executed on the data for which...
* ... the 'if' condition is true. 

* Let us see some basic examples:
count if rating < 3 /*Counting the number of obs that have a lower rating than 3.*/
count if accommodation_type == "Hotel" /*Displaying the number of obs that are hotels.*/
* ! Note that two equation signs should be used in the 'if' condition for checking equality.
* '==' means "is equal to" and '=' means 'set this to'.
summarize rating if stars == 5 /*Some descriptives of the ratings for 5-star accommodations.*/
summarize rating if stars == 5, detail /*The if condition should come before the options.*/
count if accommodation_type != "Hotel" /*Displaying the number of obs that are not hotels.*/
* Note that 'not equal to' can be expressed both by != or ~=.

* More conditions can also be defined using logical operators.
* Displaying a frequency table of -rating- for 5-star hotels:
tabulate rating if stars == 5 & accommodation_type == "Hotel" 
* 'and' (&) means that both conditions should be true. 
* Displaying a frequency table of -rating- for accommodations that either have 5 stars or are hotels, or both:
tabulate rating if stars == 5 | accommodation_type == "Hotel"
* 'or' (|) means that at least one of the conditions should be true (both of them can be true as well).
* More complex systems of 'if' conditions can also be defined.
* Counting accommodations that are either 5-star hotels or 3-star apartments*/
count if stars == 5 & accommodation_type == "Hotel" | stars == 3 & accommodation_type == "Apartment"
* Please note that 'and' takes precedence over 'or', so arrange your if-systems accordingly using parentheses.

* The most commonly used operators:
* equal to: ==
* not equal to: != or ~=
* less/larger than: < / >
* less/larger than or equal to: <= / >=
* and: &
* or: | 

*** IMPORTANT NOTE about missing values
* Let us check the -rating- variable again with the 'tabulate' command:
tabulate rating, missing
* As you can see, there are 6 observations with value 5. Let us count them in another way:
count if rating > 4.9
* Now the result is 41 pieces that contradicts our result with the 'tabulate' command.
* What is the solution? In the case of the comparison operators missing values are treated as infinity.
* So the right syntaxes in this case are the followings:
count if rating > 4.9 & rating < .
count if rating > 4.9 & rating != .
count if rating > 4.9 & rating ~= .
* Let us recall that 'codebook' is a useful command to check whether a variable has missing values.
* Unfortunately, 'codebook' presents many more pieces of information, ...
* ... and so checking 30 variables using 'codebook' is messy.
* There is a useful command that reports only missing values, ... 
* ... and so it is easy to review the results for many variables as well.
misstable summarize
* As you can see, it displays all the variables which have missings, ...
* ... and also displays the number of missing values.

*************** 2) The 'by' and 'bysort' prefixes
* Both prefixes do the same: repeat the command for each group of observations ...
* ... for which the values of the variables in varlist are the same.
* 'by' requires that the data be sorted by varlist, while 'bysort' does this sorting automatically.

* Let us see the following example: creating summary statistics of the -rating- variable ...
* ... for all subsamples that are created according to the unique values of the -offer- variable:
bysort offer: summarize rating 

* More variables can also be used:
bysort offer accommodation_type: summarize rating

*************** 3) The in range
* The 'in' range qualifier restricts the scope of the command to a specific observation range.
* Let us for example summarize the -price- variable for the first ten observations:
summarize price in 1/10
* Or, list the values of -price- and -rating- for obseravtions 10-20
list price rating in 10/20 
* The list command creates a table that simply contains the values of the particular variables (like in the browse window).

*** IMPORTANT NOTE: it is favoured to avoid the use of the 'in' range qualifier since if you change the order...
*** ... of the observations, the result can also change. For example:
summarize price in 1/10 /*The average is: 213.5*/
sort hotel_id
summarize price in 1/10 /*The average now is: 112.7*/

********************************************* Topic 3: Visualization
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

*** Both plots can be created for subsamples as well:
* Using the 'if' condition:
graph box price if accommodation_type == "Apartment"
* Using the 'over' option:
graph box price, over(offer)
