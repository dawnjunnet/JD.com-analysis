## EFFECT OF APP ON FIRST PARTY QUANTITIES SOLD
**Aim:** The aim of this report is to study the relationship between channels JD.com used and the quantity of the first party owned items sold

**Method:** The data on orders.csv and clicks.csv were used for transactions conducted on March 2018. Items with original unit price were dropped to avoid NaN observations when obtaining of the rate of discount. A Poisson regression was used to estimate the effects of channels on type 1 quantities sold and the rate of discount was later added in further regressions. A logit model was also conducted to examine the relationship between channel and probability of having more than 1 quantity sold.

**Result:** Designating app as the base channel, using ‘other’ channel and ‘pc’ instead of app increases quantity of sales by 0.193 and 1.00 respectively. However, using ‘mobile’ and ‘wechat’ instead of the app decreases sales by 0.057 and 0.174 respectively. After taking into account effects of discounts, results still provided similar results albeit at a smaller degree. All results are statistically significant (p<0.001).

## METHODS AND DATA
This report used March 2018 transactions on JD.com. Orders database was filtered for type 1 items and then inner joined with clicks database by ‘sku_ID’ and ‘user_ID’ to input the channel column. Channel column was changed to factor to show the quantity sold by each channel. Summary of the data is shown in Figure 1 of the appendix. The quantity column seem to follow a power law distribution.

![](images/regression.png)

Discount rate was used instead of absolute value dollar of the discount using the formula discount rate=(Discount price)/(original unit price). Therefore, observations wherein original unit price is 0 was removed as these might have been errors. Discount rate observations were accordingly saved under direct_discount_per_unit', 'quantity_discount_per_unit' and 'bundle_discount_per_unit'. Columns pertaining to date and unique identification numbers for items and customers were removed as it was not utilised. The quantity column was dichotomised to impute the value of 1 for quantity sold more than 1 and 0 otherwise. Thereafter the values were saved in a column called ‘quantity_more’. 

PRELIMINARY ANALYSIS
Scatterplot of the distribution of quantity sold is shown in Figure 3. We can see that ‘app’ and ‘pc’ are the most common channel users use to obtain type 1 goods. 

When channels are grouped according to ‘quantity_more’ column, it still showed that for quantities greater than 1, the app is still the most popular channel used by users (Figure 4).

In Figure 5, it can be seen that the average direct discount was highest at ‘other’ channel for both quantities sold more than once and otherwise. 

Unsurprisingly average quantity discount is more common for quantity sold more than one for all channels (Figure 6) with ‘other’ channel having the highest mean discount. 

As for gift discount, the app channel was the only medium used in the final dataset (Figure 7). It is noteworthy that there are only 5 observations wherein an item was given as a gift. 

The effects of bundle discount on channels was not graph as the median observation is 0 and the mean being 0.005339. The observations are then close to 0 thus it is difficult to show relationship through graph. 

REGRESSION ANALYSIS
A Poisson model was used as quantities sold are discrete observations thus it is more appropriate to use this model instead of an OLS regression which is more suitable for continuous variable. 

Marginal effects of the Poisson model are shown in Figure 8 which showed that using mobile and wechat, instead of an app, decreases the quantity sold through by 0.057 and 0.168 respectively. Using other and pc instead of the app increases sales by 0.195 and 1.05 respectively. The AIC score is 4246000. When the four type discounts were also taken into account (Figure 9), using mobile and wechat instead of app decreases quantity sold by 0.01 and 0.06 respectively. Using others and pc instead of app increases quantities sold by 0.09 and 1.02. Taking the discounts into consideration dampen the effects of each channel. The AIC score is 4170000. Both regressions have statistically significant results.

When the dependent variable was changed to quantity – 1 to account for Poisson’s limits {0 to positive real numbers} or quantity sold being zero, the absolute value of the marginal effects of the channel was reduced (Figure 10). Using mobile and wechat instead of app still decreases quantity sold by 0.057 and 0.173 respectively while using others and pc increases sales by 0.193 and 1.00 respectively. The AIC score is 3078000. When discounts were taken into consideration and dependent variable is quantity-1 (Figure 11), using mobile and wechat instead of app decreases sales by 0.016 and 0.072 respectively while using others and pc instead of app increases quantities sold by 0.066 and 0.741 correspondingly. The AIC score is 2797000.
