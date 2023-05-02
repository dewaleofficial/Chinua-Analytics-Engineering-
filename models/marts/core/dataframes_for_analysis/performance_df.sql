SELECT  *
FROM    (
SELECT $2 as product_id, 
SUM ($1)/COUNT($2) as aggregate
FROM staging.dewale_analytics.REVIEWS_TABLE
GROUP BY product_id
ORDER BY aggregate DESC
)