***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 13 ******************************************************
***********************************************************************************************************************
**************************************************** Making graphs ****************************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** Intro
* There are two kinds of graphs in Stata: 
     * univariate graphs show the distribution of one variable: bar charts, histograms, pie charts, box plots etc.
	 * twoway (bivariate) graphs show the relationship between two variables: scatter, line, area etc.
* Typing 'help graph' gives an overview about graphs in Stata.
help graph
* In this lecture we focus on twoway graphs. The logic of oneway graphs is really similar to twoways.

*************** The default folder
*** Defining the default folder
cd "C:\bekeskezdi_stata\lec13_graphs\"

*************** Copying and opening data
*** We use the Hotels in Vienna data, introduced in Case Study 1.A1, and...
*** ... we reproduce Figures 7.5 (page 183) and 7.7 (page 186). 
copy "https://osf.io/dn8je/download" "hotels-vienna.dta", replace
use "hotels-vienna.dta", clear

*************** Sample selection
*** Let us start with the sample selection in order to get the same results as in the case study. We do the same ...
*** ... as we did at the beginning of Lecture 10:
* Keeping accommodations from Vienna:
keep if city_actual == "Vienna" 
* Keeping hotels:
keep if accommodation_type == "Hotel"
* Keeping hotels with 3, 3.5, or 4 stars:
keep if stars == 3 | stars == 3.5 | stars == 4
* Dropping a hotel with extremely high price:
summarize price, detail
drop if price == 1012
count /*207 observations remained*/

*************** Reproducing Figure 7.5 step by step
* Let us start with a basic graph without any scaffolding:
graph twoway (scatter price distance)
* 'graph twoway' is the main command, then, in parenthesis, we should define the type of the chart first (scatter) and then...
* ... the variable of the Y axis, and the the variable of the X axis.

* Adding the linear regression line:
graph twoway (scatter price distance) (lfit price distance)
* In another parenthesis, we can define another chart, here a linear regression line.
* Now, we are ready with the main graph. From this point we will make only changes in the main graph, and so, we will use options.
* The logic is that the option should be attached to that element that we would like to change.

* Changing the color of the dots and the regression line:
* The aim is to change the color of the dots (markers), and the color of the regression line,...
* ... so we put the adequate options near to the 'scatter' and the 'lfit' commands.
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green))
* mcolor means marker color, while lcolor means line color.

* Naming the X and Y axes:
* Now we would like to change the main part (skeleton) of the graph, so we put the options accordingly:...
* ... we attach the options to the skeleton, i.e. to the 'graph twoway'.
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)")

* Setting values of the X and Y axes, and adding grid lines:
* Again, we are going the alter the skeleton itself (while with the 'grid' option we alter the axes).
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)") ///
	xlabel(0(1)7, grid) ylabel(0(50)400, grid angle(horizontal))
		
* Removing legend:
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)") ///
 	xlabel(0(1)7, grid) ylabel(0(50)400, grid angle(horizontal)) ///
	legend(off)

* Adding title and subtitle:
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)") ///
	xlabel(0(1)7, grid) ylabel(0(50)400, grid angle(horizontal)) ///
	legend(off) ///
	title("Hotel price by distance to the city center", color(black)) subtitle("linear regression and scatterplot", color(black))

* Adding note:
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)") ///
	xlabel(0(1)7, grid) ylabel(0(50)400, grid angle(horizontal)) ///
	legend(off) ///
	title("Hotel price by distance to the city center", color(black)) subtitle("linear regression and scatterplot", color(black)) ///
	note("Source: hotels-vienna dataset. Vienna, November 2017, weekday. N=207.")

* Saving as .gph:
graph twoway (scatter price distance, mcolor(blue)) (lfit price distance, lcolor(green)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)") ///
	xlabel(0(1)7, grid) ylabel(0(50)400, grid angle(horizontal)) ///
	legend(off) ///
	title("Hotel price by distance to the city center", color(black)) subtitle("linear regression and scatterplot", color(black)) ///
	note("Source: hotels-vienna dataset. Vienna, November 2017, weekday. N=207.") ///
	saving("figure_7_5.gph", replace)
* Please note that .gph files can be interactively edited using the clicking method in the Graph Editor...
* ... It is useful when you would like to change an element, but you do not know its name. You can look for it in the Graph...
* ... Editor, and after finding it, you can check the help menu or online sources in order to write the adequate code.
	
* Exporting graph as a .png file:
graph export "figure_7_5.gph", as(png) replace width(3200) height(2400)	

* Hopefully, the logic is clear now, so we can make a step further, and reproduce Figure 7.7.

*************** Reproducing Figure 7.7 step by step
* Here we would like to highlight the five most underpriced hotels, so first let us identify them.
regress price distance
predict res, resid
sort res
list res in 1/5 /*We are interested in the five smallest residual.*/
generate mostunderpriced = 0
replace mostunderpriced = 1 if res < -51.05
tabulate mostunderpriced, missing
* Now we have a dummy variable showing the observations wthat we would like to highlight on the graph, so we can start plotting.

* The starting point is the same: we create the main graph:
graph twoway (scatter price distance) (lfit price distance)

* Now, let us divide the observations into two groups and make two charts of them: ...
* ... one for the highlighted obs, and another for the rest:
graph twoway (scatter price distance if mostunderpriced == 0) ///
	(scatter price distance if mostunderpriced == 1) ///
	(lfit price distance)
	
* Let us now change the colors:
graph twoway (scatter price distance if mostunderpriced == 0, mcolor(blue)) ///
	(scatter price distance if mostunderpriced == 1, mcolor(yellow) mlcolor(black)) ///
	(lfit price distance, lcolor(green))
	
* Now, add the arrow with the note (as in the figure in the textbook) as a seperate chart:
graph twoway (scatter price distance if mostunderpriced == 0, mcolor(blue)) ///
	(scatter price distance if mostunderpriced == 1, mcolor(yellow) mlcolor(black)) ///
	(lfit price distance, lcolor(green)) ///
	(pcarrowi 25 2 50 1.15 "Most underpriced hotels", color(black) mlabcolor(black))
* 'pcarrowi' draws an arrow with some text:
     * The first two numbers are the coordinates (Y and X) of the starting point of the arrow.
	 * The second two numbers are the coordinates (Y and X) of the arrow head.
	 * The last element is the text itself.
	 * 'color()' changes the color of the arrow, wihle 'mlabcolor()' (= marker label color) changes the color of the text.
	
* Finally, we can do the same scaffolding as with Figure 7.5, so just simply copy-paste it here:
graph twoway (scatter price distance if mostunderpriced == 0, mcolor(blue)) ///
	(scatter price distance if mostunderpriced == 1, mcolor(yellow) mlcolor(black)) ///
	(lfit price distance, lcolor(green)) ///
	(pcarrowi 25 2 50 1.15 "Most underpriced hotels", color(black) mlabcolor(black)) ///
	, xtitle("Distance to city center (miles)") ytitle("Price (US dollars)") ///
	xlabel(0(1)7, grid) ylabel(0(50)400, grid angle(horizontal)) ///
	legend(off) ///
	title("Hotel price by distance to the city center", color(black)) subtitle("linear regression and scatterplot", color(black)) ///
	note("Source: hotels-vienna dataset. Vienna, November 2017, weekday. N=207.") ///
	saving("figure_7_7.gph", replace)
