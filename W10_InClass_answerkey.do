cd "C:\Users\Gabe\Dropbox\Drop_Docs\Tulane\Teaching, TA, and RA\STATA Lab Fall 2024\Week 10 (Midterm Review and Binary Outcomes)\Week 10 Directory"
*change this to your class folder with class_data.xlsx in it

import excel using class_data.xlsx, clear sheet(Sheet2) firstrow
browse

*			WE WANT TO EXPLORE THE EFFECT OF SEX ON SURVIVAL USING LPM, PROBIT, AND LOGIT

*Q1) Run a Linear Probability Model for the effect of being a female on the probability of survival. Don't include any controls and use robust standard errors. Note: you will need to construct a numerical variable where female is the 1 value and 0 is the male value. What is the predicted probability of survival for females? For males? What is the predicted effect of being a female on the probability of survival? Is the coefficient on female statistically significant (and how do you know)?

gen female =.
replace female=1 if Sex=="female"
replace female=0 if Sex=="male"
tab female Sex

reg Survived female, robust
/* 
------------------------------------------------------------------------------
             |               Robust
    Survived | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      female |   .5531301   .0296163    18.68   0.000      .495004    .6112562
       _cons |   .1889081    .016314    11.58   0.000     .1568897    .2209266
------------------------------------------------------------------------------
predicted probability of Survival for females: Pr(Survived==1) = .189 + .55(1) = .739
predicted probability of Survival for males: Pr(Survived==1) = .189 + .55(0) = .189
predicted effect of being a female on the probability of survival = .55 (notice that this is the coefficient because this is a linear regression)
coefficient on female is statistically significant (large t-stat, small p-value, 0 not in CI)
*/



*Q2) Run a logit model for the effect of being a female on the probability of survival. Don't include any controls and use robust standard errors. What is the predicted probability of survival for females? For males? What is the predicted effect of being a female on the probability of survival? How do the predicted probabilites and predicted effect of being female here compare to the results for the LPM?

logit Survived female, vce(robust)
/*
------------------------------------------------------------------------------
             |               Robust
    Survived | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
      female |    2.51371   .1672722    15.03   0.000     2.185862    2.841557
       _cons |   -1.45712   .1064132   -13.69   0.000    -1.665686   -1.248554
------------------------------------------------------------------------------
predicted probability of Survival for females: Pr(Survived==1) = 1/(1+e^-(-1.5 + 2.51(1))) = .733 predicted probability of Survival for males: Pr(Survived==1) = 1/(1+e^-(-1.5 + 2.51(0))) = .182
predicted effect of being a female on the probability of survival = .733 - .182 = .551
these answers are VERY close to the answers from the LPM!

*/



*Q3) Run a probit model for the effect of being a female on the probability of survival. Don't include any controls and use robust standard errors. What is the predicted probability of survival for females? For males? What is the predicted effect of being a female on the probability of survival? How do the predicted probabilites and predicted effect of being female compare to the results for the LPM and logit? Use this link (https://www.danielsoper.com/statcalc/calculator.aspx?id=55) for the standard normal CDF calculator.

probit Survived female, vce(robust)
/*
------------------------------------------------------------------------------
             |               Robust
    Survived | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
      female |   1.531569    .097385    15.73   0.000     1.340698     1.72244
       _cons |   -.881927   .0602979   -14.63   0.000    -1.000109   -.7637452
------------------------------------------------------------------------------
predicted probability of Survival for females: Pr(Survived==1) = phi(-.88 + 1.53(1)) = phi(.66) = .75
predicted probability of Survival for males: Pr(Survived==1) = phi(-.88 + 1.53(0)) = phi(-.88) = .19
predicted effect of being a female on the probability of survival = .75 - .19 = .56
once again, the results here are very close to the LPM and logit estimates
*/




*Q4) Why do we always want to estimate a logit/probit in addition to an LPM? LPMs are nice and easy to compute and interpret, so what is the problem with them? Will LPMs always give different answers than logit and probit?

