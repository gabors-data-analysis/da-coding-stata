***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 03 ******************************************************
***********************************************************************************************************************
********************************************** Preparing data for analysis ********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "da-coding-stata/lec03_preparation/"


*************** Logging
*** Preparation (and also the analysis later) should be done in a way that it is easy to trace,...
*** ... repeat and reproduce. Traceability needs documenting our work...
*** ... One possible approach for documentation is logging, which can be done with a log file...
*** ... A log file stores (saves) everything that appears in the main window.

*** Let us launch a log file at this point:
log using "myfirstlogfile.smcl", replace 
* The 'replace' option means that we will overwrite the log file if it already exists.

*** At the end of the lecture we will close the log file.


*************** Copying and opening the dataset
copy "https://osf.io/download/dn8je/" "hotels-vienna.dta", replace
use "hotels-vienna.dta", clear


*************** The data table
*** Let us take a look at the data table itself:
browse

*** As you can see, the structure of the data table is the following:
	* Observations (here, hotels) are stored in the rows.
	* Variables (-hotel_id-, -country- etc.) are stored in the columns.
	
*** You can also realize that the values of some variables are red, while some others are black:
	* Black color means that the values are numerical (numbers).
	* Red color means that values are stored as stings.
		* It can happen that in fact they are number, but somehow they are stored as string.
		* For string numbers see for example the ratingta variable's values in rows 1, 2, 3 etc.
	* In fact a third color can also appear: blue, which means numerical content with some labels.

	
*************** The variables at a glance
*** After taking a look at the data table, let us also check the variables:
describe
*** As you can see, there are 428 observations (rows) and 24 variables (columns) in our dataset.

*** You can see some pieces of information about the variables. The most important ones are the following:
	* name (that you can use to refer to the variable)
	* storage type: 
		* byte, int, long, float and double are numerical variables with different precision
		* str is string content, and the number refers to its length
		* a detailed description can be found typing: 'help data_types'
	* labels (variable and value) are also important, we will get back to them later in this lecture
	* Under the table you can find a part "Sorted by..."...
	* ... It shows based on what variables are your observations are sorted...
	* ... Now, first based on city, if there are duplicates in -city-, then based on -hotel_id- etc.

	
*************** Sorting and ordering
*** As we have mentioned before, observations are now sorted by -city-, -hotel_id- etc. 

*** Suppose that we would like to see the hotels sorted by their user ratings, so:
sort rating
*** Check the browse window. Or, you can also type 'describe', and check the bottom of the table.

*** If we would like to sort in a descending order, we should type
gsort- rating
*** Check again the browse window.

*** We are focusing on -rating- now, so why not moving it to the first column?
order rating
*** Check the browse window again, and as you can see that -rating- is in the first column.

*** Note: We can use more than one variable as well with 'sort', 'gsort-', and 'order'.
	
	
*************** The identifier
*** As it was mentioned before, observations are stored in the rows...
*** ... In most datasets we also have a variable that uniquely identifies the observations...
*** ... Here we can have a feeling that this unique identifier is the variable called -hotel_id-. Let us check it:
isid hotel_id

*** If the particluar variable is not a unique identifier, Stata warns us, otherwise it remains silent.
*** Based on the silence after 'isid hotel_id', -hotel_id- is a unique identifier.

*** Let us check whether country is a unique identifier:
isid country
*** As we expected, no, it is not: variable -country- does not uniquely identify the observations.

*** 'isid' can be used with more than one variable, for example,...
*** ... 'isid country city' will test whether -country- and -city- together can uniquely identify the observations:
isid country city
*** Still not...


*************** Duplicates
*** If a variable (or a group of variables) cannot serve as a unique identifier,...
*** ... it means that we have duplicates based on that variable(s)...
*** ... Duplicates mean: multiple rows with the same values of the particular variable(s).

*** Let is analyse the variable price:
isid price 
*** As you can see, -price- is not a unique identifier, we have more hotels with the same price. Investigate it.
duplicates report price
*** We have 73 -price- vaules which are unique, 31 values that appear twice (the same for two hotels) etc.

*** With 'duplicates examples' you can list one example for each group of duplicated observations.
duplicates examples price

