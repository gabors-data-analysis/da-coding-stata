***********************************************************************************************************************
***********************************************************************************************************************
***************************************************** Lecture 10 ******************************************************
***********************************************************************************************************************
************************************************** Regression basics **************************************************
***********************************************************************************************************************
***********************************************************************************************************************

*************** The default folder
*** Defining the default folder
cd "C:\bekeskezdi_stata\lec10_regression_basics\"

*************** Copying and opening data
*** We use the Hotels in Vienna data, introduced in Case Study 1.A1 and used in many other case studies later.
copy "https://osf.io/dn8je/download" "hotels-vienna.dta", replace
use "hotels-vienna.dta", clear

*************** Research question
*** We analyze hotels, and...
*** ... our research question is whether there is an association between price and distance from the city center.
*** We fix the level of significance at 5%. 

*************** The linear regression
*** We are going to reproduce some results of case studies 7.A2, and 7.A3 (and later 7.A1), so let us start with sample selection...
*** ... We follow the steps presented in the second paragraph of case study 7.A1:
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

*************** Correlation
* Let us first calculate the correlation coefficient between 'price' and 'distance':
pwcorr price distance /*The coeff is: -0.3963.*/
* We can also indicate the significance of the coeff with a star using the 'star' option:
pwcorr price distance, star(0.05) /*It is significant.*/
* Or, we can display the level of significance itself:
pwcorr price distance, sig

*** Please note that there is another command for calculating correlation coefficients: 'correlate'
     * 'correlate' displays correlation matrix or covariance matrix.
	 * 'pwcorr' displays pairwise correlation coefficients.

*************** Linear regression
*** We can run a linear regression using the 'regress' command: regress depvar [indepvars] [if] [in] [weight] [, options]
regress price distance
*** As you can see, we have all the important results in the output table:
     * The number of observations is 207.
	 * The R2 is 0.157 (rounded to 0.16 in the book on page 192).
	 * The coefficient of 'distance' is -14.4 (rounded to -14 in the book on page 183).
	 * We can also see the results of the t-tests with their p-values, and also the confidence intervals (discussed in chapter 9).

*************** Referring to the regression sample
*** It can happen that not all the observations are included in our regression model...
*** ... For example, Stata automatically omits all the observations that have missing values for any regression variables...
*** ... We can refer to the sample of the last regression we ran using the 'e(sample)' stored result...
*** ... Let us count the number of obs included in the regression we ran before... 
*** ... (Of course, we know that it should be 207, as was indicated in the regression table.)
count if e(sample)

*************** Obtaining predictions and residuals
*** Let us now predict price based on the model (E(y|x)):
predict price_hat /*A new variable was generated that contains the fitted values.*/

*** Let us now calculate the residuals:
* We use 'predict' here as well, but with the 'residuals' option:
predict res, residuals
* Of coures, we can calculate residuals also manually using the predicted values:
generate res_manual = price - price_hat

*** Please note that different influental statistics (Section 8.9) can also be calculated using the 'predict' command,...
*** ... check the help for details:
help regress_postestimation 

*************** Including qualitative variables in the regression models
*** Section 10.9 introduces the usage of qualitative variables as right-hand-side variables. The solution: dummmy variables.
*** The are two basic ways to include a set of dummy variables in our regression model:
     * 1) Generating the dummies and the include them.
	 * 2) Include the dummies without generating them.
*** Let us investigate whether the -rating- matters, but we will use a qualitative rating variable, so first let us generate it:
summarize rating, detail
generate rating_quali = "low" if rating <= 3.5
replace rating_quali = "moderate" if rating > 3.5 & rating < 4.5
replace rating_quali = "high" if rating >= 4.5
tabulate rating_quali, missing
* In most cases we will need a quantified version of this variable, so let us encode it:
encode rating_quali, gen(rating_quali_num)
	 
* 1) Generating the dummies and the include them in the regression model
* Using the 'tabulate' command with the 'generate' option, we can generate the necessary dummy set:
tabulate rating_quali, gen(drating_quali)
* As you can see, 3 dummy variables were created. Let us include them (of course, one is dropped automatically):
regress price distance drating_quali*

* 2) Include the dummies without generating them
* Using the 'i.' operator, we can include dummy variables without generating them (string variables cannot be used):
regress price distance i.rating_quali_num

* This 'i.' operator give us more opportunity, so it is worth using. For example:
* a) We can show the reference category in the output table:
set showbaselevels on
regress price distance i.rating_quali_num
* b) We can set the reference category (let it be the moderate rating, coded as 2)...
* ... Note that we use 'b.' (~base) instead of 'i.':
regress price distance b2.rating_quali_num

*************** Including interaction terms in the regression models
*** Section 10.10 introduces the usage of interaction terms. Let us see some examples:

* 1) Categorical by categorical interactions
* We will use 'offer_cat' as well here:
tab offer_cat, missing
* It is a string variable, so let us encode it:
encode offer_cat, gen(offer_cat_num)
* The interaction:
regress price distance rating_quali_num##offer_cat_num

* 2) Categorical by continuous interactions
* We should use the 'c.' operator to refer to continuous variables. Categorical is assumed by default - see our previous example.
regress price distance rating_quali_num##c.stars

* 3) Continuous by continuous interactions
regress price distance c.rating##c.stars /*We use the original -rating- variable here.*/
* Please note that polynomials (Subsection 8.7) can also be added in this way, e.g. the quadratic form of -distance-:
regress price c.distance##c.distance

*************** Robust standard errors
* Subsection 9.2 introduced the phenomenon of heteroskedasticity and the definition of robust SE.
* Robust SE can be easily calculated using the 'vce(robust)' option:
regress price distance, vce(robust)

*************** The lowess non-parametric regression
* Using the 'lowess' command, we can run regressions like the one on Figure 7.3:
lowess price distance , bwidth(0.8)
