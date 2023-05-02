WITH orders AS (
    select
        $1 as order_id,
        $2 as customer_id,
        $3 as order_date,
        $4 as product_id,
        $5 as unit_price,
        $6 as quantity,
        $7 as total_price
        
    FROM staging.dewale_analytics.ORDERS_TABLE
),
reviews AS (
    select	
        $1 as review,
        $2 as product_id

   FROM staging.dewale_analytics.REVIEWS_TABLE
),
shipment_deliveries AS (
    select
        $1 as shipment_id,
        $2 as order_id,
        $3 as shipment_date,
        $4 as delivery_date

    FROM staging.dewale_analytics.SHIPMENT_DELIVERIES_TABLE
),
merged as(
    select * from shipment_deliveries
    left join orders using (order_id)
    
),
all_shipments as(
    SELECT * FROM merged 
)
select * from all_shipments