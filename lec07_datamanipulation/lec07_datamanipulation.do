***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 07 ******************************************************
***********************************************************************************************************************
************************************************** Data manipulation **************************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "C:\bekeskezdi_stata\lec07_datamanipulation\"

*************** Copying and opening data
*** We use data from the World Management Survey, introduced in Case Study 1.C1 and analyzed in 4.A1.
copy "https://osf.io/qx4fn/download" "wms_da_textbook-xsec.dta", replace
use "wms_da_textbook-xsec.dta", clear

*************** Note
*** It is extremely useful to check the result in a Browse Window after each step in this lecture.

*************** Producing new variables: general notes
*** Basically, there are 2 commands for producing new variables: 'generate' and 'egen'.
*** Unfotunately, there are no strict definitions about their usage, but:
     * 'generate' is mainly for simple stuffs, while...
	 * ... 'egen' is for more complex stuff, it is a kind of Swiss Army knife...
	 * ... 'egen' can handle more variables or more observations in a more complex way.
	 
*** Basic syntax of 'generate' and 'egen':
	* generate new_var_name = expression
	* egen new_var_name = function()
	
*** There are some rules about variable names:
     * They cannot be longer than 32 characters, although it is worth giving short names and use labels instead.
	 * The letters a-z (both lower-case and upper-case), numbers (0-9), and underscore (_) are valid characters.
	 * Names cannot start with a number.
	 * Please also note that Stata is case-sensitive.
		  
*************** Producing new variables: the 'generate' command
* Generating the year of born of the firms is a simple mathematical operation:
generate born_year = wave - firmage
* Generating a new variable that measures the number of employees in thousands:
generate emp_firm_th = emp_firm/1000
* In the expression part of 'generate', the basic maths tools can be used: +, -, *, /, ^, etc.
	 
* Generating the natural logarithm of -emp_firm-:
generate lnemp = ln(emp_firm)
* Generating a new variable that contains the closest integer to -management-:
generate roundmanagement = round(management)
* In the expression part of 'generate', many mathematical functions can also be used, see:
help math_functions

* There are other functions as well: date and time, random-number, string etc. See the details by typing: 'help functions'.

*************** Producing new variables: the 'egen' command
* 'egen' can be applied to more observations,...
* ... e.g. calculating the average of the management score for the whole sample:
egen mean_management = mean(management)

* We can also consider more variables,...
* ... e.g. calculating the average of the -aa_1-, -aa_2-, -aa_3- and -aa_4- variables for each observation:
egen mean_aa_1_4 = rowmean(aa_1 aa_2 aa_3 aa_4)

* Let us calculate the average for all the aa_ variables using a wild card:
egen mean_aa_all = rowmean(aa_*)
* aa_* means that we consider all the variables starting with the characters aa_ and continuing in any way.
     * Note that * can be used at the beginning, at the end, or anywhere else in a combination of characters, so:
	      * *x refers to all the variables ending with letter x.
		  * x* refers to all variables starting with the letter x.
		  * *x* refers to all variables containing the letter x and have anything (even nothing) in its name before and after.

* There is another useful wild card for referring to more variables, the - sign:
egen nrnomiss = rownonmiss(sic - target)
* It creates a new variable containing the number of nonmissing values in varlist for each observation, ...
* ... where varlist contains all the variables from -sic- to -target- based on the Variable Window: ...
* ... -sic-, -management-, -operations-, -monitor-, and -target-.

*************** Producing new variables: the if condition
* Both 'generate' and 'egen' can be combined with the 'if' condition using the logic we discussed in Lecture 5.

* Generating a new variable that is equal to 1 if the home country of the firm is the US (and missing otherwise):
generate usa = 1 if country == "United States"

* Generating a new variable that contains the mode of -country- for the firms that have more than 1000 employees
egen x = mode(country) if emp_firm>1000 & emp_firm!=.

*************** Producing new variables: the bysort prefix
* Both 'generate' and 'egen' can be combined with the 'bysort' prefix using the logic we discussed in Lecture 5.
* Although, 'bysort' is more important in the case of 'egen'.

* Calculating the country-level average management score for all the countries:
bysort country: egen cmean_manag = mean(management)

* Calculating the standard deviation of the management score for all country-industry subsamples:
bysort country sic: egen sd_manag = sd(management)

*************** Changing the content of existing variables
*** Basically, there are 2 commands for changing the values of existing variables: 'replace' and 'recode'.
     * 'replace' is a basic command, can be easily used, while...
	 * ... 'recode' is mainly for categorical variables, but with more opportunities.

