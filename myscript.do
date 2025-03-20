*Purpose: Teaching
*Owner: Leah
*Date: Feb 2025
*Added to git for version control

import excel "/Users/amye/Library/CloudStorage/OneDrive-Personal/1. Leah's PhD/Quant analysis-Manar/Data for practice.xlsx", sheet("Data") firstrow clear

*browse //81 observations, 16 variable
*browse 

*DATA CLEANING AND MANAGEMENT

*1. CATEGORICAL VARIABLES
*Checking components of variable and missing data

tab Disease, m   //I am putting ,m because i want to see how many observations are missing in the variable "Disease"
*Varible need to be cleaned


*Correcting errors on categorical variables
*A. Replacing text using new variable
* (i) Create new variable 
generate disease_new = Disease //you can alse use "gen"
tab disease_new 

*(ii) Replace text
replace disease_new = "Diabetes and hypertension" if disease_new == "DiabetesHypertension"
tab disease_new, m

/*
*B. Replacing incorrect text by encoding
*Encoding transforms text into numeric values
*(i)Encoding
encode Disease, generate(disease2)
tab disease2, m
tab disease2, nolabel //you can also use "nol" instead of "nolabel"

*(ii)Recode the wrong text
recode disease2 3=2
recode disease2 4=3 //recoding to keep label in sequence
tab disease2, m 
tab disease2, nol 

*/
*H/W Check and clean the remaining categorical variables


*2. NUMERICAL VARIABLES
*Checking quality of variable and missing data

* (i) Checking plausible range
summa sbp  //try to check the min and max

*Note: you can see here how many observations have sbp values, this will give you an idea of how many may be missing

*(ii) Summarising data
	*Detailed statistics
	summarize sbp, det 

	*Checking variable distribution
	*histogram sbp  //checking distribution 
	*hist sbp, norm  //this will add normal line to histogram and you can visually see whether the data is normally distributed or not

*(iii) Checking missing data
count if missing(LDL) //will show how many people are missing from variable
misstable summarize LDL


*Dealing with errors and missing values
*(i) Correcting errors
	*Replacing incorrect values
	replace hba1c="." if hba1c=="y"  //try to check the min and max
	destring hba1c, replace  //since hba1c was string, change it to numerical which is the correct data format
	
*(ii)Imputing missing values
	*mean imputation
	*Note: Before imputing, note down the mean and at least one ID with missing so you can later cehck if the command worked 
	*mean hba1c=9.00375, missing ID FAC4001
	replace hba1c=r(mean) if missing(hba1c) 



*3. DATES
*Common commands
	*Convert string to date
	rename date entrydate //renaming the variable to remove confusion with command

	*Extract components:
	gen entryyear = year(entrydate)
	gen entrymonth = month(entrydate)
	gen entryday = day(entrydate)

	*Create date variables:
	gen intervention_date= mdy(01,01,2023)

*Date calculations
	gen exitdate = mdy(02,20,2025) //creating this so we can have two dates for substraction

	*Calculating differences
	gen fuptime = exitdate - entrydate

	*Adding or substracting days
	gen timetorecruitment=entrydate-30

*Formatting dates
format intervention_date %tdNN/DD/YYYY



gen dob2=date(dob, "MDY")
drop dob
rename dob2 dob
format dob %tdNN/DD/CCYY

*Create age
gen ageyrs=round(((entrydate-dob)/365),2)



list intervention_date in 1/5  //listing 5rows since the data is big



*Association between hba1c and BMI
regress hba1c bmi


*adding this for git


