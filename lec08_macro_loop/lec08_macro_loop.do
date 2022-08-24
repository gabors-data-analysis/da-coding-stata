***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 08 ******************************************************
***********************************************************************************************************************
********************************************* Macros, loops, and stored results ***************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "C:\bekeskezdi_stata\lec08_macro_loop\"

*************** Copying and opening data
*** We use data from the World Management Survey, introduced in Case Study 1.C1 and analyzed in 4.A1.
copy "https://osf.io/qx4fn/download" "wms_da_textbook-xsec.dta", replace
use "wms_da_textbook-xsec.dta", clear

*************** Topic 1: Macros
*** A macro is a string of characters, called the macroname, that stands for another string of characters, ...
*** ... called the macro contents. Everywhere a macro name appears in a command, ...
*** ... the macro contents are substituted for the macro name. Macros can be local or global.

*** Local macros:
     * Macro names are up to 31 characters long.
	 * The contents of local macros are defined with the 'local' command.
	 * Local macros are ephemeral macros:
	      * Local macros exist solely within the program or .do file in which they are defined.
		  * Local macros are valid only in a single execution of commands in .do files.
	 * Syntax of defining local macros:
	      * Defining string macro content: local macroname "string" 
		  * Defining numerical macro content: local macroname = expression
	 * Referring to local macros: `macroname'

*** Global macros:
     * Macro names are up to 32 characters long.
	 * The contents of global macros are defined with the 'global' command.
	 * Global macros are persisting macros:
	      * Global macros, once defined, are available anywhere in Stata. 
		  * Global macros persist until you delete them, or the end of the session.
	 * Syntax of defining global macros:
	      * Defining string macro content: global macroname "string" 
		  * Defining numerical macro content: global macroname = expression
	 * Referring to global macros: $macroname

*** Some examples for local macros:
* 1) Define a local macro called i, containing the number 30, and then use it in an if condition:
local i = 30
count if sic == `i'
* As a useful practice try to execute the two commands first together, then one by one.

* 2) Define a local macro called number, containing the number 10, and then use it to produce a new variable:
local number = 10
generate fifteen = `number'+5

* 3) Define a local macro called varlist, containing some variable names, and then use it to produce some descriptives:
local varlist = "management operations monitor target"
summarize `varlist', detail

*** Some examples for global macros:
* 1) Define a global macro called j, containing the number 20, and then use it in an if condition:
global j = 20
count if sic == $j
* As a useful practice try to execute the two commands first together, then one by one.

* 2) Define a global macro called x, containing the word newvar, and then use it to produce a new variable:
global x = "newvar"
generate $x = 100

*** Macros can be used to define new macros:
local h = $j + 20
generate forty = `h'

*************** Topic 2: Loops
*** Loops are for executing repetitive tasks: making similar things many times.
*** A loop repeatedly sets a local macro to each element of the list you specify...
*** ... and executes the commands enclosed in brackets.
*** There are two kinds of loops:
     * 'forvalues' loops over a list of numbers that has a clear pattern.
	 * 'foreach' loops over a list of anything (elements of a local or global macro, variable list, numbers etc.)
	 
*** The 'forvalues' loop
* The general syntax is the following:
     * forvalues lname = range {
	 * 	Stata command(s) to execute
	 * }
* Some important note:
     * lname is a local macro containing numbers following a clear pattern and defined in range.
	 * The open brace must appear on the same line as 'forvalues' itself.
	 * Nothing may follow the open brace except comments.
	 * The close brace must appear on a line by itself.

* Example 1: Calculating some descriptives of -management- for each -wave-:
tabulate wave /*Running from 2004 to 2015, containing each year.*/
forvalues i = 2004(1)2015 {
	summarize management if wave == `i', detail
}

* Example 2: Renaming the -perf1-, -perf2-, ... variables to -performance_1, performance_2, etc.:
forvalues i = 1(1)10 {
	rename perf`i' performance_`i'
}