*** We can also tag the duplicated observations:
duplicates tag price, generate(dupl)
browse
*** As you can see, a new variable (called -dupl-) was created,...
*** ... which represents the number of duplicates for each observation.

*** We can of course remove the duplicated observations (we will not do this now) using the 'duplicates drop' command.

*** Note that all the 'duplicates' commands can be used with more than one variable (as in the case of the 'isid').
	
	
*************** Discovering missing values
*** As we have done the entity resolution by now, let us move on to another important aspect: missing values.

*** Let us still focus on the -price- variable, and check whether it contains missing values.
codebook price
*** 'codebook' is a command to present some descriptive statistics - see in Lecture 05 -,...
*** ... here we focus on just one piece of information it generates: the number of missings.
*** As it can be seen, -price- contains no missing values.

*** Codebook can be used for more than one variables:
codebook price distance stars rating_count
*** The -rating_count- variable contains 35 missing values, while all the other variables have zero missings.

*** IMPORTANT note: 
     * Check the 'browse' window, and you will realize that in the case of numerical variables, ...
	 * ... a missing value is represented by a dot (.)
     * Although here all the values of all string variables are non-missing (check it with 'codebook'),...
	 * ... they can be missings as well, of course. In missing string cells nothing appears.
	 
*** How to deal with missing values? ...
*** ... According to the book, we can either drop the problematic observations or do imputation... 
*** ... We will see the programming side of these sloutions later.


*************** Labeling 
*** "Order is the key to all problems." - writes Dumas, and yes, labels help you to create order.

*** In order to easy handling, it is advisable to give short names to variables in Stata,...
*** ... and store all relevant information somewhere else. Somewhere else can mean labels.

*** According to the Excel sheet called VARIABLES (that you can find at OSF) -rating- means "User rating average"...
*** ... Let us attach this piece of information to the variable by creating a label.
label variable rating "User rating average" 

*** 'label variable' is the command for labeling variables:
     * First you should define the name of the variable to label, ...
	 * ... then the label itself between " ".
	 
*** We can label also values of variables...
*** ... For that, we should define the value labels, then attach it to the values of a variable.
*** Let us see an example: ...
*** ... the variable -offer- is a dummy indicating whether there is an offer for that particular room or not...
*** ...If you check the browse window, you can see that the variable contains 0s and 1s.

*** Let us first define the value labels:
label define yesno 0 "no" 1 "yes"
     * 'label define' is the command itself,...
	 * ... then the name of the value labels (yesno) we are creating,...
	 * ... then a value (0), then its label (no),...
	 * ... then the next value (1), then its label (no) etc.
	 
*** Then attach this to the variable offer:
label values offer yesno

*** Let us now check the browse window:...
*** ... values of the variable -offer- are now presented in blue - we can see the labels (yes or no),...
*** ... but there are numbers behind (try to click in a cell, and check it).
browse

*** Finally, you can label the dataset itself (up to 80 characters):
label data "Dataset contains information on hotels, hostels, and others from Vienna, 2017."

*** Where do we see this label?
*** Execute the 'describe' command, and check the top right corner.


*************** Notes
*** A great advantage of labels that they are always visible ...
*** ... in the Variables window, or in the Properties window, or in the Browse window...
*** ... On the other hand, the quantity and length of labels are limited...
*** ... Notes can ease this problem. Let us attach a note to the dataset.
note: Data was collected using a web scraping algorithm.

*** Let us attach another note.
note: Data refers to the same weekday night in November, 2017.

*** Now we have to notes attachd to the dataset, but how can we see them? Let us type the following:
notes
*** This command shows all the notes we added... 
*** ... Although, clicking the small + sign near notes in the Properties window also makes them visible.

*** We can also add time stamps using 'TS', to make traceability even more efficient:
note: TS I added some labels and notes today.

*** Notes can be attached to the variables as well.
note ratingta: This is the average user rating via Tripadvisor.
*** Let us check all the notes again.
notes

*** Notes (that become irrelevant) can also be dropped. Let us drop the first note attached to the dataset.
notes drop _dta in 1


*************** Saving
*** Let us save the dataset.
save "hotels-vienna_prep.dta", replace


*************** Closing the log
*** Finally, let us close the log file we launched at the beginning.
log close
