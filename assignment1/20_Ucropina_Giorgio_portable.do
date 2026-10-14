* Portable copy of the submitted Assignment 1 code - Giorgio Ucropina
* Run this file with assignment1 as Stata's working directory.

* Preliminaries to see the dataset.

use "Data_Public Managers.dta", clear
browse

// 1st TASK: mean and sd of the income

*PART-A: mean value and the standard deviation of the income: single imputation with mean. I clone the income variable, then create a variable with the mean of income, then use the mean to replace the missing values. 

clonevar income_meanimp = income
summarize income, meanonly
replace income_meanimp = r(mean) if missing(income)
summarize income_meanimp

*PART-B: mean value and the standard deviation of the income: single imputation with regression. Income is our dependent variable. We will proceed by selecting the variables which may explain the best income patterns and use them as independent variables (we also check their correlation). N.B.: Since it was told us it'd be fine to include predictors with missing values and still have few missing values after predicting income, I include them in the regression. In the BlackBoard Assignment I'll report che value of the third regression for both mean and standard deviation.

correlate
misstable patterns

clonevar income_regimp1 = income
regress income age gender 
predict income_hat1 if missing(income)
replace income_regimp1 = income_hat1 if missing(income)
summarize income_regimp1

clonevar income_regimp2 = income
regress income age gender areaofbirth
predict income_hat2 if missing(income)
replace income_regimp2 = income_hat2 if missing(income)
summarize income_regimp2

clonevar income_regimp3 = income
regress income age gender areaofbirth level_edu
predict income_hat3 if missing(income)
replace income_regimp3 = income_hat3 if missing(income)
summarize income_regimp3

* If I do not want any missing values, I can replace the missing values in the predictors with the mode...

clonevar income_regimp4 = income
clonevar areaofbirth2 = areaofbirth
clonevar level_edu2 = level_edu

egen mode_areaofbirth = mode(areaofbirth)
egen mode_level_edu = mode(level_edu)

replace areaofbirth2 = mode_areaofbirth if missing(areaofbirth)
replace level_edu2 = mode_level_edu if missing(level_edu)

regress income age gender areaofbirth2 level_edu2
predict income_hat4 if missing(income)
replace income_regimp4 = income_hat4 if missing(income)
summarize income_regimp4

// 2nd TASK: estimate the difference of mean of Public Top Managers' income splitting them into two groups: younger or older than 54.5. Report the difference, and the probability that such a difference is different from zero.

gen agegroup = 0
replace agegroup = 1 if age >= 54.5
ttest income_regimp4, by(agegroup)

// here the ttest shows pvalue is almost 0, meaning  you must reject H0 that means are equal. Considering results: the mean income for managers <54.5 years is 141515, while for those >=54.5 years it is 167374.6 (reasonable older employees are paid more). The difference in means is D = (141515 –  167374.6) = -25859.57. Null hp. is not accepted.

// 3rd TASK: Answer to the question whether there is a sampling error of the gender variable.
table gender
describe gender
