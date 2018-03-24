# REGSIM: Teaching Regression with Simulation
Simulation is an effective tool for teaching regression methods and computer coding skills useful in empirical social science research. 

The goal of this repository is to provide Stata simulation code useful for understanding commonly used regression models in social science research, including ordinary least squares, fixed effects, random effects, difference-in-differences, and regression discontinuity.

In this project, I adopt the following suggestions in Morris, White, and Crowther's (2017) discussion of using and reporting simulations in medical research:
1. Framework for describing the "target" or goals of a simualation study (Table 3 in their paper) and
2. Recommended plan for designing and reporting simulations (Table 1 in their paper).

# Goals
Morris et al. offer a framework for describing the goal(s) of a simulation study in terms of five statistical tasks:
1. **Estimation**
2. **Testing**
3. Model selection
4. Prediction
5. Study design

REGSIM provides code to explore tasks 1 and 2 in bold: estimation and testing.

## Estimation
The statsitical task of estimation seeks to produce an estimate of a regression coefficient. Consider the regression specification
> y = c + b1\*x1 + b2\*x2 + b3\*x3 + e

Here, b1, b2, and b3 are regression coefficients. They are also known as *estimands* because they are being estimated by the regression model. In contrast, x1, x2, and x3 are not estimands because they are known values constituting the data.

Assuming the regression specification is the true data generating process for the outcome variable *y*, the estimation task is to use data to generate estimates of b1, b2, and b3 that are equal to the underlying, true values of b1, b2, and b3. The underlying true values are known as *parameters*. Estimands are estimates of parameters. (Still with me?!)

A major challenge in regression analysis is determining how close each estimand comes to the true parameter value. This is where simulation can be very useful for understanding how close regression models come to correctly estimating parameters. The secret power of simulation is that we can know the true data generating process. In other words, we can know the true values of the parameters and compare the estimands to the parameter values. 

Knowing the parameter values allows us to use several different regression techniques and compare the estimands from each technique to the true parameter value. We can see that some regression techniques do better than others, and we can begin to understand how the context of the data and the mechanics of each regression technique combine to produce better or worse estimands, where better estimands are closer to the true parameter values than worse estimands.

For example, we can create data in which the above regression specification has the following parameter  values for the b's:
> y = 1 + 2\*x1 + 3\*x2 + 4\*x3 + e

We could then use regression techniques like ordinary least squares, random effects, fixed effects, or logistic regression to estimate b1, b2, and b3. We can then compare the estimates from each technique to our known paramater values of 2, 3, and 4, respectively, to better understand which technique produce estimands that are closest to the parameter values.

The difference between an estimand and the true parameter value is known as **bias** and is a major problem of regression analysis. Anyone using regression analysis must have a deep understanding of the causes of bias in regression analysis, and simulation is a powerful tool for teaching and demonstrating how bias arises and how it can be corrected.

##  Testing
Simulation can help teach and understand a second statistical task: testing. Testing refers to determining whether two values are the same or different. The classic testing problem in statistics is determining if the averages of two groups on some measure are equal or different. In simple randomized controlled trials, the two groups are a treatment group and a control group. For example, in medical research a treatment group would receive some medicine and the control group would receive a placebo. Imagine the researcher wants to know if the medicine reduces the number of headaches a person has. The researcher could measure the average number of headaches for each group and compare the two averages. If the treatment group has fewer headaches than the control group, on average, the researcher might conclude that the medicine does reduce the number of headaches. The statistical task of testing is about determining when the researcher can credibly claim that the two measures of average headache frequency are indeed different enough to indicate that the medicine has an effect on headaches.

Because testing is about determining when a difference is "enough", testing is a form of evaluating credibility.

# Plan



References
* Morris, T. P., White, I. R., & Crowther, M. J. (2017). Using simulation studies to evaluate statistical methods. Retrieved from http://arxiv.org/abs/1712.03198
