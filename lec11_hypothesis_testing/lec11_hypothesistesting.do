***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 11 ******************************************************
***********************************************************************************************************************
************************************************** Testing hypotheses *************************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec11_hypothesis_testing/"


*************** Copying and opening data
*** We use data from the Billion Prices project, introduced in Case Study 1.B1 and used for hypothesis testing in Chapter 6.
copy "https://osf.io/wm6ge/download" "billion-prices.dta", replace
use "billion-prices.dta", clear


*************** Data preparation
*** We are going to reproduce some results of case studies 6.A1, 6.A2, and 6.A3, so let us start with sample selection.
*** Following the book, let us fix the level of significance at 5%. 

* Keeping data from the USA:
keep if COUNTRY == "USA" 

* Keeping products with regular prices:
keep if PRICETYPE == "Regular Price"

* Dropping products where online prices are sales:
drop if sale_online == 1

* Dropping three products with extreme prices:
drop if price > 590000

count /*6439 observations remained*/


*************** Descriptives
* Let us calculate the average offline and online prices and their difference using macros and stored results:
summarize price /*Mean: 28.73*/
local offprice = r(mean)
summarize price_online /*Mean: 28.79*/
local onprice = r(mean)
display "The difference is:" `onprice' - `offprice'

* Let us check the price difference in details
compare price price_online


*************** One-sample t-test
*** It is for testing whether the population average is equal to a particular value.
*** Let us test whether the average offline price is equal to 30:
ttest price == 30
* According to the results, we cannot reject the null that the average offline price is 30.


*************** Paired t-test
*** It is for testing whether two variables have the same population average.
*** Let us now test whether offline and online prices are equal to each other:
ttest price_online == price
* According to the results, we cannot reject the null that the average offline and online prices are equal to each other.


*************** Two-sample t-test
*** It is for testing whether two groups have the same population average for a particular variable.
*** Let us test whether the online-offline price difference is the same in Japan and the Germany.
* Re-opening the data, and keeping Japan and Germany:
use "billion-prices.dta", clear
keep if COUNTRY == "JAPAN" | COUNTRY == "GERMANY"
keep if PRICETYPE == "Regular Price"
drop if sale_online == 1
count /*1044 observations remained*/

* Calculating price difference:
generate diff = price_online - price

* Testing:
ttest diff, by(COUNTRY)
* According to the results, we can reject the null that the average offline and online price difference is equal in Japan and Germany.


