***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 02 ******************************************************
***********************************************************************************************************************
********************************************** Opening and saving datasets ********************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** At the bottom left part of the Stata platform you can see the default folder...
*** ... Stata uses this folder to open and save files...
*** ... Although, you can define a new default folder using the 'cd' command:
cd "C:\bekeskezdi_stata\lec02_open_save\"

*************** Opening an Excel file (and some practice of the language)
*** You should use the 'use' command to open .dta files, ...
*** ... and you have the 'import' command for all other commonly used formats (.xls or .xlsx, .csv, .txt, etc.).

*** Let us start with importing the managers_epl.xlsx...
*** ... which contains some data about football managers (see case studies 2.C1 and 2.C3 in Chapter 2).
*** We will build this syntax step by step to see to logic of the language of Stata.
import excel using "managers_epl.xlsx" /*'import', filetype, 'using', then the name of the file*/
*** It is important to note that you should be aware whether your file is an .xls or an .xlsx...
*** ... You should define the extension accordingly, otherwise an error message will occur.
*** Let us now check the data table: 
browse
*** As you can see, the first sheet of the Excel file is imported (it is the default)... 
*** ... Suppose that we would like to import the EPL championship data, i.e. the second sheet,...
*** so modify the syntax accordingly:
*** As you may remember from Lecture 1, the command itself does the main job...
*** ... On the other hand, options of the command can be used to slighly alter the final result...
*** ... Let us use the 'sheet' option to import the second sheet instead of the first one:
import excel using "managers_epl.xlsx", sheet("efl-championship")
*** You may realize that we get an error message: 'no; data in memory would be lost':
*** Stata tries to protect the users from themselves,...
*** ... and if they have a dataset in the memory (now we have the first sheet) Stata force them to:
     * either drop the dataset from the memory ('clear' option)
	 * or save the dataset.
*** Let us no drop it, since we do not need it, so change the syntax again:
*** The main task is still the same: importing data, but we need another alteration, i.e. clearing the memory.
*** So, let us use another option, the -clear- option:
import excel using "managers_epl.xlsx", sheet("efl-championship") clear
*** IMPORTANT note: the order of the options is irrelevant in Stata,...
*** ... so import excel using "managers_epl.xlsx", clear sheet("efl-championship") is also okay.
*** Let us again check the data table: 
browse
*** Now we are almost ready, since we have the second sheet open, but there is still a problem: ...
*** ... Stata interpreted the names of the variables (first row of our Excel file)...
*** ... as an observation (they appear in the first row in Stata).
*** As a final step, let us fix this problem using the 'firstrow' option:
import excel using "managers_epl.xlsx", sheet("efl-championship") clear firstrow
browse
*** And now, we are ready. Let us save this data as a .dta file using the 'save' command.

*************** Saving data as .dta
*** We also use the 'replace' option that forces Stata to overwrite the file if it already exists.
save "managers_epl.dta", replace
*** Then let us clear the memory.
clear

*************** Opening a .dta file
*** We can open a .dta file using the 'use' command.
*** Let us open the managers_epl dataset we saved before.
use "managers_epl.dta" 
*** Please note that 'clear' can be used as an option as well, so the following is also okay:
use "managers_epl.dta", clear

*************** Copying data from the web
*** It is also possible to copy files from the internet to your computer, and then open them.
copy "https://osf.io/download/y6jvb/" "hotels-vienna.csv", replace
*** After the 'copy' command, first you should define the online path where the file is stored,...
*** ... then you have to define a name used for the copied file.
*** Note that the path you should define in case of files stored at osf.io could be collected by...
*** ... clicking the three dot button in the top right corner...
*** At the same time, in most cases you should simply copy-paste the address from the URL from the address bar.

*************** Opening a .csv file
*** Now, let us import the Hotels in Vienna dataset we downloaded before:
import delimited "hotels-vienna.csv", clear
*** Some important notes:
     * Stata checks by default if the file is delimited by tabs or commas based on the first line of data.
	 * Although, in case of other delimiters, you should use the 'delimiters' option to define the delimiter. 
	 * There is no firstrow option, like we had in the case of an .xls or .xlsx...
	 * ... By default, Stata tries to determine whether the file includes variable names...
	 * ... Using the 'varnames(#)' option you can specify the row (#) in which variable names can be found,...
	 *... and Stata will ignore (not import) the rows before #.

*************** Opening data directly from webpages and online storages	 
*** Note that data can be imported directly from the web (without downloading it in advance).
*** For example, the .csv we imported in the previous section can be opened directly from gaborsdata's OSF.
import delimited "https://osf.io/y6jvb/download", clear
*** Other files (.dta, .xls etc) can also be opened directly from the web.
*** For example, let us open a dataset about cars from Stata's webpage. 
use "http://www.stata-press.com/data/r17/auto.dta", clear
*** Datasets from the Stata website can be opened even easier, simply using the 'webuse' command, without any URLs:
webuse "auto.dta", clear
*** It is worth noting that there are some online databases that can be reached via Stata commands, for example: 
     * FRED: 'freduse'. Video tutorial: https://www.youtube.com/watch?v=CegDUU-eFGM
	 * World Bank: 'wbopendata'. Tutorial: https://blogs.worldbank.org/opendata/accessing-world-bank-open-data-stata

*************** Saving and exporting data
*** As we showed before, a .dta file can be saved with the 'save' command.
*** Although, if you would like to save data as an Excel, or delimited, you should use the 'export' command... 
***... Options are similar to the ones we discussed in the case of 'import'.

*************** Communicating with your computer via Stata
*** There are some commands that can be helpful when you open and save data:
     * You can create or remove folders: 'mkdir', 'rmdir'.
	 * You can also create (copy from somewhere else) or delete files: 'copy', 'erase'.
	 * You can list the names of files in the specified directory: 'dir' or 'ls'.
	 * You can deal with zip files: 'zipfile', 'unzipfile'.
	 * You can send commands to your operating system: 'shell'.
*** You are invited to use some of these commands in your homework assignment.

