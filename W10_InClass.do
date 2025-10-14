cd "C:\Users\Gabe\Dropbox\Drop_Docs\Tulane\Teaching, TA, and RA\STATA Lab Fall 2024\Week 10 (Midterm Review and Binary Outcomes)\Week 10 Directory"
*change this to your class folder with class_data.xlsx in it

import excel using class_data.xlsx, clear sheet(Sheet2) firstrow
browse

*			WE WANT TO EXPLORE THE EFFECT OF SEX ON SURVIVAL USING LPM, PROBIT, AND LOGIT

*Q1) Run a Linear Probability Model for the effect of being a female on the probability of survival. Don't include any controls and use robust standard errors. Note: you will need to construct a numerical variable where female is the 1 value and 0 is the male value. What is the predicted probability of survival for females? For males? What is the predicted effect of being a female on the probability of survival? Is the coefficient on female statistically significant (and how do you know)?



*Q2) Run a logit model for the effect of being a female on the probability of survival. Don't include any controls and use robust standard errors. What is the predicted probability of survival for females? For males? What is the predicted effect of being a female on the probability of survival? How do the predicted probabilites and predicted effect of being female here compare to the results for the LPM?



*Q3) Run a probit model for the effect of being a female on the probability of survival. Don't include any controls and use robust standard errors. What is the predicted probability of survival for females? For males? What is the predicted effect of being a female on the probability of survival? How do the predicted probabilites and predicted effect of being female compare to the results for the LPM and logit? Use this link (https://www.danielsoper.com/statcalc/calculator.aspx?id=55) for the standard normal CDF calculator.



*Q4) Why do we always want to estimate a logit/probit in addition to an LPM? LPMs are nice and easy to compute and interpret, so what is the problem with them? Will LPMs always give different answers than logit and probit?



*Q5) Regress female on Pclass. Interpret the coefficient and say whether it is statistically significant. What does this regression say about potential omitted variable bias in the regressions from Q1, Q2, and Q3? Rerun each of the regressions from Q1, Q2, and Q3 now controlling for Pclass. Why can we find a predicted effect of being female (holding all else constant) in the LPM but not in the logit or probit in this case? Compare the predicted probabilities of survival for all three models for females in 3rd class and males in 3rd class. What is the predicted effect in each model for a male becoming a female in 3rd class (effect of being female in 3rd class only). Compare the results from each model.





















