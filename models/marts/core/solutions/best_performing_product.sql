select 
       (SELECT '{{ run_started_at.strftime("%Y-%m-%d") }}') as ingestion_date,
       (SELECT PRODUCT_ID FROM {{ref('performance_aggregate_df')}} LIMIT 1) as product_ID, 
       (SELECT date FROM (SELECT COUNT(ORDER_DATE) as count , ORDER_DATE as date
                FROM staging.dewale_analytics.ORDERS_TABLE
                WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM {{ref('performance_aggregate_df')}} LIMIT 1)
                GROUP BY ORDER_DATE
                ORDER BY count DESC) LIMIT 1) as most_ordered_day, 
       (SELECT SUM_REVIEWS FROM {{ref('performance_aggregate_df')}} LIMIT 1) as tt_review_points,
       (SELECT (ONE_STAR/count_reviews) *100 FROM {{ref('performance_aggregate_df')}} LIMIT 1) as pct_one_star_review,
       (SELECT  (TWO_STAR/count_reviews) *100 FROM {{ref('performance_aggregate_df')}} LIMIT 1) as pct_two_star_review,
       (SELECT  (THREE_STAR/count_reviews) *100  FROM {{ref('performance_aggregate_df')}} LIMIT 1) as pct_three_star_review,
       (SELECT  (FOUR_STAR/count_reviews) *100  FROM {{ref('performance_aggregate_df')}} LIMIT 1) as pct_four_star_review,
       (SELECT  (FIVE_STAR/count_reviews) *100 FROM {{ref('performance_aggregate_df')}} LIMIT 1) as pct_five_star_review,
       ((SELECT COUNT(ORDER_ID) FROM {{ref('early_shipment')}}
                WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM {{ref('performance_aggregate_df')}} LIMIT 1))/ ((SELECT COUNT(ORDER_ID) FROM {{ref('all_shipment')}}
                WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM {{ref('performance_aggregate_df')}} LIMIT 1)))*100) as pct_early_shipments,
       ((SELECT COUNT(ORDER_ID) FROM {{ref('late_shipments_df')}}
                WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM {{ref('performance_aggregate_df')}} LIMIT 1))/ ((SELECT COUNT(ORDER_ID) FROM {{ref('all_shipment')}}
                WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM {{ref('performance_aggregate_df')}} LIMIT 1)))*100) as pct_late_shipments

        
        