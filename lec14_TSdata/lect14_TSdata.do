***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 14 ******************************************************
***********************************************************************************************************************
******************************************** Working with time series data ********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec14_TSdata/"


*************** Copying and opening data
*** We use the stock market data, introduced in Case Study 5.A1,...
*** and which data is also used in Chapter 12 (although not exactly this dataset, but it is a part of the dataset used there).
copy "https://osf.io/gds5t/download" "sp500.dta", replace
use "sp500.dta", clear


*************** 1) Dealing with dates
*** Let us start with dealing with dates. We have two variables here that contain dates: -datestring- and -date-...
*** ... Variable -datestring- is a string one, while -date- is recognized as a date variable. In most cases,...
*** ... when we import a .csv, or an .xls(x) the result is one of these ones...
*** ... Let us deal with both cases. 

*** 1a) Starting with the string case: -datestring- is a simple string variable here, it has nothing to do with dates...
*** ... Let us make it usable:
* Step 1: cut it into three pieces (= new variables) using a string function ('split') and defining where to cut ('parse' option):
split datestring, parse(-)

* As you can see, we have now three new variables containing year, month, and day. 
* Step 2: rename and destring them:
destring datestring*, replace
rename datestring1 year
rename datestring2 month
rename datestring3 day

* Step 3: create a date varaible using the 'mdy' function:
generate date_new = mdy(month, day, year)
* Let us check it:
browse year month day date_new

* As you can see, the content of the variable is strange: 17038, 17041 etc., still nothing to do with dates.
* Well, it is in fact a date variable: dates are simply numbers in Stata. In case of dailiy data their interpretation is: ...
* ... number of days since January 1, 1960. Similarly:
     * - in case of yearly data: number of years since 1960
	 * - in case of monthly data: number of months since January, 1960, etc...
	 
* Step 4: for a more intuitive way of display, you should change the format:
format date_new %td /*%td means that the variable contains date on daily frequency*/
browse year month day date date_new /*Now it is okay, and is the same as our original -date- variable.*/

*** 1b) Let us now consider the original -date- variable that is recognized by Stata.
* We can apply date functions immediately to it. E.g.:
* Let us create a day variable:
generate day_new = day(date)

* Or a month or a year variable:
generate month_new = month(date)

* Or year:
generate year_new = year(date)

*** Summing up: If we have a string date variable, first we should covert it to date,...
*** ... and then we can apply different date and time functions to it...
*** ... Variables stored as dates can be used immediately, without any preparation.

*** For the comprehensive list of date and time functions, check the help menu:
help datetime_functions


*************** 2) Defining time series (TS)
*** Before using any kind of time series-specific commands (commands starting with the letters 'ts'),...
*** ... you should define the time series structure, i.e...
*** ... name a variable that defines time. Now, let it be the original -date- variable:
tsset date

* Check the return message in the output window! Stata recognized that it is daily data. It may not work always,...
* ... sometimes we should define the frequency with an option for 'tsset'. Check the help for the necessary option.

*** Please note that the time variable cannot contain duplicates. Do the following and check the error message at the end:
generate x = ym(year, month)
tsset x

*** By simply typing 'tsset' we can query whether date is defined or not:
tsset /*So we have daily data between 2006 and 2016, with some gaps.*/
count /*We have 2519 days, i.e. observations.*/


*************** 3) Filling gaps
*** So, as we saw, there are gaps in our data: there are days that are missing from the dataset...
*** ... (note that not the values are missing for some days, but the days - i.e. observations - themselves...
*** ... We can fill those gaps using the 'tsfill' command.

tsfill
count /*Now we have 3655 days, i.e. observations, and the newly created ones conatin missings for all other variables.*/

*** Let us drop some variables that are not needed
drop datestring date_new day_new month_new year_new x


*************** 4) Time series operators
*** In time series analysis we often need lags or leads, etc. It is easy to generate them in Stata.
*** First, the time series structure should be defined (as we have already done it), and then we can create lags, leads etc.

*** Lag operator:
generate lvalue = l.value /*1st lag*/
generate llvalue = l2.value /*2nd lag*/
* We could go on of course...

*** Lead operator:
generate fvalue = f.value /*1st lead*/
generate ffvalue = f2.value /*2nd lead*/
* We could go on of course...

*** Difference operator
generate dvalue = d.value /* t-(t-1) */
generate ddvalue = d2.value /* [t-(t-1)]-[(t-1)-(t-2)] */
* We could go on of course...

*** Seasonal difference operator
generate svalue = s.value /* t-(t-1) */
generate ssvalue = s2.value /* t-(t-2) */
* We could go on of course...


*************** 5) Other basic, but important commands
*** Using the 'tsreport' command, we get some elementary description of the TS aspects of our data
tsreport

*** Using the 'tsappend' command, we can add observations (i.e. extra rows) to our dataset
tsappend, add(10) /*It adds 10 new observations (days) to the end of our current TS*/

*** Using the 'tsline' command, we can create a line graph
tsline value

*** Using the 'corrgram' command, we can calculate serial correlation (subsection 12.6)
corrgram value, lags(3) /*1st-, 2nd-, and 3rd-order serial correlation and partial serial correlation*/ 

*** Using the 'newey' command, we can estimate OLS regression with Newey-West standard errors (subsection 12.7)

*** Using the 'pperron' command, we can perform a Phillips-Perron unit-root test (subsection 12.U1)
pperron value /*We cannot reject the null of unit root.*/


