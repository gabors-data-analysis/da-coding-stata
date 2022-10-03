***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 08 ******************************************************
***********************************************************************************************************************
********************************************* Working with more datasets **********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** Definitions
*** Master vs. using data
     * Master data: the dataset that is currently in the memory.
     * Using data: other dataset(s) that you would like to combine with the master data.
	 * Note that all the files should be .dta files.
	 
*** Adding rows (observations) vs. adding columns (variables)
     * For adding new observations, we should use the 'append' command.
	 * For adding new variables, we should use the 'merge' command.

	 
*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec08_moredatasets/"


*************** Vertical combining: APPEND
*** Introduction 
     * The game-level data in our case study "Identifying Successful Football Managers" on pp. 40 is... 
     * ... originally available in many .csv files - one .csv for each season... 
	 * ... In this exercise let us combine years 2016, 2017, and 2018...
	 * ... In a latter lecture we learn how to combine even more years much easier - using loops.
 
*** Preparing datasets
* Let us first open the .csv files from OSF and save them as .dta files
import delimited "https://osf.io/ad9zg/download", clear

browse 
   * As you can see from the date variable, it is season 2016/17...
   * ... As it can also be seen, each observation (row) in the data table is a single game...
   * ... Let us now save it, and then do the same for the next two seasons.
count /*380 observations*/

save "football_season201617.dta", replace

import delimited "https://osf.io/b5fvd/download", clear
browse 
count /*380 observations*/
save "football_season201718.dta", replace

import delimited "https://osf.io/4skqc/download", clear
browse 
count /*380 observations*/
save "football_season201819.dta", replace

*** Appending
* So, as we saw, we have three datasets with the same structure, but different observations. Let us combine them.
* We will always count the number of observations as we go on in order to see the cahnges.

clear

* First, define a master data by opening it:
use "football_season201617.dta"
count /*380*/

* Then let us append data of season 2017-18 (the general syntax is: append using filename):
append using "football_season201718.dta"
count /*760*/

* Finally, et us append data of season 2018-19:
append using "football_season201819.dta"
count /*1140*/

* Now we have the data of all the three seasons in one dataset.

*** Important notes
* Let us now make some important technical notes about the append command.

* 1) The order of variables in the two datasets is irrelevant. Stata always appends variables by name.

* 2) The identicality of the variable lists in the two datasets is not necessary. If variable X is presented...
     * ... only in one of the datasets, values will be missing for all the observations coming from the other dataset...
	 * ... If you check for example variables -lbh-, -lbd- and -lba- in the previously appended football dataset, they are... 
     * ... presented only in tha master data and using data 1,... 
	 * ... so they are missing for all the observations coming from using 2.
	 
* 3) The master-using relationship: 
	 * The master data takes precedence over the using data, and so overrides the using data's definitions:
		* This extends to value labels, variable labels, characteristics, and date–time stamps.
		* If there are conflicts in numeric storage types, the more precise storage type will be used... 
	      * ... regardless of whether this storage type was in the master dataset or the using dataset.
		* If a variable is stored as a string in one dataset that is longer than in the other, the longer...
	      * ... str# storage type will prevail.
		* If a variable is a string in one dataset and numeric in the other, Stata issues an error message... 
	      * ... unless the 'force' option is specified.

* 4) Using the 'generate' option we are able to mark the source of the observations. Let us try the following:
use "football_season201617.dta", clear
append using "football_season201718.dta", generate(sourcefile)
browse
* As you can see, now the last column is called -sourcefile-, containing zeros (master) and ones (using).

* 5) We can append more using files at the same time:
use "football_season201617.dta", clear
append using "football_season201718.dta" "football_season201819.dta"
* As a useful practice, do the same but with using the 'generate' option. Take a look at the sourcefile variable.
use "football_season201617.dta", clear
append using "football_season201718.dta" "football_season201819.dta", generate(sourcefile)
browse


*************** Horizontal combining: MERGE
*** Introduction 
     * In Chapter 20 we use some employee-level data to measure the effect on preformance of letting..
	 * ... workers work from home. The original data comes in more datasets. Let us first take a look at them.

copy "https://osf.io/t7kvp/download" "whm_empdata1.dta", replace
use "whm_empdata1.dta", clear
describe
* As you can see, we have some information about 249 employees in this dataset.

* Moreover, -personid- is the unique identifier of the employee:
isid personid

