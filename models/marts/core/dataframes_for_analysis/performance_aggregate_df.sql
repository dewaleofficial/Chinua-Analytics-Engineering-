SELECT  *
FROM    (
SELECT PRODUCT_ID as product_id, 
SUM (REVIEW) as sum_reviews,
count (REVIEW) as count_reviews,
sum (CASE WHEN REVIEW = 1 THEN '1' ELSE '0' END) as one_star,
sum (CASE WHEN REVIEW = 2 THEN '1' ELSE '0' END) as two_star,
sum (CASE WHEN REVIEW = 3 THEN '1' ELSE '0' END) as three_star,
sum (CASE WHEN REVIEW = 4 THEN '1' ELSE '0' END) as four_star,
sum (CASE WHEN REVIEW = 5 THEN '1' ELSE '0' END) as five_star,
SUM (REVIEW)/COUNT(PRODUCT_ID) as aggregate
FROM staging.dewale_analytics.REVIEWS_TABLE
GROUP BY product_id
ORDER BY aggregate DESC
)