*** The 'foreach' loop
* The general syntax is the following:
     * foreach lname in/of list {
	 * 	Stata command(s) to execute
	 * }
* Some important note:
     * lname is a local macro containing a list of something to loop over.
	 * The open brace must appear on the same line as 'foreach' itself.
	 * Nothing may follow the open brace except comments.
	 * The close brace must appear on a line by itself.

* Example 1: Looping over a list of nubers without clear pattern:
foreach i of numlist 20 21 25(1)30 36 39  {
	summarize management if sic == `i'
}

* Example 2: Looping over a list of existing variables:
foreach j of varlist firmid wave cty management degree_m degree_nm {
	codebook `j'
}

* Example 3: Looping over the elements of a global macro:
global k = "2005 2006 2010 2012"
foreach m of global k {
	tabulate country if wave == `m'
}

* Example 4: Looping over anything else that is not a list of numbers, existing variables, new variables, ...
* ... or elements of a local or global macro:
foreach n in us ar br ca {
	summarize management if cty == "`n'"
}

* Please note that in the case of lists of variables, numbers, and macros, you should define the type of the list...
* ... (numlist, varlist, newlist, local, global) after macroname, and before the list, you should write 'of', while...
* ... in the case of other content you do not define the type of the list, and you write 'in' instead of 'of'.

*** Useful tips for loops
* 1) If you loop over many elements of a list, it is hard to follow which results refer to which element. E.g.:
forvalues i = 20(1)39 {
	summarize management if sic == `i', detail
}
* Can you tell immediately which table refers to -sic- code 31? I guess no. The 'display' command can help.
* 'display' let us print anything in the main window. Check the following code for example:
forvalues i = 20(1)39 {
	display "Summary statistics of -management- for sic code `i':"
	summarize management if sic == `i', detail
}

* 2) Consider the following case: you have a well-written, long do file for an analysis trying to ...
* ... capture the association between management quality and firm size (like the case study of Chapter 4)...
* ... You have data for years between 2004 and 2015. Later you get data for 2016, so you should ...
* ... revise all your do file and make many changes to integrate the new data. Would not it be nice ...
* ... if your original do file was so general and adaptive that it did not need updates? ...
* ... If for example your loops are looping over not years 2004, 2005, ..., 2015, but over "all years in current data"? ...
* ... The 'levelsof' command can solve this, since it stores all the values of a variable in a local macro.
levelsof wave, local(years) /*Storing all the unique values of -wave- in a local macro called years*/
foreach i of local years { /*Order Stata to loop over the values of years*/
	summarize management if wave == `i'
}

* 3) Loops can be nested
* Let us for example create some descriptive statistics of the -management- variable for all country - wave pairs:
levelsof country, local(c)
levelsof wave, local(w)
foreach clocal of local c {
	foreach wlocal of local w {
		display "Country: `clocal', wave: `wlocal'"
		summarize management if country == "`clocal'" & wave == `wlocal'
		display ""
		display ""
	}
}
 

*************** Topic 3: Stored results
*** Stored results is another feature in Stata that helps generalization and automatization, i.e. ...
*** ... re-executing your .do file without changing it after your data changes.
*** Suppose that you would like to count the number of observations that have a higher -management- score...
*** ... than the average -management- score. The thing we would do:
summarize management /*The average is: 2.883423.*/
count if management > 2.883423 /*5,317 such observations.*/

*** The problem here is that after getting more observations (another wave for example) the average changes...
*** ... Fortunately, there is a solution that helps generalizing your code: referring to stored results: ...
*** ... Results of calculations are stored by many Stata commands so that they can be easily accessed...
*** ... and substituted into later commands. Let us do this for the previous case:
help summarize /*Check the last part of the help file: the average can be referred to as 'r(mean)'.*/
summarize management
count if management > r(mean) /*Now you do not need to rewrite this part if you get a new wave of data.*/
*** In the help menu of each command you can check which results are stored and can be substituted into later commands.
*** You can display all the stored results after executing a command as well:
summarize management
return list
*** Note that estimation results can also be saved, we will learn it later.