*** Let us start with 'replace':
* The syntax and logic of 'replace' is similar to what we discussed in the case of 'generate'.
* Mathematical operations can be done, e.g.:
replace mean_aa_all = 1 /*All the values of -mean_aa_all- will be 1.*/
* The if condition can be used:
replace usa = 0 if usa == . /*Recoding missings to zeros, so we have a dummy now.*/
* Functions can be used:
replace mean_management = round(mean_management)
* Can be used for string:
replace country = "USA" if country == "United States"

*** 'recode' is only for numerical variables, and most frequently used for recoding categorical variables.
tabulate aa_1, missing /*The variable contains 0s and 1s, and one missing. Let us replace the missing with the number 2.*/
recode aa_1 (. = 2) /*We should define a rule in parentheses and the variable(s) to apply the rule for.*/
* The rule can be applied to more variables:
recode aa_2 aa_3 aa_4 (. = 2)
* More rules can also be applied:
recode aa_5 aa_6 (0 = 5) (1 = 6)
* More complex rules can also be applied:
recode aa_7 aa_8 (0 1 = 10) (. = 999)
* We can keep the original variable, and apply the rule(s) during generating a new one:
recode sic (. = 999), generate(sic_nomissing)
* You should avoid defining a lot of rules simultaneously (it could be confusing),...
*... although the 'test' option can show whether rules are ever invoked or that rules overlap.
recode aa_10 (0/5 = 100) (1 = 999), test

*************** Making numerical variables from string ones
*** Dealing with string content in Stata is a bit harder, so if it is possible, one should work with numerical content.
*** Here we present two solutions to convert string variables to numerical ones.
*** If our variable contains numbers, but for some reasons they are stored as strings, we should use 'destring'.
* Let us first generate two variables to convert:
generate uk_str = "1" if country == "Great Britain"
replace uk_str = "0" if uk_str==""
generate uk_str_other = uk_str
replace uk_str_other = "non-uk" in 1
* Take a look at these two variables and the -country- variable:
browse country uk_str uk_str_other
* Now all the three variables are string ones, but basically the two we generated should be numerical ones.
* Let us covert -uk_str-, while keeping the original variable:
destring uk_str, generate(uk)
* If we do not need the original variable, we can replace it using the 'replace' option:
destring uk_str, replace

* Destring works only if all the values can be converted. Remember that uk_str_other contains a true string value...
* ... in row 1, so Stata cannot convert it:
destring uk_str_other, replace
* We can use the 'force' option to force the conversion /*non-convertible values are replaced by missings*/:
destring uk_str_other, replace force

*** So, in the case of string content, which is in fact numeric, we should use the 'destring' option.
*** On the other hand, in the case of true string content (e.g. the -competition- variable) 'encode' should be used:
encode competition, generate(compet_numer)
* Observations are ordered in alphabetic order based on the values of the variable to encode, ...
* ... and attach the number 1 to the first value(s), then 2 to the second value(s) etc.
tabulate competition, miss /*Four different string values and one missing.*/
tabulate compet_numer, miss /*The same as the previous at first sight. Let us see it without the labels.*/
tabulate compet_numer, miss nolabel /*So, we have numbers 1, 2, 3, and 4, labelled according to the original string values.*/

*** Note that using 'encode' in case of numerical content stored as string could make fatal problems. Check the following:
generate number = "0" in 1/6
replace number = "5" in 7/15
replace number = "99" in 16/20
encode number, gen(num_number)
list number num_number in 1/20
list number num_number in 1/20, nolabel

*************** Making string variables from numerical ones
*** Although in most cases we would like to go to the string-->numerical direction, ...
*** ... sometimes the other way is needed. Two commands can be used:
     * 'tostring' for converting numeric variables to string variables.
	 * 'decode' for creating a new string variable based on the "encoded" numeric variable.

*************** Changing the name of the variables
*** Variables can be renamed using the 'rename' command.
*** Let us rename the industry code variable, -sic-:
rename sic indcode

*************** Deleting variables and observations
*** 'drop' and 'keep' can be used to delete/keep variables and observations.
*** 'drop' and 'keep' are substitutes: use the one that is more comfortable.

*** Variables should be listed after the command in order to drop/keep them:
drop x /*Dropping variable -x-*/
keep firmid - reliability /*Dropping all the variables from -aa_1- to -compet_numer-*/

*** Observations can be dropped/kept with the if condition:
drop if wave == 2015 /*Dropping obs that are from the wave of 2015.*/
keep if country!="USA" /*Dropping obs from the USA, i.e. keeping the rest.*/




