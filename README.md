# Stock-Analysis
The goal of our analysis is to statistically analyze if stock prices and stock indices are sensitive to Fibonacci ratios.

The problem can be broken down as follows:
1. From the large amounts of available data (stock prices and indices), extract the sub-set pertaining to the NIFTY 50 stocks.
– I used Hive for this.

2. Using the NIFTY 50 stock data extracted in step 1, do the following for ALL the NIFTY 50 stocks and NIFTY index:
a) Identify the “legs” of the stock movement.
b) Identify the leg as “up” or “down” and also its “vertical height”.
c) For each leg, calculate the retracement ratio with respect to the previous leg.
d) On the data thus generated, do further analysis to identify the most occurring / favoured retracement ratios.

# Outputs:
1. A .csv file for each scrip (eg. LT, TATAMOTORS, etc.) containing the following leg data:
• stock_id, leg_no,start candle serial number, start date of leg, start price, end candle serial number, end date of leg,
  end price, leg height,leg direction
Example:
– LT,1,1,01-01-2010,455,5,05-01-2010,478,23,up
– LT,2,5,05-01-2010,478,8,08-01-2010,466,12,down

2. A .csv file for each scrip containing the following ratio data for all the consecutive legs:
• stock_id, previous leg number, current leg number, ratio of leg heights(current leg height / previous leg height)
– eg: LT,1,2,0.5217
