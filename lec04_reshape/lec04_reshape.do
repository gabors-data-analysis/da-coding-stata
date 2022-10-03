***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 04 ******************************************************
***********************************************************************************************************************
*************************************************** Reshaping data ****************************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec04_reshape"

*************** Copying and opening data
*** We use the worldbank-immunization-panel.dta file here, so first let us copy it to our computer:
copy "https://osf.io/download/ku4fd/" "worldbank-immunization-panel.dta"

*** Now let us open it:
use "worldbank-immunization-panel.dta", clear

*** Let us check the data:
browse
*** As you can see, now it is in long structure. Next, we will re-structure this data into wide format.


*************** Reshaping
*** Let us first define the steps of reshaping in general:

* Step 1: Determining whether our data is now long (then we can go to wide) or wide (then we can go to long).
     * You should define the aim-structure after the reshape command.
     * Now we have a long structure, so we can go to wide.
	 
* Step 2: Determining the logical observation, i.e. the group identifier.
     * You should define this variable using option 'i()'.
     * Now it is a country identifier, so we can use either -c-, -countryname-, or -countrycode-.
	 
* Step 3: Determining the subobservation, i.e. the within-group identifier.
     * In case of a long structure we do not have such a variable, it will be created by the 'reshape' command.
     * You should define this variable using option 'j()'.
     * Now it is time, so we can use the -year- variable.
	 
* Step 4: Determining the so-called stubnames, which are the stub of the variables to be converted (reshaped).
     * You should define it after 'reshape' and the aim-structure.
     * Now they are the following ones: -pop-, -mort-, -surv-, -imm-, -gdppc-, and -lngdppc-.
	 
* Step 5: Execute the reshape according based on the previous steps.

* So, let us reshape our data to wide accordingly:
reshape wide pop mort surv imm gdppc lngdppc, i(countrycode) j(year)

*** Let us check the data:
browse
*** Now it is in wide.


*************** Getting back to the original structure
*** If you have done a reshape, and you would like to get back to the original structure, ...
* ... just simply type 'reshape' and the original structure. Here for example:
reshape long

browse
*** Now it is in long again.


*************** Common mistakes
*** Let us now mention the most common mistakes. Reshape will fail if:
     * The data are in the wide form, and the 'i()' variable has non-unique values.
	 * The data are in the long form, and the 'j()' variable has non-unique values within 'i()'.
	 * The data are in the long form, and a variable that is not listed as stub is not constant.

	 
*************** Two important notes
*** The 'reshape error' command after trying to reshape a data lists problematic observations if 'reshape' fails.

*** 'reshape' also works for string 'j()' values. In your homework you are invited to solve a string case.
