{% set year_nums = '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'%}

{% set year_names= 'jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'%}
select 

{% for (nums,names) in zip(year_nums,year_names) %}

         (SELECT COUNT(YEAR_NUM)  FROM {{ref('dim_date')}} WHERE MONTH_OF_THE_YEAR_NUM = {{nums}} AND DAY_OF_THE_WEEK_NUM >=1 AND DAY_OF_THE_WEEK_NUM <=5  AND WORKING_DAY = 'FALSE' ) as tt_order_hol_{{names}}

        {% if not loop.last %}
            ,
        {% endif%}
   
{% endfor %}