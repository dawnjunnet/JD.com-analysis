library(readr)
orders <- read_csv("orders.csv")
order1 = orders[orders$type == 1,]
View(order1)
clicks <- read_csv("clicks.csv")
View(clicks)
library(dplyr)
library(mfx)
library(ggplot2)
d = inner_join(order1,clicks,by=c('sku_ID','user_ID')) #to obtain channel column for each type 1 purchase
clean_data = dplyr::select(d,c(quantity,original_unit_price,final_unit_price,direct_discount_per_unit,
                  quantity_discount_per_unit,bundle_discount_per_unit,coupon_discount_per_unit,
                  gift_item,channel))
View(clean_data)
clean_data$channel = as.factor(clean_data$channel) #to see how much quantity sold for each channel
summary(clean_data) #no missing data
plot(clean_data$channel,clean_data$quantity) #plot of observations of quantity and channel
qplot(clean_data$channel)
vec = c('direct_discount_per_unit','quantity_discount_per_unit',
        'bundle_discount_per_unit')
filter = clean_data$original_unit_price == 0
clean_data = clean_data[!filter,] #drop observations where original price = 0
for (char in vec){
 name = paste(char,'rate',sep = '_')
 clean_data[name] = clean_data[char]/clean_data$original_unit_price
}

summary(clean_data) #no Na values
channel_effect = poissonmfx(quantity~channel, data = clean_data)
channel_effect$fit
#AIC: 4246000
channel_effect2 = poissonmfx(quantity-1~channel, data = clean_data)
channel_effect2$fit
#AIC: 3078000
reg_effect = poissonmfx(quantity~channel + direct_discount_per_unit_rate + 
                          quantity_discount_per_unit_rate + bundle_discount_per_unit_rate, data = clean_data)
reg_effect$fit
#AIC: 4170000
reg_effect2 = poissonmfx(quantity-1~channel + direct_discount_per_unit_rate + 
                          quantity_discount_per_unit_rate + bundle_discount_per_unit_rate, data = clean_data)

#AIC: 2797000 thus this is a better poisson model
logit_effect = logitmfx(quantity_more~channel, data = clean_data)
logit_effect$fit
#AIC: 1343000
logit_effect2 = logitmfx(quantity_more~channel + direct_discount_per_unit_rate + 
           quantity_discount_per_unit_rate + bundle_discount_per_unit_rate, data = clean_data)
#AIC: 1224000

model = glm(quantity-1~channel + direct_discount_per_unit_rate + 
              quantity_discount_per_unit_rate + bundle_discount_per_unit_rate, data = clean_data, family = 'poisson')
model2 = glm(quantity~channel + direct_discount_per_unit_rate + 
               quantity_discount_per_unit_rate + bundle_discount_per_unit_rate, data = clean_data, family = 'poisson')
