/***	Title:	Teaching Regression with Simulation
		By:		Nicholas Poggioli (poggi005@umn.edu)

		Code and documentation available at https://github.com/nicholaspoggioli/simreg
*/

/*	PROJECT OUTLINE
	

		1	Simulating data in Stata
		2	Creating and testing an OLS regression
		3	Creating and testing a fixed-effects OLS regression
		4	Possible extensions
*/

				***===============================***
				*	1	Simulating data in Stata	*
				***===============================***
/*
	Any simulation begins with simulating a dataset.
*/

***	SIMULATING DATA USING RANDOM VARIABLES
/*	Here we simulate a dataset of 500 observations on 500 firms. We create
	four variables in the dataset. One is a dependent variable, two are 
	independent variables, and one is a random error term.
	
	We generate the independent variables first.
*/
*	Set number of observations and seed for replicating random number generation
clear all
set obs 500
set seed 61047

*	Cross-sectional data: generate unique id for each observation
gen firm=_n		/*	_n is Stata code for the row number	*/

*	Generate variable: Independent variable firm size (size)
gen size = rnormal()

*	Generate variable: Independent variable R&D spending (rd)
gen rd = rnormal()

*	Generate variable: Random error
gen e = rnormal()


/*	We now have a dataset of observations of size, r&d spending, and a random error
	for 500 firms. What can we do with this dataset?
	
	First, remember this is simluated--i.e., fake--data. These are not real firms,
	and the variables are not true measures of the constructs.
	
	However, what we can do with these data is explore a basic regression model
	and the consequences of problems like omitted variable bias. We can learn
	how regression models work and why certain problems like OVB exist.
	
	The reason we can explore these problems is that we can create the "true" model
	relating our two independent variables size nd rd to our oucome of roa.
	
	When we use real data we find in existing datasets--for example, Compustat data--
	we don't know the true model that relates those variables to one another. We'll see
	why that creates regression problems.
	
	First, let's focus on a single problem: omitted variable bias
*/

***	Specifying the true model of ROA
/*
	Imagine the true relationship between roa, size, and rd is:
	
		roa = 1.8*size + 3*rd + 1*e
		
	This model says that a firm's ROA is equal to 1.8 times its size, 3 times its
	R&D spending, and 1 times a random error for each firm. 
	
	The random error reflects some degree of unpredictability in the world. If
	we did not include the error term e, roa would be entirely determined as a
	function of size and rd. The random error term captures unpredictability, and
	it is crucial that the error term is truly random and not associated in any
	systematic way with size or rd.
	
	Let's generate the true model of roa and explore omitted variable bias.
*/

*	Generate roa
gen roa = 1.8*size + 3*rd + e

*	Summarize variables
sum *

***	Exploring omitted variable bias in OLS regression

*	Correct specification
reg roa size rd
/*	We see that the estimated coefficients are close to the true value from our 
	equation above.

	Variable		Estimate		True value
	size			1.76			1.8
	rd				2.96			3

	When the regression equation matches the "true" model, the estimates
	are close to the true values.
	
	What happens if we omit one or more variables from the regression model
	that are in the "true" model?
*/

*	Misspecification
reg roa size
/*
	Variable		Estimate		True value
	size			1.52			1.8
	rd				omitted			3
*/
reg roa rd
/*
	Variable		Estimate		True value
	size			omitted			1.8
	rd				2.8				3
*/

/*	DISCUSSION
	We see in both cases that the estimates do not match the true values in the model.
*/
