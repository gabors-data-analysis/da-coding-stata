***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 06 ******************************************************
***********************************************************************************************************************
*********************************************** Dealing with subsamples ***********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec06_subsamples"


*************** Copying and opening data
*** We use again the Hotels in Vienna dataset that we prepared in Lecture 3.
*** So first, let us copy that file into the folder of the current lecture.
copy "da-coding-stata/lec03_preparation\hotels-vienna_prep.dta" "hotels-vienna_prep.dta", replace
use "hotels-vienna_prep.dta", clear


*************** Defining and characterising subsamples
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

* In case of string variables we can refer to missing using: "". For example:
count if accommodation_type == ""
* According to the results, there are no missings. You can also check it using the 'tabulate' command:
tabulate accommodation_type, missing

* So, missing values should be referred to as:
     * . in case of numerical variables.
	 * "" in case of string variables.

* Let us recall that 'misstable' is a useful command to check whether a variable has missing values.
misstable summarize


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


*************** Visualization of subsamples
*** Please note that the visualization commands we used in the previous lecture can be used for subsamples, as well.

* Using the 'if' condition:
graph box price if accommodation_type == "Apartment"

* Using the 'over' option:
graph box price, over(offer)
