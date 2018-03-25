# REGSIM: Teaching Regression with Simulation
Simulation is an effective tool for teaching regression methods and computer coding skills useful in empirical social science research. The REGSIM repository contains Stata v15.1 code for teaching the following topics:
1. Omitted variable bias in estimation
2. Type 1 errros (a.k.a., false positives) in hypothesis testing

The code addresses the following regression models:
1. Ordinary least squares, 
2. Fixed effects,
3. Difference-in-differences, and
4. Regression discontinuity

I also briefly address random effects, hybrid, and correlated random effects models as described in Allison (2009) and Schunck (2013).

I use the following from Morris, White, and Crowther's (2017) article on simulations in medical research:
1. Framework for describing the "target" or goals of a simualation study (Table 3 in their paper) and
2. Recommended plan for designing and reporting simulations (Table 1 in their paper).

The remainder of this README is organized in the following sections. 'Simulation Goals' describes the statistical tasks of estimation and testing focused on in the simulations here. These two tasks are elaborated in 'Task 1' and 'Task 2'. These sections draw on Morris et al.'s Table 3. 'Simulation Plan' describes how each simulation is designed according to Morris et al.'s Table 1.

# Simulation Goals
Morris et al. offer a framework for describing the goal(s) of a simulation study in terms of five statistical tasks:
1. **Estimation**
2. **Testing**
3. Model selection
4. Prediction
5. Study design

REGSIM provides code to explore tasks 1 and 2 in bold: estimation and testing.

## Task 1: Estimation
The statsitical task of estimation seeks to produce an estimate of a regression coefficient. Consider the regression specification
> y = c + b1\*x1 + b2\*x2 + b3\*x3 + e

Here, b1, b2, and b3 are regression coefficients. They are also known as *estimands* because they are being estimated by the regression model. In contrast, x1, x2, and x3 are not estimands because they are known values constituting the data.

Assuming the regression specification is the true data generating process for the outcome variable *y*, the estimation task is to use data to generate estimates of b1, b2, and b3 that are equal to the underlying, true values of b1, b2, and b3. The underlying true values are known as *parameters*. Estimands are estimates of parameters. (Still with me?!)

A major challenge in regression analysis is determining how close each estimand comes to the true parameter value. This is where simulation can be very useful for understanding how close regression models come to correctly estimating parameters. The secret power of simulation is that we can know the true data generating process. In other words, we can know the true values of the parameters and compare the estimands to the parameter values. 

Knowing the parameter values allows us to use several different regression techniques and compare the estimands from each technique to the true parameter value. We can see that some regression techniques do better than others, and we can begin to understand how the context of the data and the mechanics of each regression technique combine to produce better or worse estimands, where better estimands are closer to the true parameter values than worse estimands.

For example, we can use simulation to create a dataset in which the above regression specification has the following parameter values for the b's:
> y = 1 + 1\*x1 + 2\*x2 + 3\*x3 + e

Here, the parameter values for b1 = 1, b2 = 2, and b4 = 3. These are the first 5 rows of a simulated dataset created using the regression specificaion with b1 = 1, b2 = 2, b3 = 3:

y|c|x1|x2|x3|e
-|-|--|--|--|--
0.9665	| 1	| -0.1967	| -1.0939	| 0.7359 |	0.1433
-0.7054 |	1 |	-0.3418 |	0.5311 |	-0.6637	 | -0.4349
-1.005478|1|1.178822|0.899235|-1.234552|-1.279113
-9.054642|1|0.1165438|-1.349642|-2.301884|-0.5662479
-2.498454|1|-1.557141|-0.4090332|-0.9207506|1.639005

The code to create the above dataset (all variables are created using the rnormal() function which draws psuedorandom values from a normal distribution with mean=0 and standard deviation=1 )
```
set seed 61047
set obs 50
gen c = 1
gen x1 = rnormal()
gen x2 = rnormal()
gen x3 = rnormal()
gen e = rnormal()
gen y = c + 1*x1 + 2*x2 + 3*x3 + e
order y, first
```

We could then use regression techniques like ordinary least squares, random effects, fixed effects, or logistic regression to estimate b1, b2, and b3. We can then compare the estimates from each technique to our known paramater values of 2, 3, and 4, respectively, to better understand which technique produce estimands that are closest to the parameter values.

We can use OLS regression on the data using:
> reg y x1 x2 x3

OLS regression produces these results:

y|Coef.|Std. Err.|t|P>t|\[95% Conf.|Interval]
-|-|-|-|-|-|-
x1|0.9048629|0.1864689|4.85|0.000|0.5295205|1.280205
x2|1.827036|0.1732623|10.54|0.000|1.478277|2.175794
x3|3.078995|0.181532|16.96|0.000|2.71359|3.4444
\_cons|0.9674033|0.1967596|4.92|0.000|0.5713469|1.36346

These results suggest the estimands for b1, b2, b3 are close to the parameter values of 1, 2, and 3 respectively. We know this because the estimand (coefficient estimate) for x1 is close to 1, for x2 is close to 2, and for x3 is close to 3 (these values come from the equation above used to generate y = 1 + 1\*x1 + 2*\x2 + 3\*x3 + e).

We can quickly preview the effect of omitted variable bias by leaving x3 out of the regression in Stata using:
> reg y x1 x2

producing:

y|Coef.|Std. Err.|t|P>t|[95% Conf.|Interval]
-|-|-|-|-|-|-
x1|0.4058605|0.4906248|0.83|0.412|-0.5811492|1.39287
x2|1.961568|0.4611748|4.25|0.000|1.033804|2.889332
\_cons|0.7056096|0.5226518|1.35|0.183|-0.3458303|1.757049

The estimand for b2 is still close, but b1 (the coefficient on x1) is now far too small, and the confidence interval suggests we cannot be certain b1 is not zero or even negative! b1's paramater value is 1. The difference between the estimand of 0.41 and the parameter value 1 is the omitted variable bias caused by omitting the b3 parameter from the OLS regression model. 

The difference between an estimand and the true parameter value is known as **bias** and is a major problem of regression analysis. Anyone using regression analysis must have a deep understanding of the causes of bias in regression analysis, and simulation is a powerful tool for teaching and demonstrating how bias arises and how it can be corrected.

## Task 2: Testing
Simulation can help teach and understand a second statistical task: testing. Testing refers to determining whether two values are the same or different. The classic testing problem in statistics is determining if the averages of two groups on some measure are equal or different. In simple randomized controlled trials, the two groups are a treatment group and a control group. For example, in medical research a treatment group would receive some medicine and the control group would receive a placebo. Imagine the researcher wants to know if the medicine reduces the number of headaches a person has. The researcher could measure the average number of headaches for each group and compare the two averages. If the treatment group has fewer headaches than the control group, on average, the researcher might conclude that the medicine does reduce the number of headaches. The statistical task of testing is about determining when the researcher can credibly claim that the two measures of average headache frequency are indeed different enough to indicate that the medicine has an effect on headaches.

# Simulation Plan




References
* Morris, T. P., White, I. R., & Crowther, M. J. (2017). Using simulation studies to evaluate statistical methods. Retrieved from http://arxiv.org/abs/1712.03198
