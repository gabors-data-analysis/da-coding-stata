***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 13 ******************************************************
***********************************************************************************************************************
******************************************** Presenting regression results ********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec13_presenting_regresults/"


*************** Copying and opening data
*** We use the Current Population Survey data, introduced in Case Study 9.A1, and...
*** we reproduce the results of the three specifications presented in Table 10.1 in case study 10.A1 (+1 own specification), and...
*** present them in some different ways. 
copy "https://osf.io/rtmga/download" "cps-earnings.dta", replace
use "cps-earnings.dta", clear


*************** Sample selection
*** First we reproduce the sample selection described in case study 10.A1 to get the same results as the ones in Table 10.1.

* Keeping employees with a graduate degree:
keep if grade92 >= 44

* Keeping employees of age 24 to 65:
keep if age >= 24 & age <= 65

* Keeping employees who reported at least 20 hours as their usual weekly time worked:
keep if uhours >= 20

count /*Number of observations is: 18241*/


*************** Variable production
*** Now we create the necessary variables.
generate hwage = (earnwke/uhour)
label variable hwage "hourly wage"

generate lnhwage = ln(hwage)
label variable lnhwage "ln(hourly wage)"

generate female = 0 if sex == 1
replace female = 1 if sex == 2
label define fem 0 "male" 1 "female"
label values female fem


*************** Running regressions
* Specification 1:
regress lnhwage female

* Specification 2:
regress lnhwage female age

* Specification 3:
regress age female

* Specification +1:
regress hwage age


*************** 1) Graphical representation of regression results
*** First let us discuss some methods for the graphical representation of regression results.
***(Please note that we only do some basics without any scaffolding.)

*** 1a) Plotting a simple regression
* We can plot the observations using a scatter and fit a linear regression line:
graph twoway (scatter hwage age) (lfit hwage age)

* A confidence interval can also be presented using the 'lfitci' command:
graph twoway (scatter hwage age) (lfitci hwage age)

*** 1b) Plotting coefficients
* We can also plot the estimated coefficients using a user-written command which should be installed first:
ssc install coefplot

regress lnhwage female age
coefplot

* 'coefplot' shows the confidence interval as well, but it cannot be seen now due to the relative sizes of the coeffs,...
* ... so let us drop the constant and visualize without it:
coefplot, drop(_cons)

* We can also add a vertical line to 0 to help the quick interpretation of sign and significance:
coefplot, drop(_cons) xline(0)


*************** 2) Presenting results in compact tables
*** Now, let us discuss some commands that help making fancy and compact (with a bit more coding, also ready-to-publish) tables.

*** 2a) The 'estout' package
* Step 0: since it is a user-written command, it should be installed first (if it has not been so far):
ssc install estout

* Step 1: previous stored results (if any) should be cleared from the memory:
eststo clear

* Step 2: the regressions should be run and stored:
eststo: regress lnhwage female /*stored as est1*/
eststo: regress lnhwage female age /*stored as est2*/
eststo: regress age female /*stored as est3*/
eststo: regress hwage age /*stored as est4*/

* Step 3: results should be displayed:
estout est1 est2 est3 est4

* Some formatting can also be added using options, e.g.:
     * Adding cells with some information 'cells()':
          * Displaying stars referring to significance and coeffs (called 'b') with three decimals: 'b(star fmt(3))'
	      * Displaying SEs also with three decimals in parentheses: 'se(par fmt(3))'
	 * Displaying R2 and number of observations: 'stats(r2 N)'
	 * Displaying the meaning of stars: 'legend'
	 
estout est1 est2 est3 est4, cells(b(star fmt(3)) se(par fmt(3))) stats(r2 N) legend

* We can also give names (using the 'title' option) to the models and display them (using the 'label' option later):
eststo clear
eststo, title("lnhwage"): regress lnhwage female /*stored as est1*/
eststo, title("lnhwage"): regress lnhwage female age /*stored as est2*/
eststo, title("age"): regress age female /*stored as est3*/
eststo, title("hwage"): regress hwage age /*stored as est4*/

estout est1 est2 est3 est4, label /*Check the result!*/

* For further formatting options, check the help menu:
help eststo

*** 2b) The 'outreg2' command
* With 'outreg2' we can create compact tables and export them easily to Excel or to LaTex.
* 'outreg2' is also a user-written command, so first it should be installed.
ssc install outreg2

* Let us start with a basic example: running a regression, then export the results to a .txt file:
regress lnhwage female
outreg2 using "results" /*Check the new file in your default folder.*/

* Now, let us continue with some important options and running more sepcifications:
regress lnhwage female
outreg2 using "results", replace bdec(3) /*Overwriting the existing file, and displaying coeffs (b) with 3 decimals.*/

regress lnhwage female age
outreg2 using "results", append bdec(3) /*Appending new results to the existing file.*/

regress age female
outreg2 using "results", append bdec(3) excel /*Creating an Excel file.*/

* Check again your default folder, and open the Excel file created. Fancy, isn't it? 
