select 
        YEAR(order_date) as year_num, 
        month(order_date) as month_of_the_year_num,
        day(order_date) as day_of_the_month_num,
        dayofweek(order_date) as day_of_the_week_num,
         (CASE dayofweek(order_date) WHEN 0 THEN FALSE WHEN 6 THEN FALSE ELSE TRUE END) as working_day
        FROM staging.dewale_analytics.ORDERS_TABLE 