*LPMs may be easy to compute and interpret, but they assume linearity, which means that LPMs can predict probabilities less than 0 and greater than 1 (obviously doesn't make sense). LPMs won't always give different answers than logit and probit, but we would only believe an LPM estimate if it was backed up by a logit or probit model.




*Q5) Regress female on Pclass. Interpret the coefficient and say whether it is statistically significant. What does this regression say about potential omitted variable bias in the regressions from Q1, Q2, and Q3? Rerun each of the regressions from Q1, Q2, and Q3 now controlling for Pclass. Why can we find a predicted effect of being female (holding all else constant) in the LPM but not in the logit or probit in this case? Compare the predicted probabilities of survival for all three models for females in 3rd class and males in 3rd class. What is the predicted effect in each model for a male becoming a female in 3rd class (effect of being female in 3rd class only). Compare the results from each model.

reg female Pclass, robust 
*a 1 unit increase in Pclass is associated with a 7.5% decrease in the number of females in that Pclass. the coefficient is statistically significant at all normal alpha levels, which tells use that there is a statistically significant relationship between female and Pclass. This tells us Pclass is likely an omitted variable in the previous regressions as it is correlated with both female and the probability of survival.

reg Survived female Pclass, robust
/*
------------------------------------------------------------------------------
             |               Robust
    Survived | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      female |   .5166696   .0292077    17.69   0.000     .4593454    .5739939
      Pclass |  -.1580341   .0167031    -9.46   0.000    -.1908162    -.125252
       _cons |   .5666015    .046142    12.28   0.000     .4760413    .6571616
------------------------------------------------------------------------------
We can read the effect of being female holding all else constant in the LPM because it is a linear regression model. We can't do this in the logit or probit models because they are non-linear, so the effect of female depends on Pclass. 
predicted probability of Survival for 3rd class females: Pr(Survived==1) = .57 + .52(1) - .158(3) = .616
predicted probability of Survival for 3rd class males: Pr(Survived==1) = 57 + .52(0) - .158(3) = .096
predicted effect of being a female on the probability of survival for 3rd class passengers  = .616 - .096 = .52 (coefficient because it is a linear regression)

*/
logit Survived female Pclass, vce(robust)
/*
------------------------------------------------------------------------------
             |               Robust
    Survived | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
      female |   2.643398   .1784954    14.81   0.000     2.293553    2.993243
      Pclass |  -.9605531   .1056051    -9.10   0.000    -1.167535   -.7535708
       _cons |   .6512436   .2278718     2.86   0.004     .2046232    1.097864
------------------------------------------------------------------------------
predicted probability of Survival for 3rd class females: Pr(Survived==1) = 1/(1 + e^-(.65 + 2.64(1) - .96(3))) = .601
predicted probability of Survival for 3rd class males: Pr(Survived==1) = 1/(1 + e^-(.65 + 2.64(0) - .96(3))) = .096
predicted effect of being a female on the probability of survival for 3rd class passengers  = .601 - .096 = .505
*/
probit Survived female Pclass, vce(robust)
/*
------------------------------------------------------------------------------
             |               Robust
    Survived | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
      female |   1.571343   .1002989    15.67   0.000      1.37476    1.767925
      Pclass |  -.5494851   .0586071    -9.38   0.000    -.6643528   -.4346174
       _cons |   .3617926    .137453     2.63   0.008     .0923897    .6311956
------------------------------------------------------------------------------
predicted probability of Survival for 3rd class females: Pr(Survived==1) = phi(.36 + 1.57(1) - .55(3)) = phi(.28) = .61
predicted probability of Survival for 3rd class males: Pr(Survived==1) = phi(.36 + 1.57(0) - .55(3)) = phi(-1.29) = .099
predicted effect of being a female on the probability of survival for 3rd class passengers  = .61 - .099 = .511
*/


*interestingly, the predicted probabilities and predicted effects are very similar for women in 3rd class regardless of the model! Notice that the predicted effect of being female will definitely change within 1st and 2nd class in the logit and probit models (non-linear) but should stay the same in the LPM (linear).




