copy "https://osf.io/e8dz7/download" "whm_empdata2.dta", replace
use "whm_empdata2.dta", clear
describe
* We have some more (personal and performance-related) information about the employees in this dataset.
isid personid /*-personid- is a unique identifier here, as well.*/

*** Merge 1:1
* So, we have two datasets with (presumably) the same employees, but with different pieces of information (i.e. variables).

* Let us combine the two datasets:
use "whm_empdata1.dta", clear

merge 1:1 personid using "whm_empdata2.dta"
  * 1:1 (one-to-one) means here that one observation from the master is merged with one observation from the using.
     * We will see other types of merge (1:m and m:1) later.
  * -personid- is a variable (can be more variables) that uniquely identifies observations both in the master and the using.
  * using "whm_empdata2.dta" refers to the data on disk that is the using data during the merge process.
  
* Merge presents a table after its execution that reports on the successfulness of merging:
     * All the observations are matched here, so all the observations appear both in master and using.
	 * Please note that the table tells only whether an obs appears in both datasets or not, and tells nothing...
	      * ... about the other variables (and their values).
	 * If you check the Variables Window, you can realize that a new variable, called -_merge- was generated.
	      * It can take 3 values (with some options - see later - 5 values):
		       * _merge=1: obs appears only in the master data
			   * _merge=2: obs appears only in the using data
			   * _merge=3: obs appears both in master and using

* Some other examples for 1:1 merge could be the followings:
     * In one dataset you have GDP data for countries, while in another dataset population data.
	 * You observe products, and in one dataset you store their offline prices, in another one their online prices.
	 * You observe firms and store their balance sheet data and profit and loss statement data in two datasets.
	
*** Merge 1:m or m:1
* Let us now take a look at a third dataset from the WHM case study:
copy "https://osf.io/rz4cy/download" "whm_empdata3.dta", replace
use "whm_empdata3.dta", clear
describe
* We have -personid- here as well, but the dataset contains 112279 obs, instead of 249 as before.

* Let us check the -personid- variable:
isid personid /*variable -personid- does not uniquely identify the observations*/ 

* The observation here is not an employee, but an employee-week (a particular employee on a particular week):
isid personid year_week

* Let us see the structure:
sort personid year_week

browse
* So now a 1:1 merge would be wrong, we would like to match one obs with many obs:
     * Many master obs (employee i in time t) will be matched to one using obs (employee i), ...
	 * ... this is a many-to-one, i.e. m:1 merge:
merge m:1 personid using "whm_empdata1.dta"
* As you can see the feedback table:
     * We have 18751 matched obs (employee-weeks), and... 
	 * ... we have 93528 non-matched - appears only in the master - obs (employee-weeks)...
	 * ... It means that we have employees in the master that are not presented in the using. How many?
codebook personid if _merge==1 /*Number of unique values: 1685 employees*/

* Finally, we should have 249 employees that are matched. Let us check it:
codebook personid if _merge==3

* Please note that 1:m and m:1 merge are the same, the choice depends only the choice (definition) of master and using...
* ... In out previous example, if whm_empdata3.dta is the using and whm_empdata1.dta is the master, then we have a 1:m merge.

* Some other examples for 1:m or m:1 merge could be the followings:
     * One dataset contains household-level data, while the other one contains individual-level data on the household members.
	 * One dataset contains the continent of countries, while the other one contains yearly GDP data of the countries.

*** Important notes
* Let us now make some more important technical notes about the 'merge' command.
* 1) It can happen that some variables appear in both master and using. 
     * In this case master overrides the using data's definitions (as it was in the case of 'append').
	 * Although, with some options we can change it:
	      * the 'update' option: update missing values of same-named variables in master with values from using.
		  * the 'replace' option: replace all values of same-named variables in master with nonmissing values from using.
          * In this case, codes 4 and 5 can also appear in the -_merge- variable.
		  
* 2) m:m merge also exist, although its usage should be avoided, even the official documentation says that it "is a bad idea".


*************** Other commands to combine datasets
*** There are some other commands that produces special combinations...
*** ... Since they are just rarely used, we do not discuss them here, their help menu can be checked in case of need.
*** 'joinby': forming all pairwise combinations within groups.
*** 'cross': forming pairwise combinations.


*************** Deleting files
* Finally, let us delete the unnecessary files:
erase "football_season201617.dta"
erase "football_season201718.dta"
erase "football_season201819.dta"
erase "whm_empdata1.dta"
erase "whm_empdata2.dta"
erase "whm_empdata3.dta